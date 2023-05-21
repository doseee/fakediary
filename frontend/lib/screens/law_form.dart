import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/home_circlemenu.dart';
import 'package:frontend/screens/tutorial_one.dart';
import 'package:frontend/screens/tutorial_screen.dart';
import 'package:frontend/widgets/theme.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_service.dart';

class LawForm extends StatefulWidget {
  const LawForm({Key? key}) : super(key: key);

  @override
  State<LawForm> createState() => _LawFormState();
}

class _LawFormState extends State<LawForm> {
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
              Text('[제1장 총칙]',
                  style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:5, fontWeight: FontWeight.w800)),
              SizedBox(
                height: 30,
              ),
              Text(
                  '제1조 목적이 약관은 < A101 >\n\n(\'http://k8a101.p.ssafy.io\'이하 \'lieary\'))가 제공하는 인터넷상의 정보 서비스(이하 "서비스"라 합니다)의 이용과 관련하여 기본적인 사항을 규정함을 목적으로 합니다.',
                  style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:1)),
              SizedBox(height: 30),
              Text('제2조 약관의 효력 및 변경',
                  style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:1, fontWeight: FontWeight.w800)),
              SizedBox(height: 30),
              Text(
                  '1. 이 약관의 공지 및 변경사항은 회사의 지정된 모바일 (\'lieary\')에 공지합니다. \n이 약관의 내용은 서비스 화면에 게시하거나 제1항의 방법으로 회원에게 공지함으로써 효력을 발생합니다.',
                  style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:1)),
              SizedBox(height: 20),
              Text(
                  '2. 회사는 합당한 사유가 발생할 경우에는 이 약관을 변경할 수 있으며, 약관이 변경된 경우에는 변경 된 약관을 제1항과 동일한 방법으로 공지함으로써 효력을 발생합니다. \n회원의 권리 또는 의무 등 중요한 개정은 시행일로부터 최소 1주일 전에 공지합니다. \n\n다만, 회원에게 불리한 내용으로 약관을 개정하는 경우에는 적용일로부터30일전까지 홈페이지에 공시하고 회원이 입력한 가장 최근의 e-mail로 전송하는 방법으로 회원에게 고지합니다. 변경된 약관은 공시하거나 고지한 적용일로부터 효력이 발생합니다.',
                  style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:2))
              ,SizedBox(height: 30),Text('제3조 약관 외 준칙',
                  style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:1, fontWeight: FontWeight.w800)),
              SizedBox(height: 30)
              ,Text('1. 회사의 모바일 (\'lieary\')에 게재된 개인정보처리방침, 저작권정책, 책임의 한계와 법적고지는 이 약관과 상충되지 아니하는 한 회원에게 적용됩니다.',
                  style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:1)),
              SizedBox(height: 20)
              ,Text('2. 전항에서 정하지 아니한 사항은 대한민국의 법령에 따릅니다.',
                  style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:1)),
              SizedBox(height: 30)
              ,Text('제4조 용어의 정의이 약관에서 정의하는 용어는 다음과 같습니다.',
                  style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:1, fontWeight: FontWeight.w800)),
              SizedBox(height: 30)
              ,Text('1) 회원: 회사와 서비스 이용계약을 체결하고 이용자 아이디를 부여 받은 자 \n\n 2) 아이디(ID): 회원의 식별과 회원의 서비스 이용을 위하여 회원이 만들고 회사가 승인하는 문자와 숫자의 조합\n\n 3) 비밀번호: 회원의 비밀 보호를 위하여 회원 자신이 설정한 문자와 숫자의 조합\n\n 4) 운영자: 서비스의 전반적인 관리와 원활한 운영을 위하여 회사에서 선정한 사람\n\n 5) 해지: 이용자가 서비스 개통 후 이용계약을 해약하는 것',
                  style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:2)),
              SizedBox(height: 30)
              ,Text('[제2장 서비스 이용 계약]',
                  style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:5, fontWeight: FontWeight.w800)),
              SizedBox(height: 30)
              ,Text('제5조 이용 계약의 성립\n\n1. 회원가입은 회사가 정한 소정의 등록절차를 걸쳐 \'회원 가입\' 버튼을 클릭하면 이 약관과 함께 이에 동의하는 것으로 간주합니다.\n\n2. 이용계약은 회원의 이용신청에 대하여 회사가 승낙함으로써 성립합니다.\n\n\n\n제6조 이용 신청이용신청은 온라인으로 다음 사항을 가입신청 양식에 기록하여 신청합니다.\n\n\n\n1. 이메일(Email)\n\n\n2. 비밀번호제7조 이용신청의 승낙\n\n\n1. 회사는 회원이 제6조에서 정한 모든 사항을 정확히 기재하여 이용신청을 하였을 때 회사가 그 기재사항 등을 검토하여 이용신청에 대하여 승낙할 수 있습니다.\n\n\n2. 회사는 다음 각 호에 해당하는 경우에는 이용신청에 대한 승낙을 거절할 수 있습니다.\n\n\n1) 주민등록표상의 본인실명과 다르게 이용신청을 하였을 경우\n\n\n2) 다른 사람의 명의를 사용하여 신청한 경우\n\n\n3) 이용신청 시 필요내용을 허위로 기재하여 신청한 경우\n\n\n4) 사회의 안녕질서 또는 미풍양속에 반할 우려가 있다고 명백히 인정될 경우\n\n\n5) 기타 회사가 정한 이용신청 요건이 미비되었을 때3.회사는 다음 각 호에 해당하는 경우에는 이용신청에 대한 승낙을 유보할 수 있습니다.\n\n\n\n\n1) 설비용량에 현실적인 여유가 없는 경우\n\n\n2) 서비스를 제공하기에는 기술적으로 문제가 있다고 판단되는 경우\n\n\n3) 기타 회사가 재정적 또는 기술적으로 필요하다고 인정되는 경우제8조 계약사항의 변경회원은 이용신청 시 기재한 사항이 변경되었을 경우에는 바로 수정해야 합니다.\n\n제 9조 휴면계정 관리1. 회사는 회원이 최종접속일로부터 12개월 이상 가짜다이어리에 로그인 하지 않을 경우, \n\n휴면계정으로 간주하고 회사가 제공하는 서비스 이용을 제한/상실시킬 수 있습니다. \n\n회사는 휴면 계정으로 전환되기 1개월 전 E-mail을 통해 안내합니다.\n\n- 휴면계정 전환일: 가짜다이어리 최종접속일로부터 12개월 이상 로그인하지 않은 경우- 서비스 이용 제한: 서비스 전면 중단\n\n\n- 휴면계정으로 전환을 원치 않을 경우 12개월이 되기 전 1회 이상 로그인 필요\n\n2. 휴면계정으로 전환될 경우, 가짜다이어리 서비스 일체 이용하실 수 없습니다. 이후 서비스를 재개하려면 본인 인증 절차를 거쳐야 합니다. \n\n\n단, 휴면계정 전환일로부터 5년간 로그인 하지 않으실 경우 회원 탈퇴 및 보관 중인 개인정보는 파기됩니다.',
                  style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:2)),
              SizedBox(height: 30)
              ,Text('[제3장 계약당사자의 의무]',
                  style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:5, fontWeight: FontWeight.w800)),
              SizedBox(height: 30)
              ,Text('제10조 개인정보의 보호회사는 관련법령이 정하는 바에 따라서 이용자 등록정보를 포함한 이용자의 개인정보를 보호하기 위하여 노력합니다. \n\n이용자의 개인정보보호에 관해서는 관련법령 및 회사가 정하는 "개인정보처리방침"에 정한 바에 의합니다.제11조 회원 이름, 아이디와 비밀번호 관리에 대한 의무이름, 아이디, 비밀번호에 관한 모든 관리책임은 회원에게 있습니다. \n\n회원에게 부여된 이름, 별명과 비밀번호의 관리 소홀, 부정사용에 의하여 발생하는 모든 결과에 대한 책임은 회원에게 있습니다. \n\n또한 자신의 이름, 아이디와 비밀번호가 부정하게 사용되고 있음을 인지한 경우 회원은 반드시 회사에 그 사실을 통보하고 회사의 안내가 있는 경우에는 그에 따라야 합니다.\n\n제12조 서비스 전반에 관한 회원의 의무1. 회원은 서비스를 이용할 때 다음 각 호의 행위를 하지 않아야 합니다.\n\n1) 다른 회원의 아이디를 부정하게 사용하는 행위2) 제3자의 저작권 등 기타 권리를 침해하는 행위\n\n3) 공공질서/미풍양속에 위반되는 내용의 정보, 문장, 도형, 음성 등을 타인에게 유포 하는 행위\n\n4) 범죄와 결부된다고 객관적으로 판단되는 행위5) 타인이 명예를 손상시키거나 불이익을 주는 행위\n\n6) 기타 관계법령에 위배되는 행위\n\n7) 기타 서비스의 정상적 운영, 유지 등을 방해하거나 지연시키는 행위2. 회원은 이 약관에서 규정하는 사항과 서비스 이용안내 또는 주의사항을 준수하여야 합니다.3. 회원은 내용별로 회사가 서비스 공지사항에 게시하거나 별도로 공지한 이용제한 사항을 준수하여야 합니다.\n\n4. 회원은 회사의 사전승낙 없이는 서비스를 이용하여 영업활동을 할 수 없으며, 영업활동의 결과와 회원이 약관에 위반한 영업활동을 이용하여 발생한 결과에 대하여 회사는 책임을 지지 않습니다.\n\n5. 회원은 서비스의 이용권한, 기타 이용계약상 지위를 타인에게 양도, 증여할 수 없으며, 이를 담보로 제공할 수 없습니다.',
                  style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:2)),
              SizedBox(height: 30)
              ,Text('[제4장 서비스 이용]',
                  style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:1, fontWeight: FontWeight.w800)),
              SizedBox(height: 30)
              ,Text('제13조 정보의 제공회사는 회원이 서비스 이용 중 필요가 있다고 인정되는 다양한 정보에 대해서 전자우편이나 문자서비스, 어플리케이션 알림, 우편 등의 방법으로 회원에게 제공할 수 있습니다.\n\n제14조 회원의 게시물회사는 회원이 게시하거나 등록하는 서비스내의 내용물이 다음 각 호에 해당한다고 판단되는 경우에 사전 통지 없이 삭제할 수 있습니다.\n\n1. 다른 회원 또는 제3자를 비방하거나 중상모략으로 명예를 손상시키는 내용인 경우\n\n2. 공공질서 및 미풍양속에 위반되는 내용인 경우\n\n3. 범죄적 행위에 결부된다고 인정되는 내용인 경우\n\n4. 회사의 저작권, 제3자의 저작권 등 기타 권리를 침해하는 내용인 경우\n5. 불건전한 자료를 홍보할 경우\n6. 게시판의 성격과 맞지 않는 게시물인 경우\n7. 기타 관계법령에 위반된다고 판단되는 경우\n제15조 게시물의 저작권과 소유권 서비스에 게재된 자료에 대한 권리\n1. 게시물에 대한 저작권과 책임은 게시자에게 있으며 회사는 해당 게시물의 소유권을 갖습니다.\n\n2. 회원은 서비스를 이용하여 얻은 정보를 회원의 비영리적인 이용 이외의 목적으로 복제, 출판, 방송 등에 사용하거나 제3자에게 판매하는 등 상업적으로 사용할 수 없습니다.\n\n 제16조 서비스 이용 시간\n\n1. 서비스의 이용은 회사의 업무상 또는 기술상 특별한 지장이 없는 한 연중무휴 1일 24시간을 원칙으로 합니다. 다만, 회사의 업무나 기술상의 이유, 천재지변 등으로 서비스가 일시 중지될 수 있고, 운영상의 목적으로 회사가 정한 기간에는 서비스가 일시 중지될 수 있습니다. \n\n이때 회사는 미리 해당 내용을 공지하며, 부득이하면 사후에 통보할 수 있습니다.\n \n2. 회사는 서비스를 일정범위로 분할하여 각 범위별로 이용가능한 시간을 별도로 정할 수 있습니다.\n\n 이 경우 그 내용을 사전에 공지합니다.\n\n제17조 서비스 제공의 중지회사는 다음 각 호에 해당하는 경우 서비스 제공을 중지하거나 제한할 수 있습니다.\n\n1. 회원이 서비스의 운영을 고의 또는 과실로 방해하는 경우\n\n2. 서비스용 설비의 점검, 보수 또는 공사로 인한 부득이한 경우\n\n3. 전기통신사업법에 규정된 기간통신사업자가 전기통신 서비스를 중지했을 경우\n\n4. 회원이 이 약관에서 정한 의무를 위반한 경우\n\n5. 국가비상사태, 서비스 설비의 장애 또는 서비스 이용 폭주 등으로 서비스 이용에 지장이 있을 경우\n\n6. 기타 중대한 사유로 인하여 서비스 제공을 지속하는 것이 부적당하다고 판단되는 경우',
                  style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:2)),
              SizedBox(height: 30)
              ,Text('[제5장 계약 해지 및 이용 제한]',
                  style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:5, fontWeight: FontWeight.w800)),
              SizedBox(height: 30)
              ,Text('제18조 계약 해지 및 이용 제한\n\n1. 회원이 이용계약을 해지하고자 하는 때에는 회원탈퇴 메뉴를 이용하여 해지합니다.\n\n2. 회사는 회원이 다음 각 호에 해당하는 행위를 하였을 경우 사전동의 없이 이용계약을 해지하거나 또는 기간을 정하여 서비스 이용을 중지할 수 있습니다.\n\n1) 타인의 이름, 아이디 및 비밀번호를 도용한 경우\n\n2) 서비스 운영을 고의로 방해한 경우\n\n3) 가입한 이름이 실명이 아닌 경우\n\n4) 같은 사용자가 이중등록을 한 경우\n\n5) 공공질서 및 미풍양속에 저해되는 내용을 고의로 유포시킨 경우\n\n6) 회원이 국익 또는 사회적 공익을 저해할 목적으로 서비스 이용을 계획 또는 실행하는 경우\n\n7) 타인의 명예를 손상시키거나 불이익을 주는 행위를 한 경우\n\n8) 제3자의 지적재산권을 침해하는 경우\n\n9) 회사의 서비스 정보를 이용하여 얻은 정보를 회사의 사전 승낙없이 복제 또는 유통시키거나 상업적으로 이용하는 경우\n10) 기타 회사가 정한 이용조건에 위반한 경우',
                  style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:1)),
              SizedBox(height: 30)
              ,Text('[제6장 손해배상 등]',
                  style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:5, fontWeight: FontWeight.w800)),
              SizedBox(height: 30)
              ,Text('제19조 손해배상회사는 서비스 이용과 관련하여 무료 서비스의 경우에 한하여 회원에게 발생한 어떠한 손해에 관하여도 책임을 지지 않습니다.제20조 면책조항\n\n1. 회사는 천재지변 또는 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 관한 책임을 지지 않습니다.\n\n2. 회사는 회원의 귀책사유로 인한 서비스 이용의 장애에 대하여 책임을 지지 않습니다.\n\n3. 회사는 회원이 서비스를 이용하여 기대하는 수익을 상실한 것에 대하여 책임을 지지 않으며 그밖에 서비스를 통하여 얻은 자료로 인한 손해에 관하여 책임을 지지 않습니다.\n\n4. 회사는 회원이 서비스에 게재한 정보, 자료, 사실의 신뢰도, 정확성 등 내용에 관하여는 책임을 지지 않습니다.\n\n제21조 관할법원서비스 이용으로 발생한 분쟁에 대해 소송이 제기될 경우 서울중앙지방법원을 관할법원으로 합니다.',
                  style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:1)),
              SizedBox(height: 30)
              ,Text('[부칙]',
                  style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:5, fontWeight: FontWeight.w800)),
              SizedBox(height: 30)
              ,Text('(변경일) 이 약관은 2023년 4월 28일부터 시행합니다.',
                  style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:1)),
              SizedBox(height: 20)
              ,Text('',
                  style: TextStyle(fontSize: 11, color: Colors.white70, letterSpacing:1)),
              SizedBox(height: 20)

            ],
          ),)
        ));
  }
}
