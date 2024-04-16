// import 'dart:convert';

// import 'package:logger/logger.dart';
// import 'package:stomp_dart_client/stomp.dart';
// import 'package:stomp_dart_client/stomp_config.dart';
// import 'package:stomp_dart_client/stomp_frame.dart';
// import 'package:ws_test_app/model/message_model.dart';
// import 'package:ws_test_app/provider/messge_provider.dart';
// import 'package:ws_test_app/service/local_store.dart';

// void subscribeWS() async {
//   MessageProvider messageProvider = MessageProvider();
//   Logger().i("ON CONNECT ++++==>> Triggered");
//   final chatRoomId = await LocalStore().getChatRoomId();
//   if (chatRoomId.isEmpty) {
//     Logger().d("Chat Room ID IS EMPTY");
//     return;
//   }
//   Logger().d("Chat Room ID:: $chatRoomId");
//   Logger().w("Waiting for subscribe");

//   stompClient.subscribe(
//     destination: "/topic/${chatRoomId}.public.messages",
//     // destination: '/topic/$chatRoomId',
//     callback: (frame) {
//       // List<dynamic>? result = json.decode(frame.body!);
//       Logger().i("On Subscribe :: Callback :: ==>> ${frame.body.toString()}");
//       if (frame.body != null) {
//         Map<String,dynamic> res = jsonDecode(frame.body.toString()) as  Map<String,dynamic>;
//       MessageModel model =  MessageModel(message: res["text"].toString(), time: res["date"].toString().split(".")[0], fromUser: res["fromUser"]);
//         Logger().i("Message from : ${model.fromUser} at ${model.time} >> ${model.message}");
//       messageProvider.addMessage(model);
//       } else {
//         Logger().i("body is null");
//       }
//     },
//   );

// }

// final stompClient = StompClient(
//   config: StompConfig(
//     url: 'ws://eadf-2402-4000-2341-2ac1-903c-5284-179-211f.ngrok-free.app/ws',
//     onConnect: (StompFrame frame) async {
//       Logger().i('On Connect:: ${frame.body}');
//     },
//     onWebSocketDone: () async {
//       Logger().i('Connection Done !');
//     },
//     onDisconnect: (StompFrame frame) async {
//       Logger().i('Disconnected ... ${frame.body}');
//     },
//     beforeConnect: () async {
//       Logger().i('waiting to connect...');
//     },
//     onWebSocketError: (dynamic error) =>
//         Logger().e("Connection ERRPR:: ${error.toString()}"),
//     // stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
//     // webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'},
//   ),
// );

// void stompInit() {
//   Logger().i("ACTIVATE>>>>");
//   stompClient.activate();
// }
