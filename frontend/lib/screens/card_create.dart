import 'package:flutter/material.dart';
import 'package:frontend/screens/menu_screen.dart';
import 'package:gradient_borders/gradient_borders.dart';

class CardCreate extends StatefulWidget {
  const CardCreate({super.key});

  @override
  State<CardCreate> createState() => _CardCreateState();
}

class _CardCreateState extends State<CardCreate> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _personController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.4, 1.0],
            colors: [
              Color(0xff0A3442),
              Color(0xff4F4662),
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
              child: Form(
                key: _formKey,
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
                    CheckRow(text: '주인공', buttonText: '기본 주인공으로 설정'),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _personController,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
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
                      height: 45,
                    ),
                    CheckRow(text: '장소', buttonText: '현재 위치로 설정'),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _personController,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
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
                      height: 20,
                    ),
                    Text(
                      '추가설정',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: GradientBoxBorder(
                                gradient: LinearGradient(stops: [
                              0,
                              1.0
                            ], colors: [
                              Color(0xff65D5A6),
                              Color(0xff1E72AC),
                            ])),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0, 1.0],
                              colors: [
                                Color(0xff65D5A6),
                                Color(0xff1E72AC),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          '자동생성키워드1',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 251,
                      height: 23,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff263344),
                            Color(0xff1B2532).withOpacity(0.538),
                            Color(0xff1C2A3D).withOpacity(0.502),
                            Color(0xff1E2E42).withOpacity(0.46),
                            Color(0xff364B66).withOpacity(0.33),
                            Color(0xff2471D6).withOpacity(0),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff000000).withOpacity(0.25),
                            offset: const Offset(0, 4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '키워드 직접 입력하기',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 268,
                      height: 61,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff263344),
                            Color(0xff1B2532).withOpacity(0.538),
                            Color(0xff1C2A3D).withOpacity(0.502),
                            Color(0xff1E2E42).withOpacity(0.46),
                            Color(0xff364B66).withOpacity(0.33),
                            Color(0xff2471D6).withOpacity(0),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff000000).withOpacity(0.25),
                            offset: const Offset(0, 4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'MAKE YOUR OWN CARD',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
      ),
    );
  }
}

class CheckRow extends StatelessWidget {
  final String text;
  final String buttonText;

  const CheckRow({
    super.key,
    required this.text,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 100,
          child: Row(
            children: [
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: GradientBoxBorder(
                      gradient: LinearGradient(stops: [
                    0,
                    1.0
                  ], colors: [
                    Color(0xff65D5A6),
                    Color(0xff1E72AC),
                  ])),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0, 1.0],
                    colors: [
                      Color(0xff65D5A6),
                      Color(0xff1E72AC),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 146,
          height: 23,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: [
                Color(0xff263344),
                Color(0xff1B2532).withOpacity(0.538),
                Color(0xff1C2A3D).withOpacity(0.502),
                Color(0xff1E2E42).withOpacity(0.46),
                Color(0xff364B66).withOpacity(0.33),
                Color(0xff2471D6).withOpacity(0),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff000000).withOpacity(0.25),
                offset: const Offset(0, 4),
                blurRadius: 4,
              ),
            ],
          ),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
