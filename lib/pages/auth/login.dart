import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:social_media/app_images.dart';
import 'package:social_media/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset(
                Assets.imagesNLogo,
                colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
                height: 150,
                width: 150,
              ),
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Me',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Do',
                  style: TextStyle(
                      fontSize: 26,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Gap(20),
            const Text(
              'Welcome Back',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              decoration: InputDecoration(
                fillColor: kWhiteColor,
                filled: true,
                prefixIcon: const Icon(Icons.email),
                hintText: 'enter your email',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const Gap(20),
            TextField(
              decoration: InputDecoration(
                fillColor: kWhiteColor,
                filled: true,
                prefixIcon: const Icon(Icons.password),
                hintText: 'enter your password',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const Gap(20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kSecondryColor,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        )),
                    onPressed: () {},
                    child: Text(
                      'LOGIN',
                      style: TextStyle(color: kWhiteColor),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don`t have and account'),
                const Gap(30),
                GestureDetector(
                    child: Text(
                  'Register now',
                  style: TextStyle(color: kPrimaryColor),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
