import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:test/utility/ScalingUtility.dart';

class loadingWidget extends StatelessWidget {
  const loadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = ScalingUtility(context: context)..setCurrentDeviceSize();
    return Center(
      child: SizedBox(
        height: scale.getScaledHeight(150),
        child: Lottie.asset('assets/loading.json'),
      ),
    );
  }
}
