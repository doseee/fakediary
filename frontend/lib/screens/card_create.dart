import 'package:flutter/material.dart';
import 'package:frontend/screens/menu_screen.dart';

class CardCreate extends StatelessWidget {
  const CardCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.3, 0.6, 0.9],
          colors: [
            Color(0xff0f2027),
            Color(0xff203a43),
            Color(0xff2c5364),
          ],
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MenuScreen()));
                        },
                        child: Image(
                          image: AssetImage(
                            'assets/img/icon_menu_page.png',
                          ),
                          width: 45,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image(
                      image: AssetImage(
                        'assets/img/icon_cam.png',
                      ),
                      width: 45,
                    ),
                  ],
                ),
                Transform.translate(
                  offset: Offset(0, -50),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image(
                      image: AssetImage(
                        'assets/img/card_example.jpg',
                      ),
                      width: 161,
                      height: 267,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '주인공',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
          // body: Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 50),
          //   child: Column(
          //     children: [
          //       SizedBox(
          //         height: 50,
          //       ),
          //       ElevatedButton(
          //         style: ButtonStyle(
          //           // fixedSize: MaterialStateProperty.all(const Size(50, 50)),
          //           backgroundColor:
          //               MaterialStateProperty.all(Colors.transparent),
          //           // shadowColor: MaterialStateProperty.all(Colors.transparent),
          //         ),
          //         onPressed: () {
          //           Navigator.push(context,
          //               MaterialPageRoute(builder: (context) => CameraExample()));
          //         },
          //         child: Lottie.asset(
          //           'assets/img/icon_cam.png',
          //           width: 80,
          //           height: 80,
          //         ),

          //         // Positioned(
          //         //   top: 0,
          //         //   right: -40,
          //         //   child: SizedBox(
          //         //     width: 180,
          //         //     height: 180,
          //         //     child: Lottie.asset('assets/lottie/camera_loop.json'),
          //         //   ),
          //         // ),
          //       ),
          //     ],
          //   ),
          // ),
          ),
    );
  }
}
