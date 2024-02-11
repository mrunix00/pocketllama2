import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/text_generation/text_generation_bloc.dart';

class PromptInputField extends StatelessWidget {
  const PromptInputField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextGenerationBloc, TextGenerationState>(
      builder: (context, state) {
        return Stack(
          children: [
            TextField(
              controller: controller,
              enabled: state is! TextGenerationInProgress,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                hintText: 'Prompt',
                filled: true,
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            state is! TextGenerationInProgress
                ? const SizedBox()
                : const Positioned(
                    top: 8,
                    right: 10,
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator.adaptive(),
                  ),
          ],
        );
      },
    );
  }
}
