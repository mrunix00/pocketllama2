import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../services/text_generation/text_generation_interface.dart';

part 'generate_text_event.dart';
part 'generate_text_state.dart';

class GenerateTextBloc extends Bloc<GenerateTextEvent, GenerateTextState> {
  final TextGenerationInterface textGenerationInterface;
  GenerateTextBloc(this.textGenerationInterface) : super(GeneratingTextIdle()) {
    on<GenerateText>((event, emit) async {
      final textStream = textGenerationInterface
          .generateText(event.prompt)
          .asBroadcastStream();
      emit(GeneratingTextInProgress(textStream));
      final text = await textStream.last;
      emit(GeneratingTextSuccess(text));
    });
  }
}
