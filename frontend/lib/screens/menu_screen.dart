import 'package:flutter/material.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/login_entrance.dart';
import 'package:frontend/screens/tutorial_screen.dart';
import 'package:frontend/screens/card_create.dart';
import 'package:frontend/screens/card_list.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String title = '', desc1 = '', desc2 = '', selectedTitle = '';
  Widget screen = const SizedBox.shrink();

  onSelect(
    String title,
    String desc1,
    String desc2,
    Widget screen,
  ) {
    setState(() {
      this.title = title;
      this.desc1 = desc1;
      this.desc2 = desc2;
      selectedTitle = title;
      this.screen = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff42505C),
            Color(0xffE38B8B),
          ],
          stops: [0.4, 1.0],
        ),
        image: DecorationImage(
          image: AssetImage('assets/img/bg_galaxy.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: MediaQuery.of(context).size.height * 0.1183,
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image(
                        image: AssetImage('assets/img/icon_close.png'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            Flexible(
              flex: 427,
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Transform.scale(
                  scale: 1.15,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img/menu_white.png'),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 8,
                              ),
                              MenuButton(
                                title: '카드목록',
                                desc1: '생성한 카드를 확인하고',
                                desc2: '연관된 일기를 볼 수 있습니다.',
                                onSelect: onSelect,
                                selected: selectedTitle == '카드목록',
                                screen: const CardList(),
                              ),
                              const SizedBox(
                                width: 9,
                              ),
                              MenuButton(
                                title: '카드생성',
                                desc1: '사진과 키워드를 입력하고',
                                desc2: '카드를 생성할 수 있습니다.',
                                onSelect: onSelect,
                                selected: selectedTitle == '카드생성',
                                screen: const CardCreate(),
                              ),
                              const SizedBox(
                                width: 9,
                              ),
                              MenuButton(
                                title: '일기생성',
                                desc1: '카드와 분위기를 선택하고',
                                desc2: '일기를 생성할 수 있습니다.',
                                onSelect: onSelect,
                                selected: selectedTitle == '일기생성',
                                screen: const LoginEntrance(),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 8,
                              ),
                              MenuButton(
                                title: '친구목록',
                                desc1: '목록에서 친구를 선택하고',
                                desc2: '일기를 교환할 수 있습니다.',
                                onSelect: onSelect,
                                selected: selectedTitle == '친구목록',
                                screen: const HomeScreen(),
                              ),
                              const SizedBox(
                                width: 9,
                              ),
                              MenuButton(
                                title: '메인',
                                desc1: '메인 페이지로',
                                desc2: '이동합니다.',
                                onSelect: onSelect,
                                selected: selectedTitle == '메인',
                                screen: const HomeScreen(),
                              ),
                              const SizedBox(
                                width: 9,
                              ),
                              MenuButton(
                                title: '일기목록',
                                desc1: '일기 목록에서 지금까지',
                                desc2: '내가 작성한 일기를 볼 수 있습니다.',
                                onSelect: onSelect,
                                selected: selectedTitle == '일기목록',
                                screen: const HomeScreen(),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 8,
                              ),
                              MenuButton(
                                title: '알림',
                                desc1: '도착한 알림 목록을 확인하고',
                                desc2: '필요한 페이지로 이동할 수 있습니다.',
                                onSelect: onSelect,
                                selected: selectedTitle == '알림',
                                screen: const HomeScreen(),
                              ),
                              const SizedBox(
                                width: 9,
                              ),
                              MenuButton(
                                title: '정보수정',
                                desc1: '개인 정보를 수정하고',
                                desc2: '기본 키워드를 지정할 수 있습니다.',
                                onSelect: onSelect,
                                selected: selectedTitle == '정보수정',
                                screen: const HomeScreen(),
                              ),
                              const SizedBox(
                                width: 9,
                              ),
                              MenuButton(
                                title: '튜토리얼',
                                desc1: '앱의 이용방법을',
                                desc2: '확인합니다.',
                                onSelect: onSelect,
                                selected: selectedTitle == '튜토리얼',
                                screen: const TutorialScreen(),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 318,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: Colors.white,
                    indent: 42,
                    endIndent: 42,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(
                    color: Colors.white,
                    indent: 42,
                    endIndent: 42,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    desc1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    desc2,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: screen is SizedBox
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => screen,
                              ),
                            );
                          },
                    child: Container(
                      width: 135,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xff434b55),
                            const Color(0xff344153).withOpacity(0.53),
                            const Color(0xff2d3f56).withOpacity(0.5),
                            const Color(0xff33455B).withOpacity(0.46),
                            const Color(0xff364B66).withOpacity(0.33),
                            const Color(0xff2471D6).withOpacity(0),
                          ],
                          stops: const [0.0, 0.25, 0.4, 0.6, 0.75, 1.0],
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
                          '이동',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatefulWidget {
  final String title, desc1, desc2;
  final Function(String, String, String, Widget) onSelect;
  final bool selected;
  final Widget screen;

  const MenuButton({
    super.key,
    required this.title,
    required this.desc1,
    required this.desc2,
    required this.onSelect,
    required this.selected,
    required this.screen,
  });

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSelect(
            widget.title, widget.desc1, widget.desc2, widget.screen);
      },
      child: Container(
        width: 95,
        height: 95,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(widget.selected ? 0.25 : 0),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
    );
  }
}
