class DownloadProgress {
  final int received;
  final int total;

  DownloadProgress(this.received, this.total);

  String asPercentage() {
    return ((received / total) * 100).toStringAsFixed(2);
  }
}
