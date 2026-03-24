abstract class TimeStampModel {
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  TimeStampModel({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
}
