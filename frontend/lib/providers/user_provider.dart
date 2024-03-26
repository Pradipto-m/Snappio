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

  get name => state.name;
  get username => state.username;
  get email => state.email;
  get phone => state.phone;

  void setUser(UserModel user) {
    state = user;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserModel>((ref) => 
  UserNotifier()
);
