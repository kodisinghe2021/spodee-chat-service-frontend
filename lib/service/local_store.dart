import 'package:get_storage/get_storage.dart';

class LocalStore {
  LocalStore._intenal();
  static final LocalStore _instance = LocalStore._intenal();
  factory LocalStore() => _instance;

  final _box = GetStorage();
  String _keyForId = "roomId";

  Future<String> saveChatRoomId(String message) async {
    await _box.write(_keyForId, message);
    if (_box.hasData(_keyForId)) {
      return _box.read(_keyForId);
    } else {
      return "";
    }
  }

  Future<String> getChatRoomId() async {
    if (_box.hasData(_keyForId)) {
      return await _box.read(_keyForId);
    } else {
      return "";
    }
  }
}
