import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:snappio/services/auth_service.dart';

class Onboard extends StatefulWidget {
  static const String routeName = '/onboard';
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard>
  with SingleTickerProviderStateMixin {
  
  static int _page = 0;
  final PageController _pageController = PageController();
  late AnimationController _animateController;

  @override
  void initState() {
    super.initState();
    _animateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
  }

  @override
  void dispose() {
    _animateController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 245, left: 52, right: 52, bottom: 100
        ),
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: AnimatedCrossFade(
                firstChild: _page == 2 ? 
                  Lottie.asset("assets/images/animation3.json") :
                  Lottie.asset("assets/images/animation1.json"),
                secondChild: Lottie.asset("assets/images/animation2.json"),
                crossFadeState: _page == 0 || _page == 2 ?
                  CrossFadeState.showFirst : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 450),
              ),
            ),
            AnimatedCrossFade(
              firstChild: _page == 2 ? 
                Text("Privacy and Safety first!",
                  style: Theme.of(context).textTheme.bodySmall) :
                Text("Private and Group Chats!",
                  style: Theme.of(context).textTheme.bodySmall),
              secondChild: Text("Posts, Stories, and more!",
                style: Theme.of(context).textTheme.bodySmall),
              crossFadeState: _page == 0 || _page == 2 ?
                CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 400),
            ),
            const SizedBox(height: 100),
            Row(
              children: [
                Expanded(
                  child: AnimatedSmoothIndicator(
                    activeIndex: _page,
                    count: 3,
                    onDotClicked: (index) =>
                      setState(() => _page = index),
                    effect: ExpandingDotsEffect(
                      activeDotColor: Theme.of(context).cardColor,
                      dotColor: Theme.of(context).highlightColor,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 8,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () =>
                    _page < 2 ?
                    setState(() => _page++) :
                    AuthServices().onboarded(context, onboarding: true),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 320),
                    height: 50,
                    width: _page == 2 ? 100 : 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: _page == 2 ?
                      Text("SignUp",
                      style: Theme.of(context).textTheme.bodySmall)
                      : Icon(Ionicons.chevron_forward,
                        color: Theme.of(context).highlightColor),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
