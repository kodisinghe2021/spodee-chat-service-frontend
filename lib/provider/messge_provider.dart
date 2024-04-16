import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:ws_test_app/model/message_model.dart';

class MessageProvider with ChangeNotifier {
  MessageProvider._internal();
  static final MessageProvider _instance = MessageProvider._internal();
  factory MessageProvider() => _instance;
  List<MessageModel> _messages = [];

  void addMessage(MessageModel model) {
    Logger().i("One Message added ${_messages.length} :: Last ${model.message}");
    _messages.add(model);
    notifyListeners();
  }

  List<MessageModel> get getMessages => [..._messages];


}
