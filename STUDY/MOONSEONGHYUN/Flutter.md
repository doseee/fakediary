# Flutter 설치 방법

1. Flutter SDK를 다운로드받습니다.

[Windows install | Flutter](https://docs.flutter.dev/get-started/install/windows)

[](https://docs.flutter.dev/get-started/install/windows)

2. 압축을 풀고 나온 flutter 폴더를 원하는 곳으로 옮깁니다. (ex : C:\src)

![https://blog.kakaocdn.net/dn/bFPpGl/btsaia7COTm/vUJb5KONeeB6lQsGa1MdD1/img.png](https://blog.kakaocdn.net/dn/bFPpGl/btsaia7COTm/vUJb5KONeeB6lQsGa1MdD1/img.png)

3. 위의 flutter 폴더 경로를 그대로 복사하여 환경변수에 등록합니다.

![https://blog.kakaocdn.net/dn/qihcS/btsak3NCQw6/9kaYuaUkBHAdPORSetRTf0/img.png](https://blog.kakaocdn.net/dn/qihcS/btsak3NCQw6/9kaYuaUkBHAdPORSetRTf0/img.png)

![https://blog.kakaocdn.net/dn/bnIoiZ/btsaEh4GVFf/d9sshxmK4aKZ7gf6vV0QmK/img.png](https://blog.kakaocdn.net/dn/bnIoiZ/btsaEh4GVFf/d9sshxmK4aKZ7gf6vV0QmK/img.png)

![https://blog.kakaocdn.net/dn/cVQzwv/btsaw6CpZWg/1Y04q9iiDJmr1XYf4Usie1/img.png](https://blog.kakaocdn.net/dn/cVQzwv/btsaw6CpZWg/1Y04q9iiDJmr1XYf4Usie1/img.png)

4. flutter doctor 명령어를 실행합니다.

![https://blog.kakaocdn.net/dn/4AuFt/btsaESRqaNn/L4X4yRTOIUAs1rvGyV7RM0/img.png](https://blog.kakaocdn.net/dn/4AuFt/btsaESRqaNn/L4X4yRTOIUAs1rvGyV7RM0/img.png)

최초 설치 시에는 Android toolchain 관련 이슈도 발생하는데 안드로이드 스튜디오 설치 이후 flutter doctor 실행 시 보이는 명령어를 입력하면 해결할 수 있습니다.

Windows Version은 master로 채널을 변경하고 upgrade하면 해결할 수 있는 문제지만 일단은 놔두겠습니다.(플러터 버전을 변경해야 하기 때문에)

이제 Android Studio를 설치해서 문제를 해결해줍니다.

[Download Android Studio & App Tools - Android Developers](https://developer.android.com/studio)

[](https://developer.android.com/studio)

![https://blog.kakaocdn.net/dn/UqdSP/btsaiafrYBx/P2IVwhuLUnAlW8ZWPy25k1/img.png](https://blog.kakaocdn.net/dn/UqdSP/btsaiafrYBx/P2IVwhuLUnAlW8ZWPy25k1/img.png)

무조건 Next로 일관하면 문제 없이 설치할 수 있습니다. 설치 이후 Android Studio를 실행합니다.

실행되면 Settings-Plugins에서 Dart와 Flutter를 설치합니다.

이후 아무 프로젝트나 생성한 후 Device Manager에서 적절한 Device를 생성해주면 초기 세팅이 끝나게 됩니다.

![https://blog.kakaocdn.net/dn/bZmt4H/btsaKxF9Cvt/oNqLZDifXWAkugRI9ASkz1/img.png](https://blog.kakaocdn.net/dn/bZmt4H/btsaKxF9Cvt/oNqLZDifXWAkugRI9ASkz1/img.png)

다시 flutter doctor를 실행하고 Android toolchain 문제를 해결하면 Window Version 문제만 남게 됩니다.

이제 샘플 앱(Wonderous)를 folk해오고 이를 구동할 수 있도록 플러터 버전을 바꿔보겠습니다.

# 샘플 앱 실행

먼저 Wonderous의 깃허브에서 소스 코드를 clone해옵니다.

[gskinnerTeam/flutter-wonderous-app: A showcase app for the Flutter SDK. Wonderous will educate and entertain as you uncover information about some of the most famous structures in the world. (github.com)](https://github.com/gskinnerTeam/flutter-wonderous-app)

[](https://github.com/gskinnerTeam/flutter-wonderous-app)

![https://blog.kakaocdn.net/dn/dKjQFD/btsaqQAh0h9/sBjo2rGNKDkDH1XWNeqBGK/img.png](https://blog.kakaocdn.net/dn/dKjQFD/btsaqQAh0h9/sBjo2rGNKDkDH1XWNeqBGK/img.png)

프로젝트 루트 디렉토리에서 VSCode를 실행합니다.

![https://blog.kakaocdn.net/dn/bBggZU/btsaJTJmXof/IjSw5lc1iq70OKT4yAhJ3K/img.png](https://blog.kakaocdn.net/dn/bBggZU/btsaJTJmXof/IjSw5lc1iq70OKT4yAhJ3K/img.png)

ctrl+shift+p 로 커맨드 팔레트를 열고 flutterse까지 치면 디바이스를 켤 수 있습니다. 적절한 디바이스를 선택해 구동해줍니다.

![https://blog.kakaocdn.net/dn/cjzUsN/btsayV8Sjfe/oWstq9RMEPejTfoNk8QMlk/img.png](https://blog.kakaocdn.net/dn/cjzUsN/btsayV8Sjfe/oWstq9RMEPejTfoNk8QMlk/img.png)

깃허브에 Readme파일에 의하면 fluttuer의 채널을 beta로 바꾸고 flutter run -d android 명령어를 실행하라고 합니다. 따라해봅시다.

![https://blog.kakaocdn.net/dn/ElA8N/btsar4SAQSF/t7gSQ5G1nTFlQ24KpaAngK/img.png](https://blog.kakaocdn.net/dn/ElA8N/btsar4SAQSF/t7gSQ5G1nTFlQ24KpaAngK/img.png)

![https://blog.kakaocdn.net/dn/b12hC5/btsaqPnT1v9/iDTfHZPNu9WTkjlfLkCKHK/img.png](https://blog.kakaocdn.net/dn/b12hC5/btsaqPnT1v9/iDTfHZPNu9WTkjlfLkCKHK/img.png)

플러터 버전을 바꾼 이후 flutter run -d android를 실행하면 진행되지 않는데 이유는 android를 아까 안드로이드 스튜디오를 설치하고 디바이스 매니저에서 만든 에뮬레이터 이름으로 바꿔줘야 하기 때문입니다.

![https://blog.kakaocdn.net/dn/zZA9T/btsaw7hapK7/E73f6p9PNfrmoJyNEDA01K/img.png](https://blog.kakaocdn.net/dn/zZA9T/btsaw7hapK7/E73f6p9PNfrmoJyNEDA01K/img.png)

위 명령어가 실패할 때 pc에서 찾을 수 있는 모든 디바이스의 목록을 보여줍니다.

두 번째 컬럼의 emulator-5554가 android를 대체하는 이름이 됩니다.

그렇게 실행을 하면 굉장히 위험해보이는 에러가 뜹니다.

![https://blog.kakaocdn.net/dn/bq1JHK/btsak22nTDO/CZenEYk82fr8wntKjXiYE0/img.png](https://blog.kakaocdn.net/dn/bq1JHK/btsak22nTDO/CZenEYk82fr8wntKjXiYE0/img.png)

현재 버전을 확인해보면 3.10.0버전인데 플러터 업데이트로 인해 패키지 내부의 코드를 실행하지 못하게 된 것입니다. 작동하게 만들기 위해서 3.7.0버전으로 바꿔줍니다.

![https://blog.kakaocdn.net/dn/c5FuzV/btsaKw8pmWs/5YIY28ebaXSFBS6kOlarK0/img.png](https://blog.kakaocdn.net/dn/c5FuzV/btsaKw8pmWs/5YIY28ebaXSFBS6kOlarK0/img.png)

버전을 변경하기 위해 플러터 SDK의 디렉토리로 가줍니다.

![https://blog.kakaocdn.net/dn/TZN4O/btsaia7KmuS/LLxiCWRsOeIvsIi17Kou90/img.png](https://blog.kakaocdn.net/dn/TZN4O/btsaia7KmuS/LLxiCWRsOeIvsIi17Kou90/img.png)

git checkout 3.7.0 명령어로 버전을 바꿔줍니다. 완료된 후 flutter --version 등 아무 명령어를 한 번 입력하면 적용됩니다.

![https://blog.kakaocdn.net/dn/pag4O/btsai4TI8mq/fLmHnq2a51vj9xFCK53JB1/img.png](https://blog.kakaocdn.net/dn/pag4O/btsai4TI8mq/fLmHnq2a51vj9xFCK53JB1/img.png)

![https://blog.kakaocdn.net/dn/lQMyn/btsal3Uhtbj/lGIffVqCJzEUyfasguzKXk/img.png](https://blog.kakaocdn.net/dn/lQMyn/btsal3Uhtbj/lGIffVqCJzEUyfasguzKXk/img.png)

버전 변경 이후 다시 실행 커맨드를 입력하면 이번에는 다른 에러가 발생합니다. intl 패키지에서 발생하는데 0.18버전이 필요한데 실제로는 0.17버전만 존재한다는 내용입니다.

![https://blog.kakaocdn.net/dn/ppXOe/btsak3NLm5k/okCgO27UMmMPa8NTYw3GR0/img.png](https://blog.kakaocdn.net/dn/ppXOe/btsak3NLm5k/okCgO27UMmMPa8NTYw3GR0/img.png)

pubspec.yaml파일로 가서 intl의 버전을 0.17.0으로 바꿔줍니다.

![https://blog.kakaocdn.net/dn/6vaRs/btsakhSLGb0/Gn6EsSKgfKf4jCkhd7qYl1/img.png](https://blog.kakaocdn.net/dn/6vaRs/btsakhSLGb0/Gn6EsSKgfKf4jCkhd7qYl1/img.png)

위 과정을 마치면 정상적으로 앱이 실행됩니다.

![https://blog.kakaocdn.net/dn/LsKah/btsai4lStDT/vqXHNwULiKvbak6huqKxOk/img.png](https://blog.kakaocdn.net/dn/LsKah/btsai4lStDT/vqXHNwULiKvbak6huqKxOk/img.png)
