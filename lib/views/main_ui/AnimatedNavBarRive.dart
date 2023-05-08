import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:shopify_store_app/services/hex_color.dart';

class AnimatedNavBarRive extends StatefulWidget {
  const AnimatedNavBarRive({Key? key}) : super(key: key);

  @override
  _AnimatedNavBarRiveState createState() => _AnimatedNavBarRiveState();
}

class _AnimatedNavBarRiveState extends State<AnimatedNavBarRive> {
  SMIBool? status;

  void _OnRiveIconInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, "HOME_interactivity");
    artboard.addController(controller!);

    status = controller.findInput<bool>("active") as SMIBool;
  }

  void _onHomeButtonPressed() {
    status!.change(true);
    Future.delayed(const Duration(seconds: 1), () {
      status!.change(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: HexColor("#EBEBEB"),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        ),
        child: MaterialButton(
          onPressed: _onHomeButtonPressed,
          child: RiveAnimation.asset(
            'assets\rive_animations\animated-icon-set.riv',
            artboard: "HOME",
            stateMachines: [""],
            onInit: _OnRiveIconInit,
          ),
        ),
      ),
    );
  }
}
