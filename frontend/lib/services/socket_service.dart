import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:snappio/models/chat_model.dart';
import 'package:snappio/providers/chat_provider.dart';
import 'package:snappio/providers/user_provider.dart';
import 'package:snappio/widgets/snackbar.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketController {
  late final io.Socket _socket;
  late final WidgetRef _ref;
  // create the socket instance and assign the variables
  SocketController (String token, WidgetRef ref, ScrollController scroll) {
    _socket = io.io('ws://192.168.0.104:3000/socket/v1', io.OptionBuilder()
      .setTransports(['websocket'])
      .enableReconnection()
      .setAuth({'token': token})
      .build());
    _ref = ref;
  }

  // connect to the room socket
  void connectRoom(
    BuildContext context,
    String roomId,
    StreamController stream,
    ScrollController scroll
    ) {
    try {
      _socket.onConnect((_) {
        _socket.emit('join', roomId);
        showSnackBar(context, 'connected');
      });

      _socket.on('room', (message) {
        if (message['senderId'] == _ref.read(userProvider.notifier).username) {
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
    } catch (err) {
      showSnackBar(context, "Some error occured");
      log(err.toString());
    }
  }

  // connect to the private socket
  void connectPrivate(
    BuildContext context,
    StreamController stream,
    ScrollController scroll
    ) {
    try {
      _socket.onConnect((_) {
        showSnackBar(context, 'connected');
      });

      _socket.on('private', (message) {
        _ref.read(chatsProvider.notifier).addMessages(
          stream,
          Messages(
            data: message['data'],
            senderId: message['senderId'],
            timestamp: message['timestamp'],
            isme: false,
        ));

        scroll.animateTo(
          scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
        );
      });
    } catch (err) {
      showSnackBar(context, "Some error occured");
      log(err.toString());
    }
  }

  // emit chats to individual
  void sendToPrivate(
    BuildContext context,
    String receiverId,
    String data,
    StreamController stream,
    ScrollController scroll
  ) async {
    try {
      _socket.emit('private', {
        'receiverId': receiverId,
        'data': data,
        'timestamp': DateFormat.jm().format(DateTime.now()),
      });

      _ref.read(chatsProvider.notifier).addMessages(
        stream,
        Messages(
          data: data,
          senderId: _ref.read(userProvider.notifier).username,
          timestamp: DateFormat.jm().format(DateTime.now()),
          isme: true,
      ));

      scroll.animateTo(
        scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    } catch (err) {
      showSnackBar(context, "Some error occured");
      log(err.toString());
    }
  }

  // emit chats to the room
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
    } catch (err) {
      showSnackBar(context, "Some error occured");
      log(err.toString());
    }
  }

  void disconnect () {
    _socket.dispose();
  }
}
