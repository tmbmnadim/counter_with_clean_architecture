class Log {
  final String? title;
  final String? subtitle;
  final LogLevel? level;
  final DateTime? createdAt;
  final String? bloc;
  final String? details;
  final String? error;

  const Log({
    this.title,
    this.subtitle,
    this.level = LogLevel.undefined,
    this.bloc,
    this.details,
    this.error,
    required this.createdAt,
  });

  Log copyWith({
    String? title,
    String? subtitle,
    LogLevel? level,
    String? bloc,
    String? details,
    String? error,
    DateTime? createdAt,
  }) {
    return Log(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      level: level ?? this.level,
      bloc: bloc ?? this.bloc,
      details: details ?? this.details,
      error: error ?? this.error,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

enum LogLevel { debug, info, warning, error, critical, undefined }
