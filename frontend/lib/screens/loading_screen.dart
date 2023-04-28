import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Widget build(BuildContext context) {
    return Scaffold(//Colors.amber
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff0A3442), Color(0xff4F4662)],
            stops: [0.4, 1.0],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(80),
          child: Column(
            children: [
              Flexible(flex: 3, child: Container(),),
              Flexible(flex: 2, child: Container(
                decoration: BoxDecoration(color: Colors.blueGrey),
                child: Center(
                  child: Text('AD', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
                ),
              ),),
              Flexible(flex: 1, child: Container(),),
              Flexible(flex: 10, child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/img/example.jpg'
                        )
                    )
                ),
                child: Column(
                  children: [
                    Flexible(flex: 1, child: Container(),),
                    Flexible(flex: 1, child: Center(
                      child: SpinKitFadingCircle(
                        color: Colors.black,
                        size: 70.0,
                      ),
                    ))
                  ],
                ),
              ),),
              // Flexible(flex: 2, child: Center(
              //   child: SpinKitFadingCube(
              //     color: Colors.white70,
              //     size: 40.0,
              //   ),
              // )),
              Flexible(flex: 1, child: Container()),
              Flexible(flex: 2, child: Container(
                child: Text('사용자를 놀리는 중 ㅋㅋ', style: TextStyle(color: Colors.white, fontSize: 16),),
              ),)
            ],
          ),
        )
      )
    );
  }
}
