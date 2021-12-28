
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState  createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, String>> datas = [];
  late String currentLocation;
  final Map<String, String> locationTypeToString = {
    'ara' : '아라동',
    'ora' : '오라동',
    'donam' : '도남동',
  };

  @override
  void initState() {
    super.initState();
    currentLocation = 'ara';
    datas = [
      {
        'image' : 'assets/images/1.jpeg',
        'title' : '네메시스 축구화 275',
        'location' : '제주 제주시 아라동',
        'price' : '30000',
        'like' : '2'
      },
      {
        'image' : 'assets/images/2.jpeg',
        'title' : 'LA갈비 5kg팔아요!',
        'location' : '제주 제주시 아라동',
        'price' : '100000',
        'like' : '5'
      },
      {
        'image' : 'assets/images/3.jpeg',
        'title' : '치약팝니다',
        'location' : '제주 제주시 아라동',
        'price' : '5000',
        'like' : '0'
      },
      {
        'image' : 'assets/images/4.png',
        'title' : '맥북 프로 풀 박스 안녕 ㅋㄷㅋㄷ챔픜ㄷㅋ챔프ㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇ',
        'location' : '제주 제주시 아라동',
        'price' : '2500000',
        'like' : '2'
      },
      {
        'image' : 'assets/images/5.png',
        'title' : '디월트존기임팩',
        'location' : '제주 제주시 아라동',
        'price' : '150000',
        'like' : '2'
      },
      {
        'image' : 'assets/images/6.jpeg',
        'title' : '갤럭시 s10',
        'location' : '제주 제주시 아라동',
        'price' : '180000',
        'like' : '2'
      },
      {
        'image' : 'assets/images/7.jpeg',
        'title' : '선반',
        'location' : '제주 제주시 아라동',
        'price' : '15000',
        'like' : '2'
      },
      {
        'image' : 'assets/images/8.jpeg',
        'title' : '냉장 쇼 케이스',
        'location' : '제주 제주시 아라동',
        'price' : '80000',
        'like' : '3'
      },
      {
        'image' : 'assets/images/9.jpeg',
        'title' : '대우 미니 냉장고',
        'location' : '제주 제주시 아라동',
        'price' : '30000',
        'like' : '30000'
      },
      {
        'image' : 'assets/images/10.jpeg',
        'title' : '멜킨스 풀업 턱걸이',
        'location' : '제주 제주시 아라동',
        'price' : '50000',
        'like' : '7'
      },
    ];
  }

  final oCcy = new NumberFormat('#,###', 'ko_KR');
  String calcStringToWon(String priceString) {
    return '${oCcy.format(int.parse(priceString))}원';
  }


  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      // leading: Text('test'),
      title: GestureDetector(
          onTap: () {
            print('click');
          },
          child: PopupMenuButton<String> (
            offset: Offset(0,25),
            shape: ShapeBorder.lerp(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              1
            ),
            onSelected: (String where) {
              print(where);
              setState( () {
                currentLocation = where;
              });
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(value: 'ara', child: Text('아라동')),
                PopupMenuItem(value: 'ora', child: Text('오라동')),
                PopupMenuItem(value: 'donam', child: Text('도남동'))
              ];
            },
            child: Row(
                children: [
                  Text(locationTypeToString[currentLocation].toString(), style: TextStyle(color: Colors.black)),
                  Icon(Icons.arrow_drop_down, color:Colors.black),
                ]
            )
          ),

      ),
      elevation: 1,
      backgroundColor: Colors.white,
      actions : [
        IconButton(onPressed: () {}, icon: Icon(Icons.search), color: Colors.black),
        IconButton(onPressed: () {}, icon: Icon(Icons.tune), color:Colors.black),
        IconButton(onPressed: () {}, icon: SvgPicture.asset(
            "assets/svg/bell.svg",
            width:22
        ))
      ],
    );
  }

  Widget _bodyWidget() {
    return ListView.separated(
        itemBuilder: (BuildContext _context, int index) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical:10),
            margin: const EdgeInsets.symmetric(horizontal:10),
            child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: Image.asset(datas[index]['image'].toString(), width:100, height:100),
                  ),
                  Expanded(
                    child: Container(
                        height: 100,
                        // width: MediaQuery.of(context).size.width - 100,
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(datas[index]['title'].toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(height:5),
                              Text(datas[index]['location'].toString(),
                                  style: TextStyle(fontSize:12, color: Colors.black.withOpacity(0.3))
                              ),
                              SizedBox(height:5),
                              Text(calcStringToWon(datas[index]['price'].toString()), style: TextStyle(fontWeight: FontWeight.w500)),
                              Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SvgPicture.asset('assets/svg/heart.svg', width:13, height:13),
                                      Padding(
                                        padding: const EdgeInsets.only(left:5.0),
                                        child: Text(datas[index]['like'].toString(),),
                                      ),
                                    ],
                                  )

                              ),
                            ]
                        )
                    ),
                  ),
                ]
            ),
          );
          },
        separatorBuilder: (BuildContext _context, int index) {
          return Container(height:1, color : Colors.black.withOpacity(0.5));
        }, itemCount: 10,);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: _bodyWidget(),
    );
  }
}







