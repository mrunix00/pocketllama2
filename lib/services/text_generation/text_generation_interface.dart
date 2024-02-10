abstract class TextGenerationInterface {
  Stream<String> generateText(String prompt);

  Future<void> stop();
}
