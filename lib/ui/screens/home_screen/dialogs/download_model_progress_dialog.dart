import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/text_generation/text_generation_bloc.dart';

void showDownloadModelProgressDialog(BuildContext context) {
  final bloc = BlocProvider.of<TextGenerationBloc>(context);
  showDialog(
    context: context,
    builder: (context) => DownloadModelProgressDialog(bloc: bloc),
    barrierDismissible: false,
  ).then((_) => bloc.add(CancelDownload()));
}

class DownloadModelProgressDialog extends StatelessWidget {
  const DownloadModelProgressDialog({super.key, required this.bloc});

  final TextGenerationBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: bloc,
      listener: (context, state) {
        if (state is ModelDownloadSuccess) Navigator.of(context).pop();
      },
      child: AlertDialog.adaptive(
        title: const Text('Downloading'),
        content: Row(
          children: [
            const CircularProgressIndicator.adaptive(),
            const SizedBox(width: 20),
            BlocBuilder(
              bloc: bloc,
              builder: (context, state) => state is ModelDownloadInProgress
                  ? Text(state.progress.asPercentage())
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
