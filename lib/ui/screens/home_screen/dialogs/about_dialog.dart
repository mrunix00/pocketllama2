import 'package:flutter/material.dart';

void showAboutPocketLlamaDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const AboutDialogWidget(),
    barrierDismissible: true,
  );
}

class AboutDialogWidget extends StatelessWidget {
  const AboutDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('About'),
      content: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('PocketLlama2 0.0.1'),
          Text('Author: Ibrahim KAIKAA (Mr.UNIX)'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
