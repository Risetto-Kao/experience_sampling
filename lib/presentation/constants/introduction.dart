// about dp
const welcomedpText = '''歡迎您參與本次研究數位足跡部分，由於研究目的與需要，我們希望收取您的以下資訊及資源。''';
const dpIntroductionText = '''所搜集的資料料將包括：
1. 您的數位足跡\n
2. 您的手機的感測器數值。
（此告示為修正後告示，非正式呈現給受試者之資訊）
''';
const onlyForResearch = '所有收集資料僅用於研究';
const dpIntroAgreeText = '若您同意請直接按下下方同意並開始收集資料按鈕，若不同意可直接忽略此頁面\n';
const dpIntroQuitText = '若您於開始收集資料後欲退出數位足跡的研究，請按下退出實驗並煩請通知實驗者，感謝！';

const dpDisagreeConfirmText = '您確定不同意參與本實驗嗎？\n按下確認後無法更改狀態';
const dpDisagreeText = '不同意參與實驗';
const dpAgreeText = '同意並開始收集資料';
const dpConfirmText = '確認訊息';
const dpStopText = '停止實驗';

const quitIntroduction =
    '''如欲退出整個實驗，按下下方按鈕後會將頁面引導至Email，請先連絡實驗者後待實驗者回覆再行刪除app''';
const dpQuitIntroduction = '''若您於資料收集啟動以後，決定退出數位足跡之研究，請點選退出實驗按鈕並通知研究者，十分感謝!''';

const homepageIntro = '''
請先連上網路\n
並且點選下方按鈕前往基本設置中完成個人設定
''';

const sendMailIntro = '''
感謝您參與本研究\n\n
有任何疑問或需要協助之處\n
請點選下方按鈕發送信件
''';

const initialSettingText = '初始設定(首次設定完無法再行改動)';
const elseText = '其他設定';
const settingStartedTimeText = '設定起始時間';

class DPIntroduction {
  static const notStarted = '研究狀態：尚未開始實驗';
  static const agree = '研究狀態：實驗進行中';
  static const disagree = '研究狀態：不參與實驗';
  static const error = '研究狀態：錯誤情形，請通知實驗者';
}

const experimenterEmails = 'test@gmail.com';
String problemEmailTitle(String subjectID) => '[$subjectID]ESM APP問題或回饋';
String problemEmailBody(String subjectID) =>
    '您的編號：$subjectID\n您遇到的問題或回饋是：\n建議您可以附上手機截圖，以利我們更加了解您遇到的狀況，謝謝';

String endEmailTitle(String subjectID) => '[$subjectID]ESM APP 結束';
String endEmailBody(String subjectID) => '您的編號：$subjectID\研究已結束！';

String quitEmailTitle(String subjectID) => '[$subjectID]ESM APP中途退出事前通知';
String quitEmailBody(String subjectID) =>
    "您的編號：$subjectID\n您可以因任何理由而退出，這並不影響您的權益，為了讓我們更了解您的狀況，請簡述退出的原因：\n\n請問您在中途退出後，是否願意讓我們使用您在退出前已填答的資料：";
