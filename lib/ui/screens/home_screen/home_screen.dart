import 'package:flutter/material.dart';

import '../../widgets/layout/column_container.dart';
import 'widgets/generate_button.dart';
import 'widgets/prompt_input_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('PocketLLama2'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: const ColumnContainer(
        children: [
          Spacer(),
          Row(
            children: [
              Expanded(child: PromptInputField()),
              SizedBox(width: 10),
              GenerateButton(),
            ],
          ),
        ],
      ),
    );
  }
}


