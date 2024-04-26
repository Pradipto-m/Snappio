// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:snappio/models/chat_model.dart';
import 'package:snappio/providers/chat_provider.dart';
import 'package:snappio/widgets/snackbar.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketController {
  late final io.Socket _socket;
  late final String user;
  late final WidgetRef _ref;

  SocketController (String userId, WidgetRef ref, ScrollController scroll) {
    user = userId;
    _socket = io.io('ws://192.168.0.103:3000/socket/v1?user=$userId',
      io.OptionBuilder().setTransports(['websocket']).build());
    _ref = ref;
  }

  void connectRoom(
    BuildContext context,
    String roomId,
    StreamController stream,
    ScrollController scroll
    ) {
    try {
      _socket.onConnect((_) {
        showSnackBar(context, 'connected');
        _socket.emit('join', roomId);
      });

      _socket.on('room', (message) {
        if (message['senderId'] == user) {
          _ref.read(chatsProvider.notifier).addMessages(
            stream,
            Messages(
              data: message['data'],
              senderId: message['senderId'],
              timestamp: message['timestamp'],
              isme: true,
          ));
        } else {
          _ref.read(chatsProvider.notifier).addMessages(
            stream,
            Messages(
              data: message['data'],
              senderId: message['senderId'],
              timestamp: message['timestamp'],
              isme: false,
          ));
        }

        scroll.animateTo(
          scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
        );
      });
    } catch (e) {
      showSnackBar(context, "Some error occured");
    }
  }

  void sendToRoom(
    BuildContext context,
    String roomId,
    String data
  ) async {
    try {
      _socket.emit('room', {
        'roomId': roomId,
        'data': data,
        'timestamp': DateFormat.jm().format(DateTime.now()),
      });
    } catch (e) {
      showSnackBar(context, "Some error occured");
      log(e.toString());
    }
  }

  void disconnect () {
    _socket.dispose();
  }
}
