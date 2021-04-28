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

  // Map toMap() {
  //   var map = new Map();
  //   if (_id != null) {
  //     map['id'] = _id;
  //   }
  //   map['title'] = _title;
  //   map['description'] = _description;

  //   return map;
  // }

  // Note.fromMap(Map map) {
  //   this._id = map['id'];
  //   this._title = map['title'];
  //   this._description = map['description'];
  // }

}
