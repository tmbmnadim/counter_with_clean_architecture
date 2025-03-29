import 'package:flutter/material.dart';

class ViewLogsPage extends StatelessWidget {
  const ViewLogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for demonstration - replace with actual log data
    final List<String> logs = [
      'Log entry 1: Application started',
      'Log entry 2: User logged in',
      'Log entry 3: Data fetched successfully',
      // Add more log entries as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Logs'),
      ),
      body: ListView.builder(
        itemCount: logs.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: const Icon(Icons.history),
              title: Text(logs[index]),
              subtitle: Text('Timestamp: ${DateTime.now()}'),
              onTap: () {
                // Handle log entry tap
              },
            ),
          );
        },
      ),
    );
  }
}
