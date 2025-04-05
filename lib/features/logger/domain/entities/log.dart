class Log {
  final String? title;
  final String? subtitle;
  final DateTime? createdAt;
  final String? bloc;
  final String? details;
  final String? error;

  const Log({
    this.title,
    this.subtitle,
    this.bloc,
    this.details,
    this.error,
    required this.createdAt,
  });

  Log copyWith({
    String? title,
    String? subtitle,
    String? bloc,
    String? details,
    String? error,
    DateTime? createdAt,
  }) {
    return Log(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      bloc: bloc ?? this.bloc,
      details: details ?? this.details,
      error: error ?? this.error,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
