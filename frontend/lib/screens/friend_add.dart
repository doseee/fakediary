import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart';
import 'package:lottie/lottie.dart';

class FriendAdd extends StatefulWidget {
  const FriendAdd({super.key});

  @override
  State<FriendAdd> createState() => _FriendAddState();
}

Widget _friendWidget() {
  return Center(
    child: Container(
        width: 300,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xffD9D9D9),
        ),
        child:
        TextFormField(
          decoration: InputDecoration(
            // border: UnderlineInputBorder(),
            hintText: '  찾고자 하는 닉네임을 입력하세요',
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
          validator: (String? value) {
            if (value!.isEmpty) {
              return '닉네임을 입력해주세요';
            }
            return null;
          },
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        )),
  );
}

Widget _buttonSearch() {
  return GestureDetector(
      onTap: () async {
        // if (_formKey.currentState!.validate()) {
        //   print(_emailController.text);
        //   print(_passwordController.text);
        //   final bool result = await ApiService.login(
        //       _emailController.text, _passwordController.text);
        //   if (!mounted) return;
        //   if (result) {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => HomeScreen()));
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       SnackBar(
        //         content: Center(child: Text('login success!')),
        //       ),
        //     );
        //   } else {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       SnackBar(
        //         content: Center(child: Text('login failed.')),
        //       ),
        //     );
        //   }
        // }
      },
      child: Center(
        child: Lottie.asset('assets/lottie/searchFriend.json')
      ));
}

class _FriendAddState extends State<FriendAdd> {
  late String searchText;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img/background_pink_darken.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('FRIENDS'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Container(height: 1, color: Colors.grey),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _friendWidget(),
            Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30)
              ),
            )
          ],
        ),
      ),
    );
  }
}
