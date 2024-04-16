import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:ws_test_app/controller/stomp_controller.dart';
import 'package:ws_test_app/provider/socket_connection_provider.dart';
import 'package:ws_test_app/repository/all_repos.dart';
import 'package:ws_test_app/screen/chat_page.dart';
import 'package:ws_test_app/service/local_store.dart';
import 'package:ws_test_app/util/constant.dart';
import 'package:ws_test_app/widgets/default_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _userCtrl = TextEditingController();
  final TextEditingController _messageCtrl = TextEditingController();
  final TextEditingController _roomNameCtrl = TextEditingController();
  final TextEditingController _userNameCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: w(context),
          height: h(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Create Chat Room
              SizedBox(
                width: w(context) * .6,
                // height: h(context) * .15,
                child: TextFormField(
                  controller: _roomNameCtrl,
                  decoration: decoration("Chat Room Name"),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: w(context) * .6,
                // height: h(context) * .15,
                child: TextFormField(
                  controller: _userNameCtrl,
                  decoration: decoration("Your Name"),
                ),
              ),
              const SizedBox(height: 10),

              DefaultButton(
                  text: "Create Chat Room",
                  onTap: () async {
                    await AllRepos().createChatRoom(
                      roomName: _roomNameCtrl.text,
                      username: _userNameCtrl.text,
                    );
                    // stompInit();
                  }),
              const SizedBox(height: 10),
              const Divider(thickness: 2),
              SizedBox(
                width: w(context) * .6,
                // height: h(context) * .15,
                child: TextFormField(
                  controller: _userCtrl,
                  decoration: decoration("User name"),
                ),
              ),
              //Add Member To Chat room
              const SizedBox(height: 10),
              DefaultButton(
                onTap: () async =>
                    await AllRepos().addMemberToChat(_userCtrl.text),
                text: "Add Member",
              ),
              const SizedBox(height: 30),
              //=================== goto chat page
              DefaultButton(
                onTap: () async {
                  String id = await LocalStore().getChatRoomId();
                  if (id.isEmpty) {
                    Logger().i("ID IS EMPTY");
                    return;
                  }
                  await activateStompClient();
                  // subscribeWS();
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(),
                    ),
                  );
                },
                text: "Go To Chat Room",
              ),
              // SizedBox(
              //   width: w(context) * .6,
              //   // height: h(context) * .15,
              //   child: TextFormField(
              //     controller: _messageCtrl,
              //     decoration: decoration("Message"),
              //   ),
              // ),
              // const SizedBox(height: 10),

              // //Send Message to the room
              // DefaultButton(
              //   onTap: () async =>
              //       await AllRepos().sendMessage(message: _messageCtrl.text),
              //   text: "Send Message",
              // ),

              // const SizedBox(height: 10),

              // DefaultButton(
              //   onTap: () async =>
              //       await AllRepos().getAllMessages(forUser: "rivindu1w"),
              //   text: "Get All Messages",
              // ),
              // const SizedBox(height: 10),
              // DefaultButton(
              //   onTap: () => stompInit(),
              //   text: "Init Socket",
              // ),
              // const SizedBox(height: 10),
              // DefaultButton(
              //   onTap: () => subscribeWS(),
              //   text: "Subscribe",
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
