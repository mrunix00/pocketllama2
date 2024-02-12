import 'package:flutter/material.dart';

void showTextGenerationErrorDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const TextGenerationErrorDialog(),
  );
}

class TextGenerationErrorDialog extends StatelessWidget {
  const TextGenerationErrorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text('Error'),
      content: const Text('Text generation failed!'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
