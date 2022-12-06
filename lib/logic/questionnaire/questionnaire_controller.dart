import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:experience_sampling/data/apis/answers_api.dart';
import 'package:experience_sampling/data/apis/status_api.dart';
import 'package:experience_sampling/data/models/answer.dart';
import 'package:experience_sampling/data/models/default_config.dart';
import 'package:experience_sampling/data/models/new_answer.dart';
import 'package:experience_sampling/data/models/new_response.dart';
import 'package:experience_sampling/data/models/once_config.dart';
import 'package:experience_sampling/data/models/question.dart';
import 'package:experience_sampling/data/repositories/questionnaire_repository.dart';
import 'package:experience_sampling/data/storages/local_storage_service.dart';
import 'package:experience_sampling/logic/questionnaire/question_controller.dart';
import 'package:experience_sampling/presentation/constants/default_constants.dart';
import 'package:experience_sampling/presentation/constants/enums.dart';
import 'package:experience_sampling/presentation/reuse_util/util.dart';

class QuestionnaireController extends GetxController {
  final QuestionController questionController = Get.put(QuestionController());
  var isTestMode = false.obs;
  var hasStart = false;
  var hasStop = false;

  final QuestionnaireRepository repository = QuestionnaireRepository();
  var state = QuestionnaireState.initial.obs;
  var questions = <Question>[].obs;
  var answers = <Answer>[];
  var launchTimes = 0.obs;
  Rx<int?> currentIndex = 1.obs;
  var currentQuestion = Question().obs;
  var questionOrder = <int>[1];

  DateTime? startTime;
  DateTime? finishTime;

  @override
  void onInit() {
    super.onInit();

    int storedLaunchTimes =
        GetStorage().read<int>(DefaultConfigString.launchTimes) ?? 0;
    if (storedLaunchTimes != 0) launchTimes.value = storedLaunchTimes;

    ever(launchTimes, (_) {
      GetStorage().write(DefaultConfigString.launchTimes, launchTimes.value);
    });
    launchTimes.value += 1;
    initSettings();
    LocalStorage().writeLog(
        "${LogTag.questionnaire}, ${LogSubTag.done}, QuestionnaireController has been initialized");
  }

  @override
  void onClose() {
    GetStorage().write('questionnaireState', state);
    super.onClose();
    LocalStorage().writeLog(
        "${LogTag.questionnaire}, ${LogSubTag.done}, QuestionnaireController has been closed");
  }

  void toTestMode() {
    isTestMode.value = true;
    state.value = QuestionnaireState.started;
  }

  void toNormal() {
    isTestMode.value = false;
  }

  Future<void> initSettings() async {
    // ? divide into two function or not
    await initQuestions().then((_) => initAnswers());
    updateState(QuestionnaireState.loading);
    // wait half of a second
    await Future.delayed(Duration(milliseconds: 500));

    updateState(QuestionnaireState.started);
    startTime = DateTime.now();

    if (await canDoNow()) {
      state.value = QuestionnaireState.started;
    } else {
      state.value = QuestionnaireState.invalidTime;
    }
  }

  Future<bool> canDoNow() async {
    final config = OnceConfig.getInstance();
    bool isCurFileExist = await isCurrentFileExist();
    return config.expStatus == ExpStatus.RUNNING &&
        config.isValidTime &&
        !isCurFileExist;
  }

  Future<void> initQuestions() async {
    questions.value = repository.getDefaultQuestions();
    currentQuestion.value = questions[currentIndex.value! - 1];
    questionController.updateQuestion(currentQuestion.value);
  }

  // todo: read from local storage
  void initAnswers() async {
    int notificationID = OnceConfig.getInstance().getNotificationID();
    final localStorage = LocalStorage(destination: "new_id_$notificationID");

    if (await localStorage.isExist()) {
      answers = await localStorage.readLastTimeAnswers();
    } else {
      answers = questions.map((element) {
        return Answer(
          questionIndex: element.questionIndex,
          questionType: element.questionType,
          userAnswer: null,
          userAnswerString: null,
          userSubAnswer: null,
          multipleUserAnswer: null,
          multipleUserAnswerString: null,
        );
      }).toList();
    }

    questionController.resetAnswer(answers[0]);
    LocalStorage().writeLog(
        "${LogTag.questionnaire}, ${LogSubTag.done}, answer init success");
  }

