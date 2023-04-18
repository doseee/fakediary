## 오늘의 공부 : Dart 시작하기

### Variables

- void main() { } 
- ; 필요

```
void main() {
  var name = '니꼬';
  print(name);
}
```

- dart는 알아서 타입 추측

```
void main() {
  var name = '니꼬';
  name = 1;
}
```
- 다른 타입 노노

- 관습적으로 함수나 메소드 내부에 지역 변수를 선언할 때 var 사용
- class에서 변수나 property를 선언할 때는 타입 지정

- 함수 안에서 지역 변수를 선언하거나 아니면 메소드 안에서 지역 변수를 선언하는 상황이라면 var를 사용하는 게 dart 스타일가이드의 권장 방식


```
void main() {
  var name = '니꼬';
  name = 'nico';
}
```
- 재선언 가능


#### Dynamic Type
```
void main() {
  dynamic name;
  if(name is String){
    
  }
  ///////////////////
}
```
- 타입이 정의되면 다양한 내장 함수를 사용할 수 있음
- 정말 필요한 경우에만 써야 함!


#### null safety
- 어떤 변수가 null이 될 수 있음을 명시해주는 것
```
bool isEmpty(String string) => string.length == 0;
main(){
    isEmpty(null);
}
```
- compiler not catch <- 해결하기 위해 dart는 null safety를 만듦

```
void main() {
    String? nico = 'nico';
    nico = null;
    if(nico != null){
        nico.isNotEmpty;
    }
}
```
- null도 될 수 있고 String일 수도 있다 ==> 자료형 뒤에 ?(물음표)
- 내장 함수를 사용하기 전에 항상 체크하는 과정을 가져야 함

-if로 체크하기 싫다면
```
void main() {
    String? nico = 'nico';
    nico = null;
    nico?.isNotEmpty
}
```

- dart 변수는 기본적으로 nullable이 아니라는 것만 기억하자



#### Final Variables
```
void main() {
    final name = 'nico';
}
```

#### Late Variables
```
void main() {
    late final String name;
    // do something, go to api
    name = 'nico' //여전히 final이기 때문에 재선언 불가
}
```
- 데이터 없이 변수를 만들어주고 나중에 변수에 데이터 선언
- 값을 넣기 전에 접근하지 못하도록 dart가 막아줌
- api에서 값을 얻어와야 할 경우 등에서 많이 사용


#### Constant Variables


