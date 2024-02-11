part of 'text_generation_bloc.dart';

sealed class TextGenerationEvent extends Equatable {
  const TextGenerationEvent();

  @override
  List<Object> get props => [];
}

final class GenerateText extends TextGenerationEvent {
  const GenerateText(this.prompt);

  final String prompt;

  @override
  List<Object> get props => [prompt];
}

final class StopTextGeneration extends TextGenerationEvent {}

final class AcceptDownload extends TextGenerationEvent {}

final class RefuseDownload extends TextGenerationEvent {}

final class CancelDownload extends TextGenerationEvent {}
