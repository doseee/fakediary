import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/services.dart';

class GiftCardPage extends StatefulWidget {
  final Color colors;
  final int tag;

  const GiftCardPage({
    Key? key,
    required this.colors,
    required this.tag,
  }) : super(key: key);

  @override
  _GiftCardPageState createState() => _GiftCardPageState();
}

class _GiftCardPageState extends State<GiftCardPage> with TickerProviderStateMixin {
  // 카드 사이즈.
  static const double _cardWidth = 320;
  static const double _cardHeight = 200;

  // 카드 수량.
  int _cardQuantity = 1;
  int _animationCardQuantity = 1;

  // 카드 애니메이션.
  late AnimationController _cardRotateController;
  late AnimationController _cardBounceController;

  // 증감 버튼 크기 애니메이션.
  late AnimationController _decreaseButtonScaleController;
  late AnimationController _increaseButtonScaleController;

  // 바운스 애니메이션.
  final Duration _bounceAnimationDuration = const Duration(milliseconds: 100);

  // 카드 애니메이션 설정.
  void _setCardRotateAnimation() {
    // 카드 회전 애니메이션.
    _cardRotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() => setState(() {}));
    _cardRotateController.forward();

    // 카드 바운스 애니메이션.
    _cardBounceController = AnimationController(
      vsync: this,
      duration: _bounceAnimationDuration,
      lowerBound: 0.0,
      upperBound: 10.0,
    )..addListener(() => setState(() {}));
  }

  // 버튼 크기 애니메이션 설정.
  void _setButtonScaleAnimation() {
    // 감소 버튼 애니메이션.
    _decreaseButtonScaleController = AnimationController(
      vsync: this,
      duration: _bounceAnimationDuration,
      lowerBound: 0.0,
      upperBound: 0.6,
    )..addListener(() => setState(() {}));

    // 증가 버튼 애니메이션.
    _increaseButtonScaleController = AnimationController(
      vsync: this,
      duration: _bounceAnimationDuration,
      lowerBound: 0.0,
      upperBound: 0.6,
    )..addListener(() => setState(() {}));
  }

  @override
  void initState() {
    super.initState();
    _setCardRotateAnimation();
    _setButtonScaleAnimation();
  }

  @override
  void dispose() {
    _cardRotateController.dispose();
    _decreaseButtonScaleController.dispose();
    _increaseButtonScaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black12.withOpacity(0.2),
        body: Stack(
          children: [
            // 배경색.
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
                child: Container(),
              ),
            ),

            // 카드 화면.
            SafeArea(
              child: Column(
                children: [
                  // 앱바.
                  _appbar(),

                  // 카드.
                  _cards(),

                  // 카드 수량 증감 버튼.
                  _countChangingButton(),

                  // 구매 버튼.
                  _paymentButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 앱바.
  Widget _appbar() {
    return Container(
      height: 64,
      width: double.infinity,
      alignment: Alignment.bottomLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 나가기 버튼.
          CupertinoButton(
            pressedOpacity: 1,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
            ),
          ),

          // 안내 버튼.
          const CupertinoButton(
            onPressed: null,
            child: Text(
              '안내',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 카드.
  Expanded _cards() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: widget.tag,
            child: Transform.rotate(
              angle: _cardRotateController.value * (-math.pi / 30),
              child: Transform(
                alignment: Alignment.topLeft,
                transform: Matrix4.identity()
                  // 회전.
                  ..rotateX(_cardBounceController.value * (-math.pi / 400))
                  ..rotateY(_cardBounceController.value * (math.pi / 400)),
                child: Stack(
                  children: List.generate(
                    _animationCardQuantity,
                    (index) {
                      final _index = _animationCardQuantity - 1 - index;
                      return Transform(
                        transform: Matrix4.identity()
                          // 이동.
                          ..setEntry(0, 3, -1.5 * _index)
                          ..setEntry(1, 3, -2.0 * _index)
                          // 회전.
                          ..rotateX(-0.075 * _index)
                          ..rotateY(0.07 * _index),
                        child: _giftCard(index: index),
                      );
                    },
                  ).reversed.toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 기프트 카드.
  Container _giftCard({required int index}) {
    return Container(
      width: _cardWidth,
      height: _cardHeight,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: widget.colors,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            spreadRadius: 0,
            blurRadius: 15,
            offset: Offset(5, 5),
          ),
        ],
      ),
      child: (index == 0)
          ? const Material(
              type: MaterialType.transparency,
              child: Text(
                '상품권',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  // 카드 수량 증감 버튼.
  Container _countChangingButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16) + const EdgeInsets.only(bottom: 40),
      child: Column(
        children: [
          // 타이틀.
          const Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: Text(
              '30,000원 권을 몇 개 구매하시나요?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          // 증감 버튼.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 감소 버튼.
              _button(
                animationController: _decreaseButtonScaleController,
                iconData: Icons.remove_rounded,
                voidCallback: (_cardQuantity != 1)
                    ? () {
                        // 수량 감소.
                        if (_cardQuantity < 6) {
                          _animationCardQuantity--;
                        }
                        _cardQuantity--;

                        // 상태 변경.
                        setState(() {});
                      }
                    : null,
              ),

              // 수량.
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  '$_cardQuantity개',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              // 증가 버튼.
              _button(
                animationController: _increaseButtonScaleController,
                iconData: Icons.add_rounded,
                voidCallback: () {
                  // 수량 증가.
                  _cardQuantity++;
                  if (_animationCardQuantity < 5) {
                    _animationCardQuantity++;
                  }

                  // 상태변경.
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 버튼.
  Widget _button({
    required AnimationController animationController,
    VoidCallback? voidCallback,
    required IconData iconData,
  }) {
    return CupertinoButton(
      onPressed: () {
        // 애니메이션 효과.
        animationController.forward();
        Future.delayed(_bounceAnimationDuration, () {
          animationController.reverse();
        });

        // 값 변경.
        if (voidCallback != null) {
          voidCallback.call();
        }

        // 카드 바운스 애니메이션.
        _cardBounceController.forward();
        Future.delayed(_bounceAnimationDuration, () {
          _cardBounceController.reverse();
        });
      },
      child: Transform.scale(
        scale: 1 + animationController.value,
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.withOpacity(0.2),
          ),
          child: Icon(
            iconData,
            size: 36,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // 구매 버튼.
  Container _paymentButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20) + const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          '30,000원 권 $_cardQuantity개를 구매하기',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
