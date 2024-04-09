import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:snappio/services/auth_service.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static const String routeName = '/splash';
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  @override
  void initState() {
    super.initState();

    AuthServices().onboarded(context).then((val) {
      if(!val){
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacementNamed(context, '/onboard');
        });
      } else {
        AuthServices().userAuth(context, ref).then((user) {
          if(!user){
            Future.delayed(const Duration(milliseconds: 1200), () {
              Navigator.pushReplacementNamed(context, '/auth');
            });
          } else {
            Future.delayed(const Duration(milliseconds: 1200), () {
              Navigator.pushReplacementNamed(context, '/navigation');
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(child: SizedBox()),
          Image.asset("assets/images/logo.png",
            height: 180, width: double.infinity),
          const SizedBox(height: 100),
          LoadingAnimationWidget.stretchedDots(
            color: Colors.orange.shade400,
            size: 80
          ),
          const SizedBox(height: 200),
          Text("Made with  ❤️  by Pro", style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
