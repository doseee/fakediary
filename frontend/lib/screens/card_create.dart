import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/camera_ex.dart';
import 'package:frontend/screens/card_loading.dart';
import 'package:frontend/screens/card_result.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/widgets/theme.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:lottie/lottie.dart';
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

  bool _isLoading = false;
  bool imageLoading = false;
  bool personLoading = false;
  bool locationLoading = false;

  String keyword1 = '';
  String keyword2 = '';
  String keyword3 = '';

  ImageProvider? _currentImage;
  File? _image;

  late int memberId;
  double latitude = 37.5721418;
  double longitude = 126.9772436;

  @override
  void initState() {
    super.initState();
    _currentImage = null;
    initId();
  }

  initId() async {
    final prefs = await SharedPreferences.getInstance();
    memberId = prefs.getInt('memberId')!;
    setState(() {});
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
    setState(() {
      personLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    _personController.text = prefs.getString('diaryBaseName') ?? '';
    personSelected = true;
    personLoading = false;
    setState(() {});
  }

  useDefaultLocation() async {
    print('location');
    setState(() {
      locationLoading = true;
    });
    final position = await ApiService.determinePosition();
    print(position);
    _locationController.text = await ApiService.coordToRegion(position);
    latitude = position.latitude;
    longitude = position.longitude;
    locationSelected = true;
    locationLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CardLoading()
        : GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/img/background_1_darken.png'))),
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 75),
                          child: Container(
                            width: 100,
                            height: 336,
                            decoration: BtnThemeGradientLine(),
                            child: GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    imageLoading = true;
                                  });
                                  final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CameraExample()));
                                  if (result != null) {
                                    final captions =
                                    await ApiService.getCaption(result);

                                    setState(() {
                                      _image = result;
                                      _currentImage = FileImage(result);
                                      keyword1 =
                                      captions.isNotEmpty ? captions[0] : "";
                                      keyword1Modified = !captions.isNotEmpty;
                                      keyword2 =
                                      captions.length > 1 ? captions[1] : "";
                                      keyword2Modified = !(captions.length > 1);
                                      keyword3 =
                                      captions.length > 2 ? captions[2] : "";
                                      keyword3Modified = !(captions.length > 2);
                                      imageLoading = false;
                                    });
                                  } else {
                                    setState(() {
                                      imageLoading = false;
                                    });
                                  }
                                },

                              child: imageLoading
                                  ? Lottie.asset( 'assets/lottie/loading_image.json',height: 70,width: 70)
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image(
                                        width: 189.6,
                                        height: 336,
                                        image: _currentImage ??
                                            AssetImage('assets/img/camera_small (1).png'),
                                      ),
                                    ),

                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
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
                        personLoading
                            ? SpinKitFadingCircle(
                                color: Colors.black,
                                size: 70.0,
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 55),
                                child: TextFormField(
                                  maxLength: 10,
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
                                      return '공백을 채워주세요.';
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
                          makeDefault: useDefaultLocation,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        locationLoading
                            ? SpinKitFadingCircle(
                                color: Colors.black,
                                size: 70.0,
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 55),
                                child: TextFormField(
                                  maxLength: 200,
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
                                      return '공백을 채워주세요.';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '추가설정',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                width: 195,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '사진을 분석해서 자동으로 키워드를 만들어보았어요!',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 11,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '원하는 키워드가 있다면 수정해보세요',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 11,
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: 130,
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        if (!keyword1Modified)
                          Keyword(
                            isSelected: keyword1Selected,
                            converter: setKeyword1,
                            modifier: setModified1,
                            keyword: keyword1,
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
                            keyword: keyword2,
                          )
                        else
                          InputKeyword(
                            keywordController: _keyword2Controller,
                            isSelected: keyword2Selected,
                            converter: setKeyword2,
                          ),
                        if (!keyword3Modified)
                          SizedBox(
                            height: 15,
                          ),
                        if (!keyword3Modified)
                          Keyword(
                            isSelected: keyword3Selected,
                            converter: setKeyword3,
                            modifier: setModified3,
                            keyword: keyword3,
                          )
                        else
                          InputKeyword(
                            keywordController: _keyword3Controller,
                            isSelected: keyword3Selected,
                            converter: setKeyword3,
                          ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              _isLoading = true;
                            });

                            String key1 = keyword1Selected
                                ? (keyword1Modified
                                    ? _keyword1Controller.text
                                    : keyword1)
                                : '';
                            String key2 = keyword2Selected
                                ? (keyword2Modified
                                    ? _keyword2Controller.text
                                    : keyword2)
                                : '';
                            String key3 = keyword3Selected
                                ? (keyword3Modified
                                    ? _keyword3Controller.text
                                    : keyword3)
                                : '';

                            List<String> strings = [key1, key2, key3];

                            List<String> nonEmptyStrings =
                                strings.where((str) => str.isNotEmpty).toList();

                            String combinedString = nonEmptyStrings.join('@');

                            if ((!personSelected ||
                                    _personController.text == '') &&
                                (!locationSelected ||
                                    _locationController.text == '') &&
                                combinedString == '') {
                              setState(() {
                                _isLoading = false;
                              });
                              Flushbar(
                                      message: '키워드를 한 개 이상 입력해주세요.',
                                      duration: Duration(seconds: 3),
                                      flushbarPosition: FlushbarPosition.TOP)
                                  .show(context);
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   SnackBar(
                              //     content: Center(
                              //         child: Text('키워드를 한 개 이상 입력해주세요.')),
                              //   ),
                              // );
                              return;
                            }

                            if (_image == null) {
                              setState(() {
                                _isLoading = false;
                              });
                              Flushbar(
                                      message: '사진을 선택해주세요.',
                                      duration: Duration(seconds: 3),
                                      flushbarPosition: FlushbarPosition.TOP)
                                  .show(context);
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   SnackBar(
                              //     content: Center(child: Text('사진을 선택해주세요.')),
                              //   ),
                              // );
                              return;
                            }

                            Map<String, dynamic> card =
                                await ApiService.makeCard(
                                    memberId,
                                    personSelected
                                        ? _personController.text
                                        : '',
                                    locationSelected
                                        ? _locationController.text
                                        : '',
                                    combinedString,
                                    latitude,
                                    longitude,
                                    _image!);

                            setState(() {
                              _isLoading = false;
                            });

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CardResult(card: card)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Container(
                              width: 200,
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
                                    color:
                                        const Color(0xff000000).withOpacity(0.25),
                                    offset: const Offset(0, 4),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  '나만의 일상 카드 만들기',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
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
            width: 25,
            height: 25,
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
          width: 160,
          child: TextFormField(
            maxLength: 10,
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
                return '공백을 채워주세요.';
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
  final String keyword;

  const Keyword({
    super.key,
    required this.isSelected,
    required this.converter,
    required this.modifier,
    required this.keyword,
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
        width: 270,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                widget.converter();
              },
              child: Container(
                width: 25,
                height: 25,
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
              widget.keyword,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
                onTap: () {
                  widget.modifier();
                },
                child: Icon(Icons.edit, color: Colors.white, size: 25 )),
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
          width: 120,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  converter();
                },
                child: Row(
                  children: [
                    Container(
                      width: 25,
                      height: 25,
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
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
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
            height: 40,
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
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
