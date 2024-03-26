import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snappio/providers/user_provider.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {

  @override
  Widget build(BuildContext context) {

    final name = ref.watch(userProvider.notifier).name;
    final username = ref.watch(userProvider.notifier).username;
    final email = ref.watch(userProvider.notifier).email;
    final phone = ref.watch(userProvider.notifier).phone;
    final auth = "+91 ${phone[3]}${phone[4]}******${phone[11]}${phone[12]}";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Snappio"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/images/avatar.png"),
              ),
            ),
            const SizedBox(height: 20),
            Text("Name:  $name", style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 20),
            Text("Username:  $username", style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 20),
            Text("Email:  $email", style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 20),
            Text("Phone:  $auth", style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 100),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text("No Posts Yet!"),
            ),
          ],
        ),
      ),
    );
  }
}
