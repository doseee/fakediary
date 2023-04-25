import 'package:flutter/material.dart';

class RegistScreen extends StatefulWidget {
  const RegistScreen({super.key});

  @override
  State<RegistScreen> createState() => _RegistScreentState();
}

class _RegistScreentState extends State<RegistScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff0F2027),
            Color(0xff203A43),
            Color(0xff2C5364),
          ],
          stops: [0, 0.4, 1.0],
        ),
        image: DecorationImage(
          image: AssetImage('assets/img/bg_galaxy.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '이메일',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _emailController,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white,
                      )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white,
                      )),
                      hintText: '이메일을 입력하세요.',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      )),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return '무언가 입력하세요.';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                const Text(
                  '비밀번호',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white,
                      )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white,
                      )),
                      hintText: '비밀번호를 입력하세요.',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      )),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return '무언가 입력하세요.';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                const Text(
                  '닉네임',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _nicknameController,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white,
                      )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white,
                      )),
                      hintText: '닉네임을 입력하세요.',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      )),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return '무언가 입력하세요.';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 75,
                ),
                Container(
                  width: 275,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Center(child: Text('회원가입')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
