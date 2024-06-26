// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snappio/models/chat_model.dart';
import 'package:snappio/providers/chat_provider.dart';
import 'package:snappio/services/socket_service.dart';

class PrivateChat extends ConsumerStatefulWidget {
  final String userId;
  const PrivateChat({super.key, required this.userId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PrivateChatState();
}

class _PrivateChatState extends ConsumerState<PrivateChat> {

  late final SocketController socket;
  late final StreamController<List<Messages>> stream;
  final TextEditingController _message = TextEditingController();
  final ScrollController _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    connection();
  }

  @override
  void dispose() {
    stream.close();
    super.dispose();
  }

  void connection () async {
    stream = StreamController<List<Messages>>();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    socket = SocketController(prefs.getString('socketKey')!, ref, _scroll);
    socket.connectPrivate(context, stream, _scroll);
  }

  void disconnect (BuildContext context, WidgetRef ref) {
    ref.read(chatsProvider.notifier).clearMessages();
    socket.disconnect();
    Navigator.pop(context);
  }

  void sendMessage(BuildContext context) {
    if (_message.text.isNotEmpty) {
      socket.sendToPrivate(
        context,
        widget.userId,
        _message.text,
        stream,
        _scroll
      );
      _message.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userId,
          style: Theme.of(context).textTheme.labelLarge),
        leading: IconButton(
          icon: const Icon(Ionicons.arrow_back),
          onPressed: () => disconnect(context, ref),
        )
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(children: [
          Expanded(
            child: StreamBuilder<List<Messages>>(
              initialData: const [],
              stream: stream.stream,
              builder: (context, snapshot) {
                final List<Messages> chats = snapshot.data ?? [];
                return chats.isNotEmpty ?
                  ListView.builder(
                    shrinkWrap: true,
                    controller: _scroll,
                    physics: const BouncingScrollPhysics(),
                    itemCount: chats.length + 1,
                    itemBuilder: (context, index) {
                      return index == chats.length ?
                      const SizedBox(height: 90) :
                      Container(
                        alignment: chats[index].isme! ? Alignment.centerRight : Alignment.centerLeft,
                        margin: chats[index].isme!
                          ? EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.15)
                          : EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.15),
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Bubble(
                          margin: const BubbleEdges.only(top: 12),
                          padding: const BubbleEdges.symmetric(horizontal: 15, vertical: 10),
                          alignment: chats[index].isme! ? Alignment.centerRight : Alignment.centerLeft,
                          nip: chats[index].isme! ? BubbleNip.rightTop : BubbleNip.leftTop,
                          radius: const Radius.circular(14),
                          color: chats[index].isme! ? Theme.of(context).cardColor : Colors.grey[700],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${chats[index].senderId}:', style: Theme.of(context).textTheme.bodySmall),
                              const SizedBox(height: 5),
                              Text(chats[index].data, style: Theme.of(context).textTheme.bodyMedium),
                              const SizedBox(height: 5),
                              Text(chats[index].timestamp, style: Theme.of(context).textTheme.bodySmall),
                          ]),
                        ),
                      );
                    },
                  ) : Center(child: LoadingAnimationWidget.waveDots(
                    color: Theme.of(context).cardColor,
                    size: 80
                  ));
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).cardColor.withOpacity(0.6),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Form(
                    child: TextFormField(
                      controller: _message,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        hintStyle: Theme.of(context).textTheme.bodySmall,
                      ),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  margin: const EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).cardColor,
                  ),
                  child: InkWell(
                    onTap: () => sendMessage(context),
                    child: const Icon(Ionicons.send, size: 30),
                  ),
                ),
              ],
            ),
          )
        ]),
      )
    );
  }
}