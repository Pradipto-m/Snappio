import 'package:flutter/material.dart';
import 'package:snappio/screens/group_chat.dart';
import 'package:snappio/screens/private_chat.dart';

class ChatSection extends StatefulWidget {
  const ChatSection({super.key});

  @override
  State<ChatSection> createState() => _ChatSectionState();
}

class _ChatSectionState extends State<ChatSection> {

  final _chatformkey = GlobalKey<FormState>();
  final _roomformkey = GlobalKey<FormState>();
  final TextEditingController _chatController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();

  Future<void> onChatTap() async {
    if (_chatformkey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PrivateChat(userId: _chatController.text)));
      await Future.delayed(const Duration(seconds: 1));
      _chatController.clear();
    }
  }

  Future<void> onRoomTap() async {
    if (_roomformkey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChatRoom(roomId: _roomController.text)));
      await Future.delayed(const Duration(seconds: 1));
      _roomController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Snappio"),
        centerTitle: true,
        leading: const SizedBox(),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 65),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _chatformkey,
                child: Column(children: [
                  TextFormField(
                    controller: _chatController,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: "Enter friend's username to chat",
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Field cannot be empty";
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  InkWell(
                      onTap: onChatTap,
                      child: Container(
                        width: 300,
                        height: 51,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).cardColor,
                        ),
                        child: const Text("Start Conversation"),
                      )),
                ]),
              ),
              Form(
                key: _roomformkey,
                child: Column(children: [
                  const SizedBox(height: 100),
                  TextFormField(
                    controller: _roomController,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: "Enter a room name to group chat",
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Field cannot be empty";
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  InkWell(
                      onTap: onRoomTap,
                      child: Container(
                        width: 300,
                        height: 51,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).cardColor,
                        ),
                        child: const Text("Connect to room"),
                      )),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
