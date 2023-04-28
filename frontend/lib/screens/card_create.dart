import 'package:flutter/material.dart';
import 'package:frontend/camera_ex.dart';
import 'package:frontend/screens/menu_screen.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardCreate extends StatefulWidget {
  const CardCreate({super.key});

  @override
  State<CardCreate> createState() => _CardCreateState();
}

class _CardCreateState extends State<CardCreate> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _personController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _keyword1Controller = TextEditingController();
  final TextEditingController _keyword2Controller = TextEditingController();
  final TextEditingController _keyword3Controller = TextEditingController();

  bool personSelected = false;
  bool locationSelected = false;
  bool keyword1Selected = true;
  bool keyword2Selected = true;
  bool keyword3Selected = false;

  bool keyword1Modified = false;
  bool keyword2Modified = false;
  bool keyword3Modified = true;

  ImageProvider? _currentImage;

  @override
  void initState() {
    super.initState();
    _currentImage = null;
  }

  setPerson() {
    setState(() {
      personSelected = !personSelected;
    });
  }

  setLocation() {
    setState(() {
      locationSelected = !locationSelected;
    });
  }

  setKeyword1() {
    setState(() {
      keyword1Selected = !keyword1Selected;
    });
  }

  setKeyword2() {
    setState(() {
      keyword2Selected = !keyword2Selected;
    });
  }

  setKeyword3() {
    setState(() {
      keyword3Selected = !keyword3Selected;
    });
  }

  setModified1() {
    setState(() {
      keyword1Modified = !keyword1Modified;
    });
  }

  setModified2() {
    setState(() {
      keyword2Modified = !keyword2Modified;
    });
  }

  setModified3() {
    setState(() {
      keyword3Modified = !keyword3Modified;
    });
  }

  useDefaultPerson() async {
    final prefs = await SharedPreferences.getInstance();
    _personController.text = prefs.getString('nickname') ?? '';
    setState(() {});
  }

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
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20,
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Row(
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
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CameraExample()));
                          if (result != null) {
                            setState(() {
                              _currentImage = FileImage(result);
                            });
                          }
                        },
                        child: Image(
                          image: AssetImage(
                            'assets/img/icon_cam.png',
                          ),
                          width: 45,
                        ),
                      ),
                    ],
                  ),
                  Transform.translate(
                    offset: Offset(0, -50),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image(
                        image: _currentImage ??
                            AssetImage('assets/img/card_example.jpg'),
                        width: 161,
                        height: 267,
                      ),
                    ),
                  ),
                  CheckRow(
                    text: '주인공',
                    buttonText: '기본 주인공으로 설정',
                    isSelected: personSelected,
                    converter: setPerson,
                    makeDefault: useDefaultPerson,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: TextFormField(
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
                          hintText: '주인공을 입력하세요.',
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
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  CheckRow(
                    text: '장소',
                    buttonText: '현재 위치로 설정',
                    isSelected: locationSelected,
                    converter: setLocation,
                    makeDefault: useDefaultPerson,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: TextFormField(
                      controller: _locationController,
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
                          hintText: '장소를 입력하세요.',
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
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '추가설정',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        width: 195,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  if (!keyword1Modified)
                    Keyword(
                      isSelected: keyword1Selected,
                      converter: setKeyword1,
                      modifier: setModified1,
                    )
                  else
                    InputKeyword(
                      keywordController: _keyword1Controller,
                      isSelected: keyword1Selected,
                      converter: setKeyword1,
                    ),
                  if (!keyword2Modified)
                    SizedBox(
                      height: 15,
                    ),
                  if (!keyword2Modified)
                    Keyword(
                      isSelected: keyword2Selected,
                      converter: setKeyword2,
                      modifier: setModified2,
                    )
                  else
                    InputKeyword(
                      keywordController: _keyword2Controller,
                      isSelected: keyword2Selected,
                      converter: setKeyword2,
                    ),
                  if (!keyword3Modified)
                    Keyword(
                      isSelected: keyword3Selected,
                      converter: setKeyword3,
                      modifier: setModified3,
                    ),
                  if (!keyword3Modified)
                    SizedBox(
                      height: 15,
                    ),
                  InputKeyword(
                    keywordController: _keyword3Controller,
                    isSelected: keyword3Selected,
                    converter: setKeyword3,
                  ),
                  SizedBox(
                    height: 45,
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
          ),
        ),
      ),
    );
  }
}

class InputKeyword extends StatelessWidget {
  final TextEditingController keywordController;
  final bool isSelected;
  final Function converter;

  const InputKeyword(
      {Key? key,
      required this.keywordController,
      required this.isSelected,
      required this.converter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            converter();
          },
          child: Container(
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
              gradient: isSelected
                  ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0, 1.0],
                      colors: [
                        Color(0xff65D5A6),
                        Color(0xff1E72AC),
                      ],
                    )
                  : null,
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        SizedBox(
          width: 146,
          child: TextFormField(
            controller: keywordController,
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
                hintText: '키워드를 입력하세요.',
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
        ),
        SizedBox(
          width: 77,
        )
      ],
    );
  }
}

class Keyword extends StatefulWidget {
  final bool isSelected;
  final Function converter;
  final Function modifier;

  const Keyword({
    super.key,
    required this.isSelected,
    required this.converter,
    required this.modifier,
  });

  @override
  State<Keyword> createState() => _KeywordState();
}

class _KeywordState extends State<Keyword> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      alignment: Alignment.center,
      child: SizedBox(
        width: 246,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                widget.converter();
              },
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: GradientBoxBorder(
                      gradient: LinearGradient(stops: [
                    0,
                    1.0,
                  ], colors: [
                    Color(0xff65D5A6),
                    Color(0xff1E72AC),
                  ])),
                  gradient: widget.isSelected
                      ? LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0, 1.0],
                          colors: [
                            Color(0xff65D5A6),
                            Color(0xff1E72AC),
                          ],
                        )
                      : null,
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
            SizedBox(
              width: 8,
            ),
            GestureDetector(
                onTap: () {
                  widget.modifier();
                },
                child: Icon(Icons.edit, color: Colors.white, size: 16)),
          ],
        ),
      ),
    );
  }
}

class CheckRow extends StatelessWidget {
  final String text;
  final String buttonText;
  final bool isSelected;
  final Function converter;
  final Function makeDefault;

  const CheckRow({
    super.key,
    required this.text,
    required this.buttonText,
    required this.isSelected,
    required this.converter,
    required this.makeDefault,
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
              GestureDetector(
                onTap: () {
                  converter();
                },
                child: Container(
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
                    gradient: isSelected
                        ? LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0, 1.0],
                            colors: [
                              Color(0xff65D5A6),
                              Color(0xff1E72AC),
                            ],
                          )
                        : null,
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
        GestureDetector(
          onTap: () {
            makeDefault();
          },
          child: Container(
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
        ),
      ],
    );
  }
}
