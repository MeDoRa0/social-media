import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:social_media/app_images.dart';
import 'package:social_media/colors.dart';
import 'package:social_media/layout.dart';
import 'package:social_media/pages/auth/register.dart';
import 'package:social_media/services/auth.dart';
import 'package:social_media/widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController passwordCon = TextEditingController();
  TextEditingController emailController = TextEditingController();
  signIn() async {
    try {
      String response = await AuthService()
          .signIn(email: emailController.text, passWord: passwordCon.text);
      if (response == 'success') {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LayoutPage(),
            ),
            (route) => false);
        print('done');
      } else {
        print(response);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

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
            CustomTextfield(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              hintText: 'enter your email',
              icon: Icons.email,
            ),
            const Gap(20),
            CustomTextfield(
              keyboardType: TextInputType.visiblePassword,
              controller: passwordCon,
              hintText: 'enter your password',
              icon: Icons.password,
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
                    onPressed: () {
                      signIn();
                    },
                    child: Text(
                      'LOGIN',
                      style: TextStyle(color: kWhiteColor),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don`t have and account'),
                const Gap(30),
                GestureDetector(
                  onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                      (route) => false),
                  child: Text(
                    'Register now',
                    style: TextStyle(color: kPrimaryColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
