class Metric {
  String title;
  Map<DateTime, num> data;
  late Map<num, num> data2;
  late double middleX;
  num? _maxValue;
  num? _minValue;
  num? _meanValue;
  DateTime? _maxDatetime;
  DateTime? _minDatetime;

  Metric({required this.title, required this.data}) {
    int i = 1;
    this.data2 = Map();
    this.data.forEach((key, value) {
      this.data2.putIfAbsent(i, () => value);
      i++;
    });
    this.middleX = this.data.length / 2;
  }

  bool get isEmpty {
    return this.data.isEmpty || this.data.length < 2;
  }

  num get minValue {
    if (this._minValue == null) {
      this._minValue = this.data.values.reduce((value, element) => element < value ? element : value);
    }
    return this._minValue!;
  }

  num get maxValue {
    if (this._maxValue == null) {
      this._maxValue = this.data.values.reduce((value, element) => element > value ? element : value);
    }
    return this._maxValue!;
  }

  num get meanValue {
    if (this._meanValue == null) {
      this._meanValue = this.data.values.reduce((value, element) => element + value);
      this._meanValue = this._meanValue! / this.data.length;
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
    var list = this.data.keys.toList();
    list.sort((a, b) => a.compareTo(b));
    this._maxDatetime = list.last;
    this._minDatetime = list.first;
  }
}