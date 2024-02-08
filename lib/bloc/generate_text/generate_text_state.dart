part of 'generate_text_bloc.dart';

sealed class GenerateTextState extends Equatable {
  const GenerateTextState();

  @override
  List<Object> get props => [];
}

final class GeneratingTextIdle extends GenerateTextState {}

final class GeneratingTextInProgress extends GenerateTextState {}

final class GeneratingTextSuccess extends GenerateTextState {
  final String generatedText;

  const GeneratingTextSuccess(this.generatedText);

  @override
  List<Object> get props => [generatedText];
}
