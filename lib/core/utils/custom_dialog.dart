import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<String> buttonLabels;
  final List<Color> buttonColors;
  final Function(String) onTap;
  final Color primaryColor;

  const CustomDialog({
    super.key,
    required this.title,
    this.subtitle,
    required this.buttonLabels,
    this.buttonColors = const [
      Colors.teal,
      Colors.teal,
    ], // Default to empty list, can be overridden
    required this.onTap,
    this.primaryColor = Colors.teal, // Default to teal, can be overridden
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 10),
          if (subtitle != null) ...[
            Text(
              subtitle!,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
          ],
          _buildButtonRow(context),
        ],
      ),
    );
  }

  Widget _buildButtonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: buttonLabels.length <= 2
          ? MainAxisAlignment.end
          : MainAxisAlignment.spaceEvenly,
      children:
          buttonLabels.map((label) => _buildButton(context, label)).toList(),
    );
  }

  Widget _buildButton(BuildContext context, String label) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: buttonColors[buttonLabels.indexOf(label)],
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onPressed: () {
        onTap(label);
        Navigator.of(context).pop();
      },
      child: Text(label),
    );
  }
}

// Usage example:
void showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog(
        title: 'Confirmation',
        subtitle: 'Are you sure you want to proceed?', // Optional
        buttonLabels: const ['Cancel', 'Confirm'],
        onTap: (label) {
          print('Button pressed: $label');
          // Handle action based on label
        },
        // primaryColor: Colors.purple, // Uncomment to use purple instead of teal
      );
    },
  );
}
