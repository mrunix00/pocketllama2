part of 'download_model_bloc.dart';

sealed class DownloadModelState extends Equatable {
  const DownloadModelState();

  @override
  List<Object> get props => [];
}

final class DownloadingModelIdle extends DownloadModelState {}

final class DownloadingModelInProgress extends DownloadModelState {
  const DownloadingModelInProgress(this.progress);
  final DownloadProgress progress;

  @override
  List<Object> get props => [progress];
}

final class DownloadingModelSuccess extends DownloadModelState {}

final class PromptedForDownload extends DownloadModelState {}

final class AcceptedDownload extends DownloadModelState {}

final class RefusedDownload extends DownloadModelState {}

final class CancelledDownload extends DownloadModelState {}
