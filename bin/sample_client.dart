// import 'package:http/http.dart' as http;

// void main() async {
//   final response = await http.post(
//     Uri.parse('http://192.168.1.6:8080'),
//   );
//   print('Response status: ${response.statusCode}');
//   print('Response body: ${response.body}');

//   final response1 = await http.get(
//     Uri.parse('http://192.168.1.6:8080'),
//   );
//   print('Response1 status: ${response1.statusCode}');
//   print('Response1 body: ${response1.body}');
// }

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

void main() async {
  final channel = IOWebSocketChannel.connect('ws://192.168.1.6:8080/ws');

  channel.stream.listen((message) {
    print('Received message: $message');
  }, onError: (error) {
    print('Error: $error');
  }, onDone: () {
    print('WebSocket channel closed');
  });

  channel.sink.add('Hello, server!');

  // Wait for the server to respond
  await channel.sink.done;

  // Check the WebSocket close status
  if (channel.closeCode == status.normalClosure) {
    print('WebSocket channel closed normally');
  } else {
    print('WebSocket channel closed with error: ${channel.closeReason}');
  }
}
