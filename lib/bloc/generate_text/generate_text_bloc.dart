import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../services/text_generation/text_generation_interface.dart';

part 'generate_text_event.dart';
part 'generate_text_state.dart';

class GenerateTextBloc extends Bloc<GenerateTextEvent, GenerateTextState> {
  final TextGenerationInterface textGenerationInterface;
  GenerateTextBloc(this.textGenerationInterface) : super(GeneratingTextIdle()) {
    late Stream<String> textStream;
    on<GenerateText>((event, emit) async {
      textStream = textGenerationInterface
          .generateText(event.prompt)
          .asBroadcastStream();
      emit(GeneratingTextInProgress(textStream));
      final text = await textStream.last;
      emit(GeneratingTextSuccess(text));
    });

    on<StopGeneratingText>((event, emit) async {
      await textGenerationInterface.stop();
    });
  }
}
