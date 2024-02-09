import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pocketllama2/services/model_download/download_progress.dart';
import 'package:pocketllama2/services/model_download/model_download_interface.dart';

part 'download_model_event.dart';
part 'download_model_state.dart';

class DownloadModelBloc extends Bloc<DownloadModelEvent, DownloadModelState> {
  final ModelDownloadInterface modelDownload;
  DownloadModelBloc(this.modelDownload) : super(DownloadingModelIdle()) {
    on<PromptForDownload>((event, emit) => emit(PromptedForDownload()));
    on<RefuseDownload>((event, emit) => emit(RefusedDownload()));
    on<AcceptDownload>(
      (event, emit) async {
        emit(AcceptedDownload());
        final currentDownload = modelDownload.downloadModel();
        await emit.forEach(
          currentDownload,
          onData: (progress) => DownloadingModelInProgress(progress),
        );
        emit(DownloadingModelSuccess());
      },
    );

    on<CancelDownload>(
      (event, emit) async {
        await modelDownload.cancelCurrentDownload();
        emit(CancelledDownload());
      },
    );
  }
}
