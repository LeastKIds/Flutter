import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Map<String, String>> datas = [];

  @override
  void initState() {
    super.initState();
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
        'title' : '맥북 프로 풀 박스',
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

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      // leading: Text('test'),
      title: GestureDetector(
          onTap: () {
            print('click');
          },
          child: Row(
              children: [
                Text('아리동', style: TextStyle(color: Colors.black)),
                Icon(Icons.arrow_drop_down, color:Colors.black),
              ]
          )
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

  ListView _bodyWidget() {
    return ListView.separated(
        itemBuilder: (BuildContext _context, int index) {
          return Container(
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: Image.asset(datas[index]['image'].toString(), width:100, height:100),
                ),
                Container(
                    child: Column(
                        children: [
                          Text(datas[index]['title'].toString(),),
                          Text(datas[index]['location'].toString(),),
                          Text(datas[index]['price'].toString(),),
                          Row(
                            children: [
                              SvgPicture.asset('assets/svg/heart.svg', width:13, height:13),
                              Padding(
                                padding: const EdgeInsets.only(left:5.0),
                                child: Text(datas[index]['like'].toString(),),
                              ),
                            ],
                          ),
                        ]
                    )
                ),
              ]
            ),
          );
        },
        separatorBuilder: (BuildContext _context, int index) {
          return Container(height:1, color : Colors.black.withOpacity(0.5));
        },
        itemCount: 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: _bodyWidget(),
      // bottomNavigationBar: Container(),

    );
  }
}