import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:ws_test_app/service/local_store.dart';
import 'package:ws_test_app/util/routes.dart';

import '../service/dio_init.dart';

class AllRepos {
  AllRepos._intenal();
  static final AllRepos _instance = AllRepos._intenal();
  factory AllRepos() => _instance;
// =========== Get Local Storage
  final LocalStore _localStore = LocalStore();

//:::::::::::::::::: CREATE CHAT ROOM
  Future<void> createChatRoom({
    required String username,
    required String roomName,
  }) async {
    Logger().i("Waiting......");
    try {
      Response response = await GetDio.getDio().post(
        CREATE_CHAT_ROOM,
        data: {
          "name": roomName,
          "description": "ILABS Platform",
          "updatedAt": "2024-01-30T08:09:01.897Z",
          "connectedUsers": [
            {"username": username, "joinedAt": "2024-01-30T08:09:01.897Z"}
          ]
        },
      );
      Logger().w("SUCCESS::${response.data["id"]}");

      String id =
          await _localStore.saveChatRoomId(response.data["id"].toString());
      Logger().w("CHAT ROOM ID::$id");
    } catch (e) {
      Logger().e("ERROR!");
    }
    Logger().i("Done!");
  }

//:::::::::::::::::: ADD MEMBER TO CHAT ROOM
  Future<void> addMemberToChat(String username) async {
    Logger().i("Waiting......");
    String id = await _localStore.getChatRoomId();
    if (id.isEmpty) {
      Logger().e("CHAT ROOM ID IS EMPTY");
      return;
    }
    try {
      Response response = await GetDio.getDio().put(
        "$ADD_MEMBER_TO_CHAT/$id",
        data: {
          "username": username,
          "joinedAt": "2024-01-30T08:05:55.554Z",
        },
      );

      Logger().w("SUCCESS::${response.data}");
    } catch (e) {
      Logger().e("ERROR!");
    }
    Logger().i("Done!");
  }

  Future<void> sendMessage({required String message}) async {
    Logger().i("Waiting......");
    Logger().i("Waiting......");
    String id = await _localStore.getChatRoomId();
    if (id.isEmpty) {
      Logger().e("CHAT ROOM ID IS EMPTY");
      return;
    }
    try {
      Response response = await GetDio.getDio().post(
        "$SEND_MESSAGE/$id",
        data: {
          "fromUser": "rivindu1w",
          "text": message,
        },
      );

      Logger().w("SUCCESS::${response.data}");
      Logger().w("SUCCESS STATUS CODE::${response.statusCode}");
    } catch (e) {
      Logger().e("ERROR! $e");
    }
    Logger().i("Done!");
  }

  Future<void> getAllMessages({required String forUser}) async {
    Logger().i("Waiting......");
    Logger().i("Waiting......");
    String id = await _localStore.getChatRoomId();
    if (id.isEmpty) {
      Logger().e("CHAT ROOM ID IS EMPTY");
      return;
    }
    try {
      Response response = await GetDio.getDio().get(
        "$SEND_MESSAGE/$id",
        queryParameters: {
          "forUser": forUser,
          "page": 0,
          "size": 20,
        },
      );

      Logger().w("SUCCESS::${response.data}");
      Logger().w("SUCCESS STATUS CODE::${response.statusCode}");
    } catch (e) {
      Logger().e("ERROR! $e");
    }
    Logger().i("Done!");
  }
}
