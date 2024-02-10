import 'dart:async';
import 'dart:isolate';

import 'package:path_provider/path_provider.dart';

import '../text_generation_interface.dart';
import '../../../utils/llama2.dart' as llama2;

class _Message {
  _Message({required this.sendPort});
  SendPort sendPort;
}

final class Llama2 implements TextGenerationInterface {
  @override
  Stream<String> generateText(String prompt) async* {
    final controller = StreamController<String>();
    final receivePort = ReceivePort();
    var text = "";
    final directory = await getApplicationDocumentsDirectory();

    Isolate.spawn(
      (_Message message) {
        final stream = llama2
            .generate_text(
              checkpoint_path: '${directory.path}/stories15M.bin',
              tokenizer_path: '${directory.path}/tokenizer.bin',
              prompt: prompt,
            )
            .asBroadcastStream();
        stream
            .listen((event) => message.sendPort.send(event))
            .onDone(() => message.sendPort.send(null));
      },
      _Message(sendPort: receivePort.sendPort),
    );

    receivePort.listen((message) {
      if (message != null) {
        text += message;
        controller.add(text);
      } else {
        controller.close();
      }
    });
    yield* controller.stream.asBroadcastStream();
  }
}
