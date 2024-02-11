import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/text_generation/text_generation_bloc.dart';

class StopButton extends StatelessWidget {
  const StopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: () => BlocProvider.of<TextGenerationBloc>(context).add(
        StopTextGeneration(),
      ),
      icon: const Icon(Icons.stop),
    );
  }
}
