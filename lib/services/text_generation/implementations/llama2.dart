import 'dart:async';
import 'dart:isolate';

import 'package:path_provider/path_provider.dart';
import 'package:pocketllama2/utils/failure.dart';

import '../text_generation_interface.dart';
import '../../../utils/llama2.dart' as llama2;

final class Llama2 implements TextGenerationInterface {
  late Isolate process;

  @override
  Stream<String> generateText(String prompt) async* {
    final controller = StreamController<String>();
    final receivePort = ReceivePort();
    var text = "";
    final directory = await getApplicationCacheDirectory();

    process = await Isolate.spawn(
      (SendPort sendPort) {
        final stream = llama2
            .generate_text(
              checkpoint_path: '${directory.path}/stories15M.bin',
              tokenizer_path: '${directory.path}/tokenizer.bin',
              prompt: prompt,
            )
            .asBroadcastStream();
        stream.listen(
          (event) => sendPort.send(event),
          onDone: () => sendPort.send(null),
          onError: (error) => sendPort.send(
            const Failure('Text generation failed!'),
          ),
        );
      },
      receivePort.sendPort,
    );

    receivePort.listen((message) {
      if (message == null) {
        controller.close();
      } else if (message is Failure) {
        controller.addError(message);
      } else {
        text += message;
        controller.add(text);
      }
    });
    yield* controller.stream.asBroadcastStream();
  }

  @override
  Future<void> stop() async {
    process.kill(priority: Isolate.immediate);
  }
}