  void toNextQuestion() {
    // Save user answer
    Answer currentAnswer = questionController.generateCurrentAnswerObject();
    answers[currentIndex.value! - 1] = currentAnswer;
    // Get next index
    var nextIndex = questionController.getNextIndex();

    if (nextIndex == -1) {
      // finishTime = DateTime.now();
      // final difference = finishTime!.difference(startTime!).inMinutes;

      // if (difference >= ConfigValue.overTime)
      //   state.value = QuestionnaireState.remindOverTime;
      // else
      state.value = QuestionnaireState.finished;
      return;
    }

    LocalStorage().writeLog(
        "${LogTag.questionnaire}, ${LogSubTag.index}, click to next question, currentIndex: ${currentIndex.value}");
    // Record the answering order
    questionOrder.add(nextIndex);

    // Intialize answer

    // Next Question
    currentQuestion.value = questions[nextIndex - 1];
    currentAnswer = answers[nextIndex - 1];
    currentIndex.value = nextIndex;

    // Send [currentQuestion] to [QuestionController]
    questionController.updateQuestion(currentQuestion.value);
    questionController.resetAnswer(currentAnswer);
  }

  void toLastQuestion() {
    if (currentIndex.value == 1) return;

    // Delete saved user answer
    resetSavedAnswer(answers[currentIndex.value! - 1]);
    LocalStorage().writeLog(
        "${LogTag.questionnaire}, ${LogSubTag.index}, click to last question, currentIndex: ${currentIndex.value}");

    // remove current index
    questionOrder.removeLast();

    // get current index
    int lastIndex = questionOrder.last;
    currentIndex.value = lastIndex;

    questionController.resetAnswer(answers[lastIndex - 1]);

    // Last Question
    currentQuestion.value = questions[currentIndex.value! - 1];

    // Send [currentQuestion] to [QuestionController]
    questionController.updateQuestion(currentQuestion.value);
  }

  void updateState(QuestionnaireState questionnaireState) {
    state.value = questionnaireState;
    LocalStorage().writeLog(
        "${LogTag.questionnaire}, ${LogSubTag.status}, currentState: ${state.value}");
    // init state
    if (questionnaireState == QuestionnaireState.started) {
      currentIndex.value = 1;

      currentQuestion.value = questions[currentIndex.value! - 1];
      questionController.updateQuestion(currentQuestion.value);
    }
  }

  Future<void> saveNewResponse() async {
    if (isTestMode.value) return;
    int notificationID = OnceConfig.getInstance().getNotificationID();
    String subjectID = DefaultConfig.getInstance().getSubjectID();
    String cache = DefaultConfig.getInstance().getCache();
    final localStorage = LocalStorage(destination: "new_id_$notificationID");
    DateTime now = DateTime.now();

    List<NewAnswer> newAnswers = answers.map((e) {
      return NewAnswer.fromAnswer(e);
    }).toList();
    NewResponse response = NewResponse(
        cache: cache,
        subjectID: subjectID,
        filledCount: notificationID,
        status: getForBackendStatus(),
        filledTime: Util.formatDateTime(now),
        answers: newAnswers);
    await localStorage.saveNewResponse(response);
    LocalStorage()
        .writeLog("${LogTag.answer}, ${LogSubTag.save}, new response");
  }

  Future<bool> isCurrentFileExist() async {
    int notificationID = OnceConfig.getInstance().getNotificationID();
    final localStorage = LocalStorage(destination: "new_id_$notificationID");
    if (await localStorage.isExist()) return true;
    return false;
  }

