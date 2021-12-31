
import 'package:carrot/repository/contents_respository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState  createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String currentLocation;
  late ContentsController contentsController;
  final Map<String, String> locationTypeToString = {
    'ara' : '아라동',
    'ora' : '오라동',
    'donam' : '도남동',
  };

  @override
  void initState() {
    super.initState();
    currentLocation = 'ara';
  }

  @override
    void didChangeDependencies() {
    super.didChangeDependencies();
    contentsController = ContentsController();
  }

  final oCcy = new NumberFormat('#,###', 'ko_KR');
  String calcStringToWon(String priceString) {
    if(priceString == '무료나눔') return priceString;
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

  _loadContent() {
    return contentsController.loadContentsFromLocation(currentLocation);
  }

  _swift() {
    // print(contentsController._getBatteryLevel());
    return contentsController.getBatteryLevel();
  }

  _makeDataList(List<Map<String, String>> datas) {
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
                                      child: Text(datas[index]['likes'].toString(),),
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


  Widget _bodyWidget() {
    return FutureBuilder(
      future: _loadContent(),
      builder: (BuildContext context, dynamic snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          print(snapshot.data);
          if(snapshot.data != null) {
            return Center(child: Text('데이터 오류'));
          }
          return Center(child: Text(_swift()));
        }

        if (snapshot.hasData) {
          _swift();
         return _makeDataList(snapshot.data);
        }

        return Center(child: Text('해당 지역에 데이터 없음'));
      }
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: _bodyWidget(),
    );
  }
}







