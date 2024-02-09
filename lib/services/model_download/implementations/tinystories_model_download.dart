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
      (downloadPath) async {
        final savePath = '${downloadPath.path}/stories15M.bin';
        if (!File(savePath).existsSync()) {
          await Dio().download(_downloadUrl, '$savePath.tmp',
              onReceiveProgress: (received, total) {
            controller.add(DownloadProgress(
              received,
              total == -1 ? received : total,
            ));
          });
          await File('$savePath.tmp').rename(savePath);
        }
        controller.close();
      },
    );

    return controller.stream.asBroadcastStream();
  }
}