  Future<bool> sendNewResponses() async {
    int notificationID = OnceConfig.getInstance().getNotificationID();
    List<NewResponse> list = <NewResponse>[];
    for (int i = 0; i <= notificationID; i++) {
      final localStorage = LocalStorage(destination: "new_id_$i");
      NewResponse response;
      if (!(await localStorage.isExist())) {
        response = _createDefualtResponse(i);
      } else {
        response = await localStorage.readAnswers();
      }
      list.add(response);
    }
    LocalStorage().writeLog(
        "${LogTag.questionnaire}, ${LogSubTag.send}, sendNewResponses");
    return await AnswerAPI().postAnswers(list);
  }

  Future<bool> sendLocalFiles() async {
    if (OnceConfig.getInstance().expStatus == ExpStatus.END) {
      return await sendAllLocalFilesAfterFinished();
    }
    int notificationID =
        await LocalStorage.getCurrentNotificationIDWhenInvalid();
    if (notificationID == -1) {
      return false;
    }
    int notSentStartID = await getNotSentStartID();
    if (notSentStartID == -1) return false;
    print("start: $notSentStartID; end: $notificationID");
    List<NewResponse> list = <NewResponse>[];

    for (int i = notSentStartID; i < notificationID + 1; i++) {
      final localStorage = LocalStorage(destination: "new_id_$i");
      NewResponse response;
      if (!(await localStorage.isExist())) {
        response = _createDefualtResponse(i);
      } else {
        response = await localStorage.readAnswers();
      }
      list.add(response);
    }
    LocalStorage().writeLog(
        "${LogTag.questionnaire}, ${LogSubTag.send}, send local files");
    return await AnswerAPI().postAnswers(list);
  }

  Future<int> getNotSentStartID() async {
    var config = DefaultConfig.getInstance();
    String subjectID = config.getSubjectID();
    String cache = config.getCache();
    List statusList = await StatusAPI().getStatus(subjectID, cache);

    List<String> _statuses = List<String>.filled(56, "not_yet");
    try {
      for (var o in statusList) {
        var index = o["filledCount"];
        if (index >= 56) continue;
        _statuses[index] = o["status"];
      }
    } catch (e) {
      print("error: $e");
      LocalStorage().writeLog("status show error: $e");
    }

    for (int i = 0; i < _statuses.length; i++) {
      if (_statuses[i] == 'not_yet') return i;
    }
    return -1;
  }

  Future<bool> sendAllLocalFilesAfterFinished() async {
    List<NewResponse> list = <NewResponse>[];
    int notSentStartID = await getNotSentStartID();
    if (notSentStartID == -1) return false;
    for (int i = notSentStartID; i < 56; i++) {
      final localStorage = LocalStorage(destination: "new_id_$i");
      NewResponse response;
      if (!(await localStorage.isExist())) {
        response = _createDefualtResponse(i);
      } else {
        response = await localStorage.readAnswers();
      }
      list.add(response);
    }
    LocalStorage().writeLog(
        "${LogTag.questionnaire}, ${LogSubTag.send}, send local files");
    return await AnswerAPI().postAnswers(list);
  }

  NewResponse _createDefualtResponse(int id) {
    return NewResponse(
        cache: DefaultConfig.getInstance().getCache(),
        subjectID: DefaultConfig.getInstance().getSubjectID(),
        filledCount: id,
        status: "pass",
        filledTime: Util.formatDateTime(DateTime.now()),
        answers: _generateDefaultAnswers());
  }

  // todo: if add question need to modify
  List<NewAnswer> _generateDefaultAnswers() {
    List<NewAnswer> res = <NewAnswer>[];
    for (int i = 1; i <= 11; i++) {
      NewAnswer answer = NewAnswer(questionIndex: i.toString());
      res.add(answer);
    }
    return res;
  }

  void resetSavedAnswer(Answer savedAnswer) {
    savedAnswer.userAnswer = null;
    savedAnswer.userSubAnswer = null;
    savedAnswer.userAnswerString = null;
    savedAnswer.multipleUserAnswer = List.filled(8, 0);
    savedAnswer.multipleUserAnswerString = null;
  }

  void startQ() {
    hasStart = true;
  }

  void stopQ() {
    hasStop = true;
  }

  String getForBackendStatus() {
    if (hasStop) return "done";
    // else if (hasStart && !hasStop) return "uncomplete";
    return "pass";
  }
}
