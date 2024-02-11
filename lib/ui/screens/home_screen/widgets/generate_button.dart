import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketllama2/bloc/download_model/download_model_bloc.dart';
import 'package:pocketllama2/bloc/generate_text/generate_text_bloc.dart';
import 'package:pocketllama2/services/model_download/implementations/tinystories_model_download.dart';

class GenerateButton extends StatelessWidget {
  const GenerateButton({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      iconSize: 20,
      onPressed: () {
        TinystoriesModelDownload().isDownloaded().then((value) {
          if (value) {
            BlocProvider.of<GenerateTextBloc>(context).add(
              GenerateText(prompt: controller.text.trim()),
            );
          } else {
            BlocProvider.of<DownloadModelBloc>(context).add(
              PromptForDownload(),
            );
          }
        });
      },
      icon: const Icon(Icons.edit),
    );
  }
}
