import 'package:counter_pro/features/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateLogsView extends StatefulWidget {
  const CreateLogsView({super.key});

  @override
  State<CreateLogsView> createState() => _CreateLogsViewState();
}

class _CreateLogsViewState extends State<CreateLogsView> {
  bool _createPressed = false;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Log'),
      ),
      body: BlocListener<LoggerCubit, LoggerState>(
        listenWhen: (previous, current) => _createPressed,
        listener: (context, state) {
          if (state is LogCreated) {
            // Show a snackbar or navigate to a new screen
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Log created successfully!'),
              ),
            );
            _createPressed = false; // Reset the flag
          } else if (state is LoggerError) {
            // Show an error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.message}'),
              ),
            );
            _createPressed = false; // Reset the flag
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Title (Optional)',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _subtitleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Subtitle',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a subtitle';
                      }
                      if (value.length < 20) {
                        return 'Subtitle must be at least 20 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _createPressed = true;
                        // Create log
                        final log = Log(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          title: _titleController.text,
                          subtitle: _subtitleController.text,
                          createdAt: DateTime.now(),
                        );
                        // Add log to the logger
                        context.read<LoggerCubit>().createLog(log);
                        _titleController.clear();
                        _subtitleController.clear();
                      }
                    },
                    child: const Text('Create Log'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
