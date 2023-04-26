import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../main.dart';
import '../services/api_service.dart';
import 'menu_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget _userIdWidget(){
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
      validator: (String? value){
        if (value!.isEmpty){
          return '이메일이 공백입니다';
        }
        return null;
      },
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),);
  }

  Widget _passwordWidget(){
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
      validator: (String? value){
        if (value!.isEmpty) {
          return '비밀번호가 공백입니다';
        }
        return null;
      },
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),);
  }

  Widget _buttonLogin(){
    return Center(
        child: Container(
        width: 250,
        height: 50,
        decoration: BoxDecoration(
        gradient: LinearGradient(
        colors: [
        Color(0xff79F1A4),
        Color(0xff0E5CAD),
    ]
    ),
    borderRadius: BorderRadius.circular(25)
    ),
    child: Flexible(flex: 1, child: ElevatedButton(
    onPressed: () { Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => const Login(),
    ));},
    style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    elevation: 0.0,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30.0),
    )
    ),
    child:
    Text('LOGIN', style: TextStyle(color: Colors.white, fontSize: 14),)
    ),)));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
          decoration: BoxDecoration(
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
              image: AssetImage('assets/img/main_background.jpg'),
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
                child: Column(
                  children: [
                    Flexible(flex: 3,child: Container(
                      child: Center(
                        child: Lottie.asset('assets/lottie/stars.json'),
                      ),
                    ),
                    ),
                    Flexible(flex: 12,child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(flex: 3, child: Column(
                          children: [
                            Flexible(flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                                  child: Column(
                                    children: [
                                      _userIdWidget(),
                                      SizedBox(height: 20,),
                                      _passwordWidget(),
                                      SizedBox(height: 20,),
                                      GestureDetector(
                                        onTap: () async {
                                          if (_formKey.currentState!.validate()) {
                                            final bool result = await ApiService.login(_emailController.text, _passwordController.text);
                                            if (!mounted) return;
                                            if (result) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => MainScreen()));
                                            }
                                          }
                                        },
                                        child: _buttonLogin(),
                                      )
                                    ],
                                  ),
                                )),
                          ],
                        )),
                        Flexible(flex: 1, child: Text('My Lieary', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w800),),)
                      ],
                    ),
                    ),
                  ],
                ),
              )
          )
      ),
    );
  }
}