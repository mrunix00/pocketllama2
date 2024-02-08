import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pocketllama2/services/interfaces/text_generation_interface.dart';

part 'generate_text_event.dart';
part 'generate_text_state.dart';

class GenerateTextBloc extends Bloc<GenerateTextEvent, GenerateTextState> {
  final TextGenerationInterface textGenerationInterface;
  GenerateTextBloc(this.textGenerationInterface)
      : super(GeneratingTextIdle()) {
    on<GenerateText>((event, emit) async {
      emit(GeneratingTextInProgress());
      final generatedText =
          await textGenerationInterface.generateText(event.prompt);
      emit(GeneratingTextSuccess(generatedText));
    });
  }
}
