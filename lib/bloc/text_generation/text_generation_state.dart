part of 'text_generation_bloc.dart';

sealed class TextGenerationState extends Equatable {
  const TextGenerationState();

  @override
  List<Object> get props => [];
}

final class TextGenerationIdle extends TextGenerationState {}

final class TextGenerationInProgress extends TextGenerationState {
  const TextGenerationInProgress(this.textStream);

  final Stream<String> textStream;

  @override
  List<Object> get props => [textStream];
}

final class TextGenerationSuccess extends TextGenerationState {
  const TextGenerationSuccess(this.finalText);

  final String finalText;

  @override
  List<Object> get props => [finalText];
}

final class PromptForModelDownload extends TextGenerationState {}

final class ModelDownloadInProgress extends TextGenerationState {
  const ModelDownloadInProgress(this.progress);
  final DownloadProgress progress;

  @override
  List<Object> get props => [progress];
}

final class ModelDownloadSuccess extends TextGenerationState {}

final class ModelDownloadAccepted extends TextGenerationState {}

final class ModelDownloadRefused extends TextGenerationState {}

final class ModelDownloadCancelled extends TextGenerationState {}
