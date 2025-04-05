import 'dart:convert';
import 'dart:io';

import 'package:counter_pro/features/logger/data/models/log_model.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class LogManager {
  static final LogManager _instance = LogManager._internal();
  static const String logFileName = 'app_logs.txt';
  static const int maxLogSizeBytes = 5 * 1024 * 1024; // 5MB max size

  factory LogManager() {
    return _instance;
  }

  LogManager._internal();

  Future<String> get _logFilePath async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$logFileName';
  }

  Future<File> _getLogFile() async {
    final path = await _logFilePath;
    return File(path);
  }

  Future<void> addLog(LogModel logEntry) async {
    try {
      final file = await _getLogFile();

      // Create file if it doesn't exist
      if (!await file.exists()) {
        await file.create(recursive: true);
      }

      // Rotate log if too large
      if (await file.length() > maxLogSizeBytes) {
        await _rotateLog();
      }

      // Convert to JSON and append to the log file with a newline
      final logJson = json.encode(logEntry.toJson());
      await file.writeAsString('$logJson\n', mode: FileMode.append);

      debugPrint(
          'Logged: ${logEntry.title ?? 'Log entry'} [${logEntry.level.toString().split('.').last}]');
    } catch (e) {
      debugPrint('Failed to write log: $e');
    }
  }

  Future<bool> deleteLog(LogModel log) async {
    try {
      final file = await _getLogFile();

      if (!await file.exists()) {
        return false; // No log file exists
      }

      // Read all lines from the file
      final contents = await file.readAsString();
      final lines =
          contents.split('\n').where((line) => line.trim().isNotEmpty).toList();

      // Filter out the log to delete
      bool logFound = false;
      final updatedLines = <String>[];

      for (final line in lines) {
        try {
          final Map<String, dynamic> logJson = json.decode(line);
          final currentLog = LogModel.fromJson(logJson);

          // If this isn't the log we want to delete, keep it
          if (currentLog != log) {
            updatedLines.add(line);
          } else {
            logFound = true;
          }
        } catch (e) {
          // If we can't parse it, keep the line
          updatedLines.add(line);
        }
      }

      // If we didn't find the log, nothing to delete
      if (!logFound) {
        return false;
      }

      // Write the updated content back to the file
      await file.writeAsString(
          updatedLines.join('\n') + (updatedLines.isNotEmpty ? '\n' : ''));
      return true;
    } catch (e) {
      debugPrint('LogManager<deleteLog>: $e');
      return false;
    }
  }

  // Get all logs as a List<Log>
  Future<List<LogModel>> getLogs() async {
    try {
      final file = await _getLogFile();
      final List<LogModel> logs = [];

      if (await file.exists()) {
        final contents = await file.readAsString();
        final lines =
            contents.split('\n').where((line) => line.trim().isNotEmpty);

        for (final line in lines) {
          final Map<String, dynamic> logJson = jsonDecode(line);
          logs.add(LogModel.fromJson(logJson));
        }
      }

      // Sort logs by creation date (newest first)
      logs.sort((a, b) => (b.createdAt ?? DateTime.now())
          .compareTo(a.createdAt ?? DateTime.now()));

      return logs;
    } catch (e) {
      debugPrint('LogManager<getLogs>: $e');
      return [];
    }
  }

  // Clear all logs
  Future<void> clearLogs() async {
    try {
      final file = await _getLogFile();
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      debugPrint('Failed to clear logs: $e');
    }
  }

  // Rotate logs by creating a backup and starting fresh
  Future<void> _rotateLog() async {
    try {
      final file = await _getLogFile();
      final backupPath =
          '${await _logFilePath}.${DateTime.now().millisecondsSinceEpoch}.bak';

      if (await file.exists()) {
        await file.copy(backupPath);
        await file.delete();
      }
    } catch (e) {
      debugPrint('Failed to rotate logs: $e');
    }
  }

  // Export logs to a specific format (JSON, CSV, etc.)
  Future<String?> exportLogsToJson() async {
    try {
      final logs = await getLogs();
      final directory = await getApplicationDocumentsDirectory();
      final exportPath =
          '${directory.path}/exported_logs_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.json';

      final exportFile = File(exportPath);
      await exportFile
          .writeAsString(json.encode(logs.map((log) => log.toJson()).toList()));

      return exportPath;
    } catch (e) {
      debugPrint('Failed to export logs: $e');
      return null;
    }
  }
}
