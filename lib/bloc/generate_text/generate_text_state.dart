part of 'generate_text_bloc.dart';

sealed class GenerateTextState extends Equatable {
  const GenerateTextState();

  @override
  List<Object> get props => [];
}

final class GeneratingTextIdle extends GenerateTextState {}

final class GeneratingTextInProgress extends GenerateTextState {
  const GeneratingTextInProgress(this.textStream);

  final Stream<String> textStream;

  @override
  List<Object> get props => [textStream];
}

final class GeneratingTextSuccess extends GenerateTextState {
  const GeneratingTextSuccess(this.finalText);

  final String finalText;

  @override
  List<Object> get props => [finalText];
}
