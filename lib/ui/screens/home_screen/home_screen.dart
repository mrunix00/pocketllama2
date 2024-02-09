import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/download_model/download_model_bloc.dart';
import '../../../bloc/generate_text/generate_text_bloc.dart';
import '../../../services/model_download/implementations/tinystories_model_download.dart';
import '../../../services/text_generation/implementations/llama2_mock.dart';
import '../../widgets/layout/column_container.dart';
import 'dialogs/download_model_dialog.dart';
import 'dialogs/download_model_progress_dialog.dart';
import 'widgets/generate_button.dart';
import 'widgets/generated_text_output.dart';
import 'widgets/prompt_input_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final downloadModelBloc = DownloadModelBloc(TinystoriesModelDownload());

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GenerateTextBloc(LlamaMock()),
        ),
        BlocProvider(
          create: (context) => downloadModelBloc,
        ),
      ],
      child: BlocListener(
        bloc: downloadModelBloc,
        listener: (context, state) {
          if (state is PromptedForDownload) {
            showDownloadModelDialog(context);
          } else if (state is DownloadingModelInProgress) {
            showDownloadModelProgressDialog(context);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              systemNavigationBarColor:
                  Theme.of(context).colorScheme.background,
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
                  GenerateButton(controller: controller),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
