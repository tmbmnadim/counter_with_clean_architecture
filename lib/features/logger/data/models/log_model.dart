import 'package:counter_pro/features/logger/logger.dart';

class LogModel extends Log {
  const LogModel({
    super.title,
    super.subtitle,
    super.level,
    super.bloc,
    super.details,
    super.error,
    super.createdAt,
  });

  factory LogModel.fromJson(Map<String, dynamic> json) {
    return LogModel(
      title: json['title'],
      subtitle: json['subtitle'],
      level: LogLevel.values.byName(json['level'] ?? "undefined"),
      bloc: json['bloc'],
      details: json['details'],
      error: json['error'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  factory LogModel.fromEntity(Log log) {
    return LogModel(
      title: log.title,
      subtitle: log.subtitle,
      level: log.level,
      bloc: log.bloc,
      details: log.details,
      error: log.error,
      createdAt: log.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'level': level?.name,
      'bloc': bloc,
      'details': details,
      'error': error,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
