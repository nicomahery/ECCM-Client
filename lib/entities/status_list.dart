class StatusList {
  final List<String> errors;
  final List<String> warnings;
  final List<String> info;

  StatusList(this.errors, this.warnings, this.info);

  factory StatusList.fromJson(Map<String, dynamic> json) {
    return StatusList(
        (json['errors'] as List).map((e) => e.toString()).toList(),
        (json['warnings'] as List).map((e) => e.toString()).toList(),
        (json['info'] as List).map((e) => e.toString()).toList(),
    );
  }
}