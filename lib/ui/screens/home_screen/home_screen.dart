import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/generate_text/generate_text_bloc.dart';
import '../../../services/text_generation/implementations/llama2_mock.dart';
import '../../widgets/layout/column_container.dart';
import 'widgets/generate_button.dart';
import 'widgets/generated_text_output.dart';
import 'widgets/prompt_input_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return BlocProvider(
      create: (context) => GenerateTextBloc(LlamaMock()),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Theme.of(context).colorScheme.background,
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
    );
  }
}
