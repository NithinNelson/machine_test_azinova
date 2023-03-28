import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:machine_test_azinova/screens/home_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool eye = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.red[700],
                      borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(height: 50),
                Text(
                  "WELCOME",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.red[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  maxLines: 1,
                ),
                Text(
                  "Log in to continue",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 17),
                  maxLines: 1,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                      labelText: 'Email Address',
                      icon: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFE3E8F1)))),
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !eye,
                  decoration: InputDecoration(
                      label: Text('Password'),
                      icon: Icon(
                        Icons.lock_open_outlined,
                        color: Colors.black,
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFE3E8F1))),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              eye = !eye;
                            });
                          },
                          icon: FaIcon(eye
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash))),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Forgot Password?",
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 16),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[700],
                      minimumSize: Size(1.sw - 40, 50.sp),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 0),
                  onPressed: () {
                    _lodIn();
                  },
                  child: Text(
                    "Sign in",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      maxLines: 1,
                    ),
                    Text(
                      "Signup",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 15, color: Colors.red[700]),
                      maxLines: 1,
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Skip",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          maxLines: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.arrow_forward_outlined,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _lodIn() {
    if (_usernameController.text == "admin" &&
        _passwordController.text == "admin") {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }), (route) => false);
    }
  }
}
