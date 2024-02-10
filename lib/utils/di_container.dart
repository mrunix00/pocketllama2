import 'package:get_it/get_it.dart';

import '../bloc/download_model/download_model_bloc.dart';
import '../bloc/generate_text/generate_text_bloc.dart';
import '../services/model_download/implementations/tinystories_model_download.dart';
import '../services/model_download/model_download_interface.dart';
import '../services/text_generation/implementations/llama2.dart';
import '../services/text_generation/text_generation_interface.dart';

void setupDependencyInjector() {
  GetIt.I.registerLazySingleton<TextGenerationInterface>(
    () => Llama2(),
  );
  GetIt.I.registerLazySingleton<ModelDownloadInterface>(
    () => TinystoriesModelDownload(),
  );

  GetIt.I.registerFactory<DownloadModelBloc>(
    () => DownloadModelBloc(GetIt.I.get()),
  );
  GetIt.I.registerFactory<GenerateTextBloc>(
    () => GenerateTextBloc(GetIt.I.get()),
  );
}
