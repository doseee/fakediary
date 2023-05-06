import 'package:flutter/material.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:lottie/lottie.dart';

import '../services/api_service.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget _userIdWidget() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'email',
        hintText: '이메일을 입력하세요',
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        labelStyle: TextStyle(color: Colors.grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.greenAccent),
        ),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return '이메일이 공백입니다';
        }
        return null;
      },
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
    );
  }

  Widget _passwordWidget() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'password',
        labelStyle: TextStyle(color: Colors.grey),
        hintText: '비밀번호를 입력하세요',
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.greenAccent),
        ),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return '비밀번호가 공백입니다';
        }
        return null;
      },
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
    );
  }

  Widget _buttonLogin() {
    return GestureDetector(
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            print(_emailController.text);
            print(_passwordController.text);
            final bool result = await ApiService.login(
                _emailController.text, _passwordController.text);
            if (!mounted) return;
            if (result) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Center(child: Text('login success!')),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Center(child: Text('login failed.')),
                ),
              );
            }
          }
        },
        child: Center(
          child: Container(
            width: 250,
            height: 50,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xff79F1A4),
                  Color(0xff0E5CAD),
                ]),
                borderRadius: BorderRadius.circular(25)),
            child: Center(
                child: Text(
              'LOGIN',
              style: TextStyle(color: Colors.white, fontSize: 14),
            )),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/background_1_littledark.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                body: Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80),
                      child: Column(children: [
                        Center(
                          child: Lottie.asset('assets/lottie/stars.json'),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _userIdWidget(),
                            SizedBox(
                              height: 20,
                            ),
                            _passwordWidget(),
                            SizedBox(
                              height: 40,
                            ),
                            _buttonLogin(),
                            SizedBox(
                              height: 280,
                            ),
                            Text(
                              'My Lieary',
                              style: TextStyle(color: Colors.blueGrey),
                            )
                          ],
                        ),
                      ]),
                    )))));
  }
}
