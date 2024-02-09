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
    return SizedBox.square(
      dimension: 40,
      child: BlocBuilder<GenerateTextBloc, GenerateTextState>(
        builder: (context, state) {
          if (state is GeneratingTextInProgress) {
            return const CircularProgressIndicator.adaptive();
          }
          return IconButton.filled(
            onPressed: () {
              TinystoriesModelDownload().isDownloaded().then((value) {
                if (value) {
                  BlocProvider.of<GenerateTextBloc>(context).add(
                    GenerateText(prompt: controller.text),
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
        },
      ),
    );
  }
}
