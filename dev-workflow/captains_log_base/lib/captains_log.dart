import 'dart:html';
// TODO: Add import

// ignoring leap years
const int _secondsInAYear = 31536000;
const String _prompt = 'Something happened. Make it sound puzzling and heroic.';
final List<String> _templates = [
  'We encountered what appeared to be a <insert space anomaly>. It has '
      'proven to be sentient and has taken control of our ship. Thus far, all '
      'efforts at communication have failed...',
  'A warship from the <insert hostile alien organization> has entered our '
      'territory. It is currently speeding towards Earth. Thus far, all '
      'efforts at peace have failed...',
  'The ship has been pulled into a <insert type of time distortion>. We are '
      'observing the universe in the distant <past or future>. Thus far, all '
      'efforts to return to our timeline have failed...'
];

Map<double, HtmlElement> logEntries;
Element logElement;

void init() {
  // initialization
  // TODO: Add Quill editor

  logElement = document.getElementById('log');
  logEntries = new Map<double, HtmlElement>();
  loadPreviousEntries();

  // listeners
  document.getElementById('save').onClick.listen(saveLog);
  document.getElementById('templateSelect') as SelectElement
    ..onChange.listen(useTemplate);
}

/// Capture entry in editor, save to local storage and display in log.
void appendToLog(double stardate, HtmlElement logEntryElement) {
  logEntries[stardate] = logEntryElement;
  window.localStorage[stardate.toString()] = logEntryElement.innerHtml;
  displayLogEntry(stardate, logEntryElement);
}

/// Calculate the current stardate: <Year>.<Percentage of year completion>
double calculateStardate() {
  var now = new DateTime.now();
  var beginningOfYear = new DateTime(now.year);
  int secondsThisYear = now.difference(beginningOfYear).inSeconds;
  return now.year + secondsThisYear / _secondsInAYear;
}

/// Copy html elements from the editor view and return them inside a new
/// DivElement.
HtmlElement captureEditorView() {
  Element contentElement = document.getElementById('editor').children.first;

  var logEntryElement = new DivElement()..innerHtml = contentElement.innerHtml;

  return logEntryElement;
}

/// Update the dom with the provided log entry.
void displayLogEntry(double stardate, HtmlElement logEntryElement) {
  if (logElement.children.isNotEmpty) {
    logElement.insertAdjacentElement('afterBegin', new HRElement());
  }

  logElement.insertAdjacentElement('afterBegin', logEntryElement);
  var stardateElement = new HeadingElement.h2()
    ..text = 'Stardate: $stardate'
    ..classes.add('stardate');
  logElement.insertAdjacentElement('afterBegin', stardateElement);
}

/// Load all log entries from browser local storage.
void loadPreviousEntries() {
  List<String> keys = window.localStorage.keys.toList();
  keys.sort();
  for (String key in keys) {
    var entryElement = new DivElement()..innerHtml = window.localStorage[key];
    logEntries[double.parse(key)] = entryElement;
  }
  updateDisplay();
}

/// Save the log entry that is currently in the editor.
void saveLog(Event _) {
  // TODO: Need to save the text from the editor
}

/// Update the dom to show all current log entries.
void updateDisplay() {
  logElement.innerHtml = '';
  List<double> starDates = logEntries.keys.toList();
  starDates.sort();
  for (double starDate in starDates) {
    displayLogEntry(starDate, logEntries[starDate]);
  }
}

/// Updates the content of the editor using the selected template.
void useTemplate(Event _) {
  SelectElement templateSelectElement =
      document.getElementById('templateSelect') as SelectElement;
  int selectedIndex = templateSelectElement.selectedIndex;

  if (selectedIndex == 0) return;

  // TODO: Need to clear the editor and insert the template
}
