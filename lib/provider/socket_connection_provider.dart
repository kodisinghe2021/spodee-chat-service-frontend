import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:ws_test_app/model/message_model.dart';
import 'package:ws_test_app/provider/messge_provider.dart';
import 'package:ws_test_app/service/local_store.dart';
import 'package:ws_test_app/util/routes.dart';

//==================================== init stomp client and activate
Future<bool> activateStompClient() async {
  Logger().i("ACTIVATE>>>>");
  stompClient.activate();
  if (stompClient.connected) {
    Logger().i("Connected.........");
  }
  await Future.delayed(Duration(milliseconds: 1000));
  return true;
}

//==================================== Make stomp client object
final stompClient = StompClient(
  config: StompConfig(
    url: WS_URL,
    onConnect: subscribeWS,
    onWebSocketDone: () async {
      Logger().i('Connection Done !');
    },
    onDisconnect: (StompFrame frame) async {
      Logger().i('Disconnected ... ${frame.body}');
    },
    beforeConnect: () async {
      Logger().i('waiting to connect...');
    },
    onWebSocketError: (dynamic error) =>
        Logger().e("Connection ERRPR:: ${error.toString()}"),
    // stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
    // webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'},
  ),
);

//====================================== Subscribe stomp client
void subscribeWS(StompFrame frame) async {
  MessageProvider messageProvider = MessageProvider();
  Logger().i("ON CONNECT ++++==>> Triggered");
  final chatRoomId = await LocalStore().getChatRoomId();
  if (chatRoomId.isEmpty) {
    Logger().d("Chat Room ID IS EMPTY");
    return;
  }
  Logger().d("Chat Room ID:: $chatRoomId");
  Logger().w("Waiting for subscribe");
  await Future.delayed(const Duration(milliseconds: 1000));
  stompClient.subscribe(
    destination: wsSubscribe(chatRoomId),
    callback: (frame) {
      Logger().i("On Subscribe :: Callback :: ==>> ${frame.body.toString()}");
      if (frame.body != null) {
        Map<String, dynamic> res =
            jsonDecode(frame.body.toString()) as Map<String, dynamic>;
        MessageModel model = MessageModel(
          message: res["text"].toString(),
          time: res["date"].toString().split(".")[0],
          fromUser: res["fromUser"],
        );
        Logger().i(
            "Message from : ${model.fromUser} at ${model.time} >> ${model.message}");
        messageProvider.addMessage(model);
      } else {
        Logger().i("body is null");
      }
    },
  );
}
