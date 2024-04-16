import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ws_test_app/model/message_model.dart';
import 'package:ws_test_app/provider/messge_provider.dart';
import 'package:ws_test_app/repository/all_repos.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:ws_test_app/util/constant.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);
  final TextEditingController _message = TextEditingController();
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Consumer<MessageProvider>(
          builder: (context, value, child) {
            List<MessageModel> messages = value.getMessages;
            return SizedBox(
              height: h(context),
              width: w(context),
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(messages[index].message),
                          subtitle: Text(
                              "${messages[index].fromUser}  ${messages[index].time}"),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: w(context),
                    height: h(context) * .1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: _message,
                            decoration: decoration("Type you message.."),
                          ),
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: _isLoading,
                          builder: (context, value, child) => Padding(
                            padding: const EdgeInsets.only(
                              right: 20,
                              top: 10,
                            ),
                            child: value
                                ? LoadingAnimationWidget.horizontalRotatingDots(
                                    color: Colors.blueAccent,
                                    size: 20,
                                  )
                                : IconButton(
                                    padding: const EdgeInsets.all(0),
                                    onPressed: () async {
                                      _isLoading.value = true;
                                      await AllRepos().sendMessage(
                                        message: _message.text,
                                      );
                                      _message.clear();
                                      _isLoading.value = false;
                                    },
                                    icon: Transform(
                                      transform: Matrix4.rotationZ(-.7),
                                      child: const Icon(
                                        Icons.send,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Expanded(
                  //   child: Container(
                  //   color: Colors.red,
                  //   child: Row(
                  //     children: [

                  //     ],
                  //   ),
                  // ),),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
