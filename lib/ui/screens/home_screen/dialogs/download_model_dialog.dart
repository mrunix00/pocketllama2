import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketllama2/bloc/download_model/download_model_bloc.dart';

void showDownloadModelDialog(BuildContext context) {
  final bloc = BlocProvider.of<DownloadModelBloc>(context);
  showDialog(
    context: context,
    builder: (context) => DownloadModelDialog(bloc: bloc),
    barrierDismissible: true,
  );
}

class DownloadModelDialog extends StatelessWidget {
  const DownloadModelDialog({super.key, required this.bloc});

  final DownloadModelBloc bloc;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text('Missing model'),
      content: const Text(
        'The Llama2 model you want to use is not '
        'downloaded yet, do you want to download it?',
      ),
      actions: [
        TextButton(
          onPressed: () {
            bloc.add(AcceptDownload());
            Navigator.of(context).pop();
          },
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('No'),
        ),
      ],
    );
  }
}
