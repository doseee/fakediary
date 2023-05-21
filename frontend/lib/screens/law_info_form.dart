import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/home_circlemenu.dart';
import 'package:frontend/screens/tutorial_one.dart';
import 'package:frontend/screens/tutorial_screen.dart';
import 'package:frontend/widgets/theme.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_service.dart';

class LawInfoForm extends StatefulWidget {
  const LawInfoForm({Key? key}) : super(key: key);

  @override
  State<LawInfoForm> createState() => _LawInfoFormState();
}

class _LawInfoFormState extends State<LawInfoForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/img/background_1_darken.png'))),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(child: Column(
              children: [
                Text('1. 수집하는 개인정보 항목\n\n\n회사는 회원가입, 카드 생성, 일기생성, 등의 서비스 신청을 위해 아래와 같은 개인정보를 수집하고 있습니다.\n\n\n ',
                    style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:2, fontWeight: FontWeight.w900)),
                Text('가. 개인정보 수집항목\n\n\n=> 필수 : 이메일, 비밀번호, 닉네임\n\n\n\n나. 서비스 이용과정 및 사업 처리과정에서 수집될 수 있는 개인정보\n\n\n=> 서비스이용기록, 접속로그, 카드에 적용된 사진과 원본,일기\n\n\n\n다. 개인정보 수집방법\n\n\n=> 회원가입, 카드 생성\n\n\n=> 로그 분석 프로그램을 통한 생성 정보 수집\n\n \n\n\n\n',
                    style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:2)),
                Text('2. 개인정보 수집 및 이용목적\n\n\n회사는 수집한 개인정보를 다음의 목적을 위해 활용합니다.\n\n\n\n 가짜다이어리 회원 관리\n\n\n\n\n',
                    style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:2, fontWeight: FontWeight.w900)),
                Text('=> 회원 서비스 이용을 위한 본인 확인, 불만처리 등 고객 문의, 고객 설문,마케팅 및 광고에 활용\n\n\n\n=> 신규 서비스(제품) 개발 및 특화, 이벤트 등 광고성 정보 전달,\n\n  인구통계학적 특성에 따른 서비스 제공 및 광고 게재, 접속 빈도 파악 또는 회원의 서비스 이용에 대한 통계\n\n',
                    style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:2)),
                Text('\n기타\n\n\n3. 개인정보의 보유 및 이용기간회사는 \n \n 이용자의 개인정보제공일로부터 서비스를 제공하는 기간 동안에 한하여 이용자의 개인정보를 보유 및 이용하게 됩니다.\n \n\n회사는 회원이 탈퇴를 요청하거나 개인정보 수집 및 이용에 대한 동의를 철회하는 경우,\n \n\n   개인정보 수집 및 이용목적이 달성된 후,\n \n  보유 및 이용기간이 종료된 후에는 예외 없이 해당 정보를 지체 없이 파기합니다.\n\n\n앱을 삭제 한다 하여도 자동 탈퇴 처리가 되지 않으니,\n \n  탈퇴를 원하실 경우 모바일앱 메인 화면 하단의 ‘회원탈퇴’를 통한 별도의 탈퇴 요청이 필요합니다.\n\n다만, 아래와 같은 경우 일정기간 동안 예외적으로 수집한 회원정보의 전부 또는 일부를 보관할 수 있습니다.\n\n',
                    style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:2, fontWeight: FontWeight.w800)),
                Text('=> 보유항목: 이메일 , 닉네임 , 카드 사진\n\n\n=> 보유이유: 무분별한 회원탈퇴 및 재가입으로 인한 부정 사용 및 피해예방\n\n\n=> 보유기간: 회원 탈퇴 후 30일간\n\n전자상거래 등에서의 소비자 보호에 관한 법률, 전자금융거래법, 통신비밀보호법 등 법령에서 일정기간 정보의 보관을 규정하는 경우는 아래와 같습니다. \n\n회사는 이 기간 동안 법령의 규정에 따라 개인정보를 보관하며, 본 정보를 다른 목적으로는 절대 이용하지 않습니다.\n\n\n\n 가. 전자상거래 등에서 소비자 보호에 관한 법률\n \n\n=> 계약 또는 청약철회 등에 관한 기록: 5년\n\n\n=> 소비자의 불만 또는 분쟁처리에 관한 기록: 3년\n\n\n=> 표시/광고에 관한 기록 : 6개월\n\n\n\n나. 전자금융거래법\n\n\n\n  => 전자금융에 관한 기록: 5년 보관\n\n\n \n 다. 통신비밀보호법\n\n\n => 접속로그, 접속IP정보, 서비스이용기록: 3개월\n\n\n 4. 개인정보의 파기절차 및 방법회사는 원칙적으로 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다.\n 파기절차 및 방법은 다음과 같습니다.\n\n\n 가. 파기절차\n \n\n회사는 회원탈퇴, 서비스 종료, 이용자에게 동의 받은 개인정보 보유기간의 도래와 같이 \n \n 개인정보의 수집 및 이용목적이 달성된 개인정보는 재생이 불가능한 방법으로 파기하고 있습니다. \n\n 법령에서 보존의무를 부과한 정보에 대해서도 해당 기간 경과 후 지체 없이 재생이 불가능한 방법으로 파기합니다.\n\n\n 나. 파기방법\n\n\n 전자적 파일형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 완전하게 삭제하고, \n \n 출력물 등은 분쇄기로 분쇄하거나 소각하는 방식 등으로 파기합니다.\n\n\n 위 내용에 동의합니다\n\n\n',
                    style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:2)),
              ],
            ),)
        ));
  }
}
