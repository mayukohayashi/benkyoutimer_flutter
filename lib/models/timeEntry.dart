class TimeEntry {
  int _timeEntryId;
  DateTime _timeEntryDate;
  double _timeEntrySpan;
  String _timeEntryTitle;

  TimeEntry(this._timeEntryId, this._timeEntryDate, this._timeEntrySpan,
      this._timeEntryTitle);

  TimeEntry.map(dynamic obj) {
    this._timeEntryId = obj['TimeEntryId'];
    this._timeEntryDate = obj['TimeEntryDate'];
    this._timeEntrySpan = obj['TimeEntrySpan'];
    this._timeEntryTitle = obj['TimeEntryTitle'];
  }

  int get timeEntryId => _timeEntryId;
  DateTime get timeEntryDate => _timeEntryDate;
  double get timeEntrySpan => _timeEntrySpan;
  String get timeEntryTitle => _timeEntryTitle;

  Map toMap() {
    var map = new Map();

    map['TimeEntryId'] = timeEntryId;
    map['TimeEntryDate'] = _timeEntryDate;
    map['TimeEntrySpan'] = _timeEntrySpan;
    map['TimeEntryTitle'] = _timeEntryTitle;

    return map;
  }

  TimeEntry.fromMap(Map map) {
    this._timeEntryId = map['TimeEntryId'];
    this._timeEntryDate = map['TimeEntryDate'];
    this._timeEntrySpan = map['TimeEntrySpan'];
    this._timeEntryTitle = map['TimeEntryTitle'];
  }
}
