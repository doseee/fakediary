import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'gift_card_page.dart';

class GiftCardListPage extends StatefulWidget {
  const GiftCardListPage({Key? key}) : super(key: key);

  @override
  _GiftCardListPageState createState() => _GiftCardListPageState();
}

class _GiftCardListPageState extends State<GiftCardListPage> {
  // app bar style.
  late double _appBarHeight;
  Color _appBarColors = Colors.transparent;

  // size.
  late EdgeInsets _padding;

  // scroll controller.
  late ScrollController _scrollController;

  // change app bar color
  void _changeAppBarColor() {
    if (_scrollController.hasClients) {
      if (_scrollController.offset > 0) {
        _appBarColors = Colors.grey.shade800.withOpacity(0.5);
      } else {
        _appBarColors = Colors.transparent;
      }

      // 상태 변경.
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_changeAppBarColor);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _padding = MediaQuery.of(context).padding;
    _appBarHeight = 64 + _padding.top;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor:Color(0xff18181f),
      body: Stack(
        children: [
          // 리스트.
          _list(),

          // 앱바.
          _appbar(),
        ],
      ),
    );
  }

  // 리스트.
  ListView _list() {
    return ListView(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20) +
          EdgeInsets.only(top: _appBarHeight, bottom: _padding.bottom),
      children: [
        // 타이틀.
        const Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            '상품권을 선택해주세요',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        // 상품권 카드.
        ...List.generate(
          Colors.accents.length,
          (index) {
            final _color = Colors.accents.elementAt(index);

            return Hero(
              tag: index,
              child: CupertinoButton(
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      transitionDuration: const Duration(milliseconds: 200),
                      reverseTransitionDuration: const Duration(milliseconds: 200),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return GiftCardPage(
                          colors: _color,
                          tag: index,
                        );
                      },
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const _begin = Offset(1.0, 0.0);
                        const _end = Offset.zero;
                        const _curve = Curves.ease;
                        final _tween = Tween(begin: _begin, end: _end).chain(CurveTween(curve: _curve));
                        return SlideTransition(
                          position: animation.drive(_tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                padding: EdgeInsets.zero,
                pressedOpacity: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: _color,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  height: 150,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // 앱바.
  Widget _appbar() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: _appBarHeight,
          width: double.infinity,
          alignment: Alignment.bottomLeft,
          color: _appBarColors,
          padding: const EdgeInsets.all(16),
          child: const Icon(
            Icons.arrow_back_ios_outlined,
          ),
        ),
      ),
    );
  }
}
