import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snappio/models/chat_model.dart';

class ChatsNotifier extends StateNotifier<List<Messages>> {
  ChatsNotifier() : super([]);

  void addMessages (StreamController stream, Messages chats) {
    state = [...state, chats];
    stream.sink.add(state);
  }

  void clearMessages() {
    state = [];
  }
}

final chatsProvider =
StateNotifierProvider<ChatsNotifier, List<Messages>>((ref) => 
  ChatsNotifier()
);