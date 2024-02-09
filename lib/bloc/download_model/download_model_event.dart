part of 'download_model_bloc.dart';

sealed class DownloadModelEvent extends Equatable {
  const DownloadModelEvent();

  @override
  List<Object> get props => [];
}

final class PromptForDownload extends DownloadModelEvent {}

final class AcceptDownload extends DownloadModelEvent {}

final class RefuseDownload extends DownloadModelEvent {}

final class CancelDownload extends DownloadModelEvent {}
