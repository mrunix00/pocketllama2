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
            if (state is GeneratingTextInProgress) {
              return StreamBuilder<String>(
                stream: state.textStream,
                builder: (context, snapshot) => Text(
                  snapshot.data ?? '',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            } else if (state is GeneratingTextSuccess) {
              return Text(
                state.finalText,
                style: Theme.of(context).textTheme.bodyLarge,
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
