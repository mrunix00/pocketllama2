import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/text_generation/text_generation_bloc.dart';

class GeneratedTextOutput extends StatelessWidget {
  const GeneratedTextOutput({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: BlocBuilder<TextGenerationBloc, TextGenerationState>(
            buildWhen: (previous, current) => current is! TextGenerationIdle,
            builder: (context, state) {
              if (state is TextGenerationInProgress) {
                return StreamBuilder<String>(
                  stream: state.textStream,
                  builder: (context, snapshot) => Text(
                    snapshot.data ?? '',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              } else if (state is TextGenerationSuccess) {
                return Text(
                  state.finalText,
                  style: Theme.of(context).textTheme.bodyLarge,
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
