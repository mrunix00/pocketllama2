import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pocketllama2/services/model_download/model_download_interface.dart';

import '../download_progress.dart';

const _downloadUrl =
    "https://huggingface.co/karpathy/tinyllamas/resolve/main/stories15M.bin";

final class TinystoriesModelDownload implements ModelDownloadInterface {
  static CancelToken? cancelToken;

  @override
  Future<bool> isDownloaded() async {
    var path = (await getApplicationDocumentsDirectory()).path;
    return File('$path/stories15M.bin').existsSync() &&
        File('$path/tokenizer.bin').existsSync();
  }

  @override
  Stream<DownloadProgress> downloadModel() {
    final controller = StreamController<DownloadProgress>();
    getApplicationDocumentsDirectory().then(
      (downloadPath) async {
        final modelSavePath = '${downloadPath.path}/stories15M.bin';
        if (!File(modelSavePath).existsSync()) {
          cancelToken = CancelToken();
          await Dio().download(
            _downloadUrl,
            modelSavePath,
            cancelToken: cancelToken,
            deleteOnError: true,
            onReceiveProgress: (received, total) {
              controller.add(DownloadProgress(
                received,
                total == -1 ? received : total,
              ));
            },
          );
        }
        final tokenizerSavePath = '${downloadPath.path}/tokenizer.bin';
        if (!File(tokenizerSavePath).existsSync()) {
          await Dio().download(
            'https://github.com/karpathy/llama2.c/raw/master/tokenizer.bin',
            '${downloadPath.path}/tokenizer.bin',
            deleteOnError: true,
          );
        }
        controller.close();
      },
    );

    return controller.stream.asBroadcastStream();
  }

  @override
  Future<void> cancelCurrentDownload() async {
    cancelToken!.cancel();
  }
}
