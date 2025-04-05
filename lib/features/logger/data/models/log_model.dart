import 'package:counter_pro/features/logger/logger.dart';

class LogModel extends Log {
  const LogModel({
    super.title,
    super.subtitle,
    super.bloc,
    super.details,
    super.error,
    super.createdAt,
  });

  factory LogModel.fromJson(Map<String, dynamic> json) {
    return LogModel(
      title: json['title'],
      subtitle: json['subtitle'],
      bloc: json['bloc'],
      details: json['details'],
      error: json['error'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'bloc': bloc,
      'details': details,
      'error': error,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
