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
          child: Column(
            children: [
              const Text(
                '이메일',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: '이메일을 입력하세요.',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return '무언가 입력하세요.';
                  }
                  return null;
                },
              ),
              const Text(
                '비밀번호',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: '비밀번호를 입력하세요.',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return '무언가 입력하세요.';
                  }
                  return null;
                },
              ),
              const Text(
                '닉네임',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              TextFormField(
                controller: _nicknameController,
                decoration: const InputDecoration(
                  hintText: '닉네임을 입력하세요.',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return '무언가 입력하세요.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
