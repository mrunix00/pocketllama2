import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketllama2/bloc/generate_text/generate_text_bloc.dart';

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
              BlocProvider.of<GenerateTextBloc>(context).add(
                GenerateText(prompt: controller.text),
              );
            },
            icon: const Icon(Icons.edit),
          );
        },
      ),
    );
  }
}
