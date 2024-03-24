import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snappio/models/user_model.dart';

final initialUser = UserModel(
  id: '',
  username: '',
  name: '',
  phone: '',
  email: '',
  ver: 0,
);

class UserNotifier extends StateNotifier<UserModel> {
  UserNotifier() : super(initialUser);

  void setUser(UserModel user) {
    state = user;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserModel>((ref) => 
  UserNotifier()
);
