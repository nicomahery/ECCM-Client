class Metric {
  String title;
  Map<DateTime, num> dateTimeDataMap;
  late Map<num, num> indexDataMap;
  late double middleX;
  num? _maxValue;
  num? _minValue;
  num? _meanValue;
  DateTime? _maxDatetime;
  DateTime? _minDatetime;

  Metric({required this.title, required this.dateTimeDataMap}) {
    int i = 1;
    this.indexDataMap = Map();
    this.dateTimeDataMap.forEach((key, value) {
      this.indexDataMap.putIfAbsent(i, () => value);
      i++;
    });
    this.middleX = this.dateTimeDataMap.length / 2;
  }

  bool get isEmpty {
    return this.dateTimeDataMap.isEmpty || this.dateTimeDataMap.length < 2;
  }

  num get minValue {
    if (this._minValue == null) {
      this._minValue = this.dateTimeDataMap.values.reduce((value, element) => element < value ? element : value);
    }
    return this._minValue!;
  }

  num get maxValue {
    if (this._maxValue == null) {
      this._maxValue = this.dateTimeDataMap.values.reduce((value, element) => element > value ? element : value);
    }
    return this._maxValue!;
  }

  num get meanValue {
    if (this._meanValue == null) {
      this._meanValue = this.dateTimeDataMap.values.reduce((value, element) => element + value);
      this._meanValue = this._meanValue! / this.dateTimeDataMap.length;
    }
    return this._meanValue!;
  }

  DateTime get maxDatetime {
    if (this._maxDatetime == null) {
      this._computeMinMaxDateTime();
    }
    return this._maxDatetime!;
  }

  DateTime get minDatetime {
    if (this._minDatetime == null) {
      this._computeMinMaxDateTime();
    }
    return this._minDatetime!;
  }

  void _computeMinMaxDateTime() {
    var list = this.dateTimeDataMap.keys.toList();
    list.sort((a, b) => a.compareTo(b));
    this._maxDatetime = list.last;
    this._minDatetime = list.first;
  }
}