import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../services/model_download/download_progress.dart';
import '../../services/model_download/model_download_interface.dart';
import '../../services/text_generation/text_generation_interface.dart';

part 'text_generation_event.dart';
part 'text_generation_state.dart';

class TextGenerationBloc
    extends Bloc<TextGenerationEvent, TextGenerationState> {
  final ModelDownloadInterface modelDownload;
  final TextGenerationInterface textGenerator;

  TextGenerationBloc(
    this.modelDownload,
    this.textGenerator,
  ) : super(TextGenerationIdle()) {
    on<GenerateText>((event, emit) async {
      if (await modelDownload.isDownloaded()) {
        final textStream = textGenerator.generateText(event.prompt);
        await emit.forEach(
          textStream,
          onData: (text) => TextGenerationInProgress(text),
        );
        emit(TextGenerationSuccess());
      } else {
        emit(PromptForModelDownload());
      }
    });

    on<StopTextGeneration>((event, emit) async {
      await textGenerator.stop();
      emit(TextGenerationIdle());
    });

    on<AcceptDownload>((event, emit) async {
      emit(ModelDownloadAccepted());
      final currentDownload = modelDownload.downloadModel();
      await emit.forEach(
        currentDownload,
        onData: (progress) => ModelDownloadInProgress(progress),
      );
      emit(ModelDownloadSuccess());
    });

    on<RefuseDownload>((event, emit) => emit(ModelDownloadRefused()));

    on<CancelDownload>((event, emit) async {
      await modelDownload.cancelCurrentDownload();
      emit(ModelDownloadCancelled());
    });
  }
}
