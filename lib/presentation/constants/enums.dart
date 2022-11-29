enum QuestionnaireState {
  initial,
  loading,
  loaded,
  started,
  finished,
  remindOverTime,
  invalidTime,
  allCompleted
}

enum ResponsePart { all, isPost, isNotPost }

enum ConnectivityStatus { wifi, mobile, none }

enum DPStatus { notStarted, agree, disagree }

//*
enum ExpStatus { 
  NOT_STARTED, 
  RUNNING, 
  END 
}

enum RightIntroStatus{
  GENERAL,
  PRINCIPLE,
  PAY
}

enum AnswerIntroStatus{
  GENERAL,
  DEFINITION,
  AWARE,
  ACTION
}

enum ResponseStatus{
  NOT_YET,
  DONE,
  PASS,
  IMCOMPLETED,
}