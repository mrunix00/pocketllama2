import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketllama2/bloc/generate_text/generate_text_bloc.dart';

class GeneratedTextOutput extends StatelessWidget {
  const GeneratedTextOutput({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: BlocBuilder<GenerateTextBloc, GenerateTextState>(
          builder: (context, state) {
            if (state is GeneratingTextSuccess) {
              return Text(
                state.generatedText,
                style: Theme.of(context).textTheme.bodyLarge,
              );
            }
            return const Spacer();
          },
        ),
      ),
    );
  }
}
