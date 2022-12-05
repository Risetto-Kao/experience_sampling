String generateTwoDigitsString(int timeUnit) =>
    timeUnit >= 10 ? timeUnit.toString() : '0${timeUnit.toString()}';

void printInRed(content) => print("\x1B[31m$content\x1B[0m");
void printInGreen(content) => print("\x1B[32m$content\x1B[0m");
void printInYellow(content) => print("\x1B[33m$content\x1B[0m");
void printInBlue(content) => print("\x1B[34m$content\x1B[0m");

void printMyError(content) => print("\x1B[31mError: $content\x1B[0m");
void printSuccess(content) => print("\x1B[32mSuccess: $content\x1B[0m");

void printPrimaryInfo(String title, content) {
  const lineLength = 40;
  const gap = 2;
  final line = '-' * lineLength;
  final starLine = '*' * lineLength;
  final front = '-' * ((lineLength - title.length - 2 * gap) / 2).floor();
  final back = '-' * ((lineLength - title.length - 2 * gap) / 2).ceil();
  printInYellow('$line');
  printInYellow('$front  $title  $back');
  printInYellow('$line');
  printInGreen(content);
  printInYellow(starLine);
}

void printSecondaryInfo(String title, content) {
  const lineLength = 40;
  const gap = 2;
  final line = '-' * lineLength;
  final starLine = '*' * lineLength;
  final front = '-' * ((lineLength - title.length - 2 * gap) / 2).floor();
  final back = '-' * ((lineLength - title.length - 2 * gap) / 2).ceil();
  printInBlue('$line');
  printInBlue('$front  $title  $back');
  printInBlue('$line');
  printInRed(content);
  printInBlue(starLine);
}
