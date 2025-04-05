import 'package:counter_pro/features/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/empty_placholder.dart';

class ViewLogsPage extends StatelessWidget {
  const ViewLogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logs'),
      ),
      body: BlocBuilder<LoggerCubit, LoggerState>(builder: (context, logger) {
        if (logger.logs.isEmpty) {
          return const EmptyPlaceholder(
            title: 'No logs available',
            subtitle: 'You have not created any logs yet.',
          );
        }
        return ListView.builder(
          itemCount: logger.logs.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ListTile(
                leading:
                    Text(logger.logs[index].createdAt?.toString() ?? 'N/A'),
                title: Text(logger.logs[index].title ?? 'Log Entry $index'),
                subtitle: Text("${logger.logs[index].subtitle}"),
                onTap: () {
                  // Handle log entry tap
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Tapped on ${logger.logs[index].title}'),
                    ),
                  );
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const CreateLogsView();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
