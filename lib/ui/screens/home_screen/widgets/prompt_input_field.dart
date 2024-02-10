import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketllama2/bloc/generate_text/generate_text_bloc.dart';

class PromptInputField extends StatelessWidget {
  const PromptInputField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Prompt',
            filled: true,
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        BlocBuilder<GenerateTextBloc, GenerateTextState>(
          builder: (context, state) {
            return state is! GeneratingTextInProgress
                ? const SizedBox()
                : const Positioned(
                    top: 8,
                    right: 10,
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator.adaptive(),
                  );
          },
        ),
      ],
    );
  }
}
