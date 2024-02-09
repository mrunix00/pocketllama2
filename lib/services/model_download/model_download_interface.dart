import 'download_progress.dart';

abstract class ModelDownloadInterface {
  Future<bool> isDownloaded();
  Stream<DownloadProgress> downloadModel();
  Future<void> cancelCurrentDownload();
}
