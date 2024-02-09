import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pocketllama2/services/model_download/model_download_interface.dart';

import '../download_progress.dart';

const _downloadUrl =
    "https://huggingface.co/karpathy/tinyllamas/resolve/main/stories15M.bin";

final class TinystoriesModelDownload implements ModelDownloadInterface {
  @override
  Future<bool> isDownloaded() async =>
      File('${(await getApplicationCacheDirectory()).path}/stories15M.bin')
          .exists();

  @override
  Stream<DownloadProgress> downloadModel() {
    final controller = StreamController<DownloadProgress>();
    getApplicationCacheDirectory().then(
      (downloadPath) {
        if (!File('${downloadPath.path}/stories15M.bin').existsSync()) {
          Dio().download(
            _downloadUrl,
            '${downloadPath.path}/stories15M.bin',
            onReceiveProgress: (received, total) {
              if (total != -1) {
                controller.add(DownloadProgress(received, total));
              }
            },
          ).then((_) => controller.close());
        } else {
          controller.close();
        }
      },
    );

    return controller.stream.asBroadcastStream();
  }
}
