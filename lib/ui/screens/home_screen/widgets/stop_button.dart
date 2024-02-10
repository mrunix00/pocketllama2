import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketllama2/bloc/generate_text/generate_text_bloc.dart';

class StopButton extends StatelessWidget {
  const StopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: () {
        BlocProvider.of<GenerateTextBloc>(context).add(StopGeneratingText());
      },
      icon: const Icon(Icons.stop),
    );
  }
}
