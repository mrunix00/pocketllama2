import 'package:flutter/material.dart';

void showDownloadModelFailureDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const DownloadModelFailureDialog(),
  );
}

class DownloadModelFailureDialog extends StatelessWidget {
  const DownloadModelFailureDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      icon: Icon(Icons.error),
      title: Text('Error!'),
      content: Text('Downloading the model has failed'),
    );
  }
}
