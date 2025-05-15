import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test/services/auth.dart';
import 'package:test/utility/ScalingUtility.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = ScalingUtility(context: context)..setCurrentDeviceSize();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                try {
                  User? user = await Authentication().signInWithGoogle(
                    context: context,
                    onSignIn: (User? user) {
                      context.go(
                        '/categories',
                      );
                    },
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Signed in as ${user?.displayName ?? ""}')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Sign-In Failed: $e')),
                  );
                }
              },
              child: Container(
                padding: scale.getPadding(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(
                        Radius.circular(scale.getScaledFont(10)))),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                        height: scale.getScaledHeight(30),
                        child: Image.asset("assets/google.png")),
                    SizedBox(
                      width: scale.getScaledWidth(15),
                    ),
                    Text(
                      "Sign in with Google",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: scale.getScaledFont(20)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
