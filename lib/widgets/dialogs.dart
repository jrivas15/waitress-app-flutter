import 'package:flutter/material.dart';
import 'package:meseros_app/theme/app_theme.dart';

class QuestionDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback fx;
  const QuestionDialog({
    super.key,
    required this.title,
    required this.content,
    required this.fx,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      icon: const Icon(Icons.question_mark_rounded, size: 30),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            fx();
          },
          style: TextButton.styleFrom(foregroundColor: AppTheme.primaryColor),
          child: const Text('Si'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(foregroundColor: AppTheme.primaryColor),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }

  static Future<dynamic> displayAlert({
    required BuildContext context,
    required String content,
    required String title,
    required VoidCallback fx,
  }) {
    return showDialog(
      context: context,
      builder:
          (context) => QuestionDialog(
            content: content,
            title: title,
            fx: () {
              fx();
              Navigator.pop(context);
            },
          ),
    );
  }

  static Future<bool> showAlertDialog(
    BuildContext context,
    String message,
  ) async {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: const Text("Cancel"),
      onPressed: () {
        // returnValue = false;
        Navigator.of(context).pop(false);
      },
    );
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {
        // returnValue = true;
        Navigator.of(context).pop(true);
      },
    ); // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Do you want to continue?"),
      content: Text(message),
      actions: [cancelButton, continueButton],
    ); // show the dialog
    final result = await showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    return result ?? false;
  }
}
