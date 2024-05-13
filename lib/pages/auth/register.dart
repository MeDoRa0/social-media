import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:social_media/app_images.dart';
import 'package:social_media/colors.dart';
import 'package:social_media/pages/auth/login.dart';
import 'package:social_media/services/auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController dispalyNameCon = TextEditingController();
  TextEditingController userNameCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  TextEditingController emailController = TextEditingController();

  register() async {
    try {
      String response = await AuthService().sighUp(
          email: emailController.text,
          passWord: passwordCon.text,
          dispalyName: dispalyNameCon.text,
          userName: userNameCon.text);
      if (response == 'success') {
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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SvgPicture.asset(
                    Assets.imagesNLogo,
                    colorFilter:
                        ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  'creat new account',
                  style: TextStyle(fontSize: 18),
                ),
                TextField(
                  controller: dispalyNameCon,
                  decoration: InputDecoration(
                    fillColor: kWhiteColor,
                    filled: true,
                    prefixIcon: const Icon(Icons.person),
                    hintText: 'enter your name',
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
                  controller: userNameCon,
                  decoration: InputDecoration(
                    fillColor: kWhiteColor,
                    filled: true,
                    prefixIcon: const Icon(Icons.person_2_sharp),
                    hintText: 'enter your username',
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
                  controller: emailController,
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
                  controller: passwordCon,
                  obscureText: true,
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
                        onPressed: () {
                          register();
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(color: kWhiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('already have an account?'),
                    const Gap(30),
                    GestureDetector(
                      onTap: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false),
                      child: Text(
                        'Login',
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
