import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/home_screen.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  double pos = 0;

  setPos(index) {
    setState(() {
      pos = index.toDouble();
    });
  }

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
          image: AssetImage('assets/img/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CarouselSlider(
          options: CarouselOptions(
            onPageChanged: (index, _) {
              setPos(index);
            },
            viewportFraction: 1.0,
            height: MediaQuery.of(context).size.height,
            autoPlay: false,
            initialPage: 0,
          ),
          items: [
            CarouselItem(
              imgPath: 'assets/img/tutorial_cards.png',
              desc1: '사진과 키워드를 입력해',
              desc2: '카드를 생성하세요.',
              effect1: false,
              effect2: false,
              isEnd: false,
              index: pos,
            ),
            CarouselItem(
              imgPath: 'assets/img/tutorial_openbook.png',
              desc1: '생성한 카드를 선택하고',
              desc2: '테마를 골라',
              desc3: '가짜 일기를 생성하세요.',
              effect1: true,
              effect2: false,
              isEnd: false,
              index: pos,
            ),
            CarouselItem(
              imgPath: 'assets/img/tutorial_books.png',
              desc1: '나의 가짜 일기를',
              desc2: '친구 혹은 랜덤 유저와',
              desc3: '교환하세요.',
              effect1: false,
              effect2: true,
              isEnd: true,
              index: pos,
            ),
          ],
        ),
      ),
    );
  }
}

class CarouselItem extends StatefulWidget {
  final String imgPath, desc1, desc2, desc3;
  final bool effect1, effect2, isEnd;
  final double index;

  const CarouselItem(
      {super.key,
      required this.imgPath,
      required this.desc1,
      required this.desc2,
      this.desc3 = '',
      required this.effect1,
      required this.effect2,
      required this.isEnd,
      required this.index});

  @override
  State<CarouselItem> createState() => _CarouselItemState();
}

class _CarouselItemState extends State<CarouselItem> {
  final _totalDots = 3;

  Widget _buildRow(List<Widget> widgets) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widgets,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            const SizedBox(
              height: 85,
            ),
            const Image(
              image: AssetImage('assets/img/logo_small.png'),
            ),
            Container(
              height: 250,
              width: 300,
              alignment: Alignment.bottomCenter,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    child: Image(
                      image: AssetImage(widget.imgPath),
                    ),
                  ),
                  if (widget.effect1)
                    const Positioned(
                      top: -80,
                      left: -50,
                      child: Image(
                        image: AssetImage('assets/img/tutorial_effect1.png'),
                      ),
                    ),
                  if (widget.effect2)
                    const Positioned(
                      top: -200,
                      left: -110,
                      child: Image(
                        image: AssetImage('assets/img/tutorial_effect2.png'),
                      ),
                    )
                ],
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            const Image(
              image: AssetImage('assets/img/wing_divider.png'),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: widget.isEnd ? 87 : 120,
              child: Column(
                children: [
                  Text(
                    widget.desc1,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    widget.desc2,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  if (widget.desc3 != '')
                    Text(
                      widget.desc3,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
            if (widget.isEnd)
              const SizedBox(
                height: 35,
              ),
            if (widget.isEnd)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: Container(
                  width: 292,
                  height: 67,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xff263344),
                        const Color(0xff1B2532).withOpacity(0.53),
                        const Color(0xff1C2A3D).withOpacity(0.5),
                        const Color(0xff1E2E42).withOpacity(0.46),
                        const Color(0xff364B66).withOpacity(0.33),
                        const Color(0xff2471D6).withOpacity(0),
                      ],
                      stops: const [0, 0.25, 0.4, 0.5, 0.75, 1.0],
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff000000).withOpacity(0.25),
                        offset: const Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      '가짜다이어리 시작하기',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            if (!widget.isEnd)
              _buildRow([
                DotsIndicator(
                  dotsCount: _totalDots,
                  position: widget.index,
                  decorator: DotsDecorator(
                    spacing: const EdgeInsets.symmetric(horizontal: 20.0),
                    colors: [
                      Colors.grey,
                      Colors.grey,
                      Colors.grey,
                    ].reversed.toList(),
                    activeColors: [
                      Colors.black,
                      Colors.black,
                      Colors.black,
                    ],
                    sizes: [
                      const Size.square(10.0),
                      const Size.square(10.0),
                      const Size.square(10.0),
                    ],
                    activeSizes: [
                      const Size.square(10.0),
                      const Size.square(10.0),
                      const Size.square(10.0),
                    ],
                    shapes: [
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ],
                    activeShapes: [
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ],
                  ),
                ),
              ]),
          ],
        ),
      ],
    );
  }
}
