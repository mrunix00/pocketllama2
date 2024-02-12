import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../bloc/text_generation/text_generation_bloc.dart';
import '../../widgets/layout/column_container.dart';
import 'dialogs/download_model_dialog.dart';
import 'dialogs/download_model_progress_dialog.dart';
import 'dialogs/text_generation_error_dialog.dart';
import 'widgets/generate_button.dart';
import 'widgets/generated_text_output.dart';
import 'widgets/prompt_input_field.dart';
import 'widgets/stop_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final bloc = GetIt.I.get<TextGenerationBloc>();

    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<TextGenerationBloc, TextGenerationState>(
        listener: (context, state) {
          if (state is PromptForModelDownload) {
            showDownloadModelDialog(context);
          } else if (state is ModelDownloadAccepted) {
            showDownloadModelProgressDialog(context);
          } else if (state is TextGenerationFailure) {
            showTextGenerationErrorDialog(context);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              systemNavigationBarColor:
                  Theme.of(context).colorScheme.background,
              systemNavigationBarIconBrightness:
                  Theme.of(context).brightness == Brightness.light
                      ? Brightness.dark
                      : Brightness.light,
            ),
            title: const Text('PocketLlama2'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
          body: ColumnContainer(
            children: [
              const GeneratedTextOutput(),
              Row(
                children: [
                  Expanded(child: PromptInputField(controller: controller)),
                  const SizedBox(width: 10),
                  BlocBuilder<TextGenerationBloc, TextGenerationState>(
                    builder: (context, state) {
                      return state is TextGenerationInProgress
                          ? const StopButton()
                          : GenerateButton(controller: controller);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
