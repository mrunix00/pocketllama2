part of 'text_generation_bloc.dart';

sealed class TextGenerationState extends Equatable {
  const TextGenerationState();

  @override
  List<Object> get props => [];
}

final class TextGenerationIdle extends TextGenerationState {}

final class TextGenerationInProgress extends TextGenerationState {
  const TextGenerationInProgress(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

final class TextGenerationSuccess extends TextGenerationState {}

final class TextGenerationFailure extends TextGenerationState {}

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

final class ModelDownloadFailure extends TextGenerationState {}
