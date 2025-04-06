import 'package:counter_pro/core/utils/custom_dialog.dart';
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
      body: BlocConsumer<LoggerCubit, LoggerState>(
        listener: (context, state) {
          if (state is LoggerError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message ?? 'An error occurred'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, logger) {
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
                  onTap: () {},
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) => CustomDialog(
                        title: "Delete Log?",
                        subtitle: "Are you sure you want to delete this log?",
                        buttonLabels: const ["Delete", "Cancel"],
                        buttonColors: const [
                          Colors.red,
                          Colors.teal,
                        ],
                        onTap: (label) {
                          switch (label) {
                            case "Delete":
                              context
                                  .read<LoggerCubit>()
                                  .deleteLog(logger.logs[index]);
                              break;
                            case "Cancel":
                              break;
                          }
                        },
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
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
