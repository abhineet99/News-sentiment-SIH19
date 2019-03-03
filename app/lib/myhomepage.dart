import 'package:flutter/material.dart';
import 'config.dart';
import 'newspage.dart';
import 'news.dart';
import 'dart:async' show Future, Stream, StreamSubscription;
import 'dart:convert';
import 'dart:io';
import 'Auth.dart';
import 'settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'loader.dart';
import 'Modals.dart';
import 'SplashScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int offset = 0;
  User user;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  String greetings = "Morning ";
  static var _tempNews = News(
      title: "title",
      score: 8,
      sentiment: "sentiment",
      url: "url",
      dateTime: "dateTime",
      source: "source",
      imageUrl: "newsList");
  var time;
  static var newsList = <News>[
    //  _tempNews, _tempNews, _tempNews, _tempNews,
    //  _tempNews, _tempNews, //6 news
  ];
  bool processing = false;
  static int pageNo = 0;

  test() {
    int i;
    if (pageNo > 3) maxOut = true;
    pageNo++;
    for (i = 0; i < 10; i++) {
      newsList.add(_tempNews);
    }
  }

  Future<int> getSize() async {
    print("-----------inside getsize-----");
    String url = Config.url + "/mediamonitor/api/news/?format=json";
    try {
      print("----trying-----");
      final response = await http.get(
        url,
      );
      var responseJson = json.decode(response.body.toString());
      print("response:::::::::::");
      print(responseJson);
      // var mata=responseJson["meta"];
      return responseJson["meta"]["total_count"];
      //return 2;
    } catch (e) {
      print(e);
      return -1;
    }
  }

  Future<dynamic> _fetchEntry(int index) async {
    print("fetch Entry" + index.toString());

    if (index >= newsList.length) {
      print("------------calling populating function");
      try {
        await populateNewsList(pageNo, index);
        if (index >= newsList.length) return {'success': false};
        return {
          'success': true,
          'title': newsList[index].title,
          'score': newsList[index].score,
          'sentiment': newsList[index].sentiment,
          'url': newsList[index].url,
          'dateTime': newsList[index].dateTime,
          'source': newsList[index].source,
          'id': newsList[index].id,
          'imageUrl': newsList[index].imageUrl
        };
      } catch (e) {
        print(e);
        throw (e);
      }
    } else {
      return {
        'success': true,
        'title': newsList[index].title,
        'score': newsList[index].score,
        'sentiment': newsList[index].sentiment,
        'url': newsList[index].url,
        'dateTime': newsList[index].dateTime,
        'source': newsList[index].source,
        'id': newsList[index].id,
        'imageUrl': newsList[index].imageUrl
      };
    }

    //  return Container();
  }

  Future<void> getAll() async {
    String url = Config.url + "/mediamonitor/api/news/?format=json";
    try {
      print("----trying-----");
      final response = await http.get(
        url,
      );
      var responseJson = json.decode(response.body.toString());
      print(responseJson);
      if (responseJson["objects"] != null) {
        if (response.statusCode == 200) {
          var news;
          int temp = 0;
          pageNo++;
          // print(object)
          print("#####adding news######");
          News newNews;
          for (news in responseJson["objects"]) {
            temp++;
            newNews = News(
                title: news["headline"],
                score: news["sentiment_score"],
                sentiment: news["sentiment"],
                url: news["sourceURL"],
                dateTime: news["date"],
                source: news["source"],
                id: news["id"],
                imageUrl: news["imageURL"]);

            newsList.add(newNews);

            //print(newsList[7]);
          }
        }
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<News> populateNewsList(int pageNo, int i) async {
    //test();
    //return;

    //String url = Config.url + "/mediamonitor/api/news/?format=json";
    String url = Config.url + "/mediamonitor/api/news/set/";
    int temp;
    for (temp = pageNo * 5; temp < (pageNo + 1) * 5; temp++) {
      url = url + temp.toString();
      if (temp < (pageNo + 1) * 5 - 1) url += ";";
    }
    try {
      final response = await http.get(
        url,
      );
      var responseJson = json.decode(response.body.toString());
      print(responseJson);
      if (responseJson["objects"] != null) {
        if (response.statusCode == 200) {
          var news;
          int temp = 0;
          print(responseJson);
          pageNo++;
          print("#####adding news######");
          News newNews;
          for (news in responseJson["objects"]) {
            temp++;
            newNews = News(
                title: news["headline"],
                score: news["sentiment_score"],
                sentiment: news["sentiment"],
                url: news["sourceURL"],
                dateTime: news["date"],
                source: news["source"],
                id: news["id"],
                imageUrl: news["imageURL"]);

            newsList.add(newNews);

            //print(newsList[7]);
          }
          print("]]]]]]]]]]]]]]]temp=$temp");
          if (temp != 5) maxOut = true;
        } else {
          throw ("Response returned false, please try again after some time");
        }
      } else {
        throw ("Couldn't connect, network Error");
      }
    } catch (e) {
      throw (e);
    }
  }

  void _showToast(String error) {
    final scaffold = Scaffold.of(_scaffoldKey.currentContext);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(error),
        action: SnackBarAction(
            label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  Widget newsTile(
    var productInfo,
  ) {
    News news = new News(
        title: productInfo["title"],
        score: productInfo["score"],
        sentiment: productInfo["sentiment"],
        url: productInfo["url"],
        dateTime: productInfo["dateTime"],
        source: productInfo["source"],
        id: productInfo["id"],
        imageUrl: productInfo["imageUrl"]);

    print("building news tile:" + news.id.toString());
    return Container(
        padding: EdgeInsets.all(15),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                //offset: Offset(1.0, 6.0),
                blurRadius: 4.0,
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            // color: Colors.red,
          ),
          child: Row(
            children: <Widget>[
              new Expanded(
                flex: 2,
                child: Hero(
                  tag: "NewsImage" + news.id.toString(),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(news.imageUrl)),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10))),
                  ),
                ),
              ),
              new Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: getBar(news),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                            padding: EdgeInsets.fromLTRB(9, 4, 4, 4),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return NewsPage(
                                    news: news,
                                  );
                                }));
                              },
                              //    child: Hero(
                              //      tag: "headline" + i.toString(),
                              child: Text(news
                                  .title), //Kritagya k tatte chatta pakda gaya jai, library me lr rahe the kand
                            )), //),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment(-1, 0),
                                  child: Container(
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Text(
                                        news.source,
                                        style: TextStyle(color: Colors.grey),
                                      )),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment(1, 0),
                                  child: Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                      child: Text(news.dateTime,
                                          style:
                                              TextStyle(color: Colors.grey))),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget newsTile2(
    News news,
  ) {
    print("building news tile:" + news.id.toString());
    return Container(
        padding: EdgeInsets.all(15),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                //offset: Offset(1.0, 6.0),
                blurRadius: 4.0,
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            // color: Colors.red,
          ),
          child: Row(
            children: <Widget>[
              new Expanded(
                flex: 2,
                child: Hero(
                  tag: "NewsImage" + news.id.toString(),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(news.imageUrl)),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10))),
                  ),
                ),
              ),
              new Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: getBar(news),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                            padding: EdgeInsets.fromLTRB(9, 4, 4, 4),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return NewsPage(
                                    news: news,
                                  );
                                }));
                              },
                              //    child: Hero(
                              //      tag: "headline" + i.toString(),
                              child: Text(news
                                  .title), //Kritagya k tatte chatta pakda gaya jai, library me lr rahe the kand
                            )), //),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment(-1, 0),
                                  child: Container(
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Text(
                                        news.source,
                                        style: TextStyle(color: Colors.grey),
                                      )),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment(1, 0),
                                  child: Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                      child: Text(news.dateTime,
                                          style:
                                              TextStyle(color: Colors.grey))),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  //static News news = News();
  static BuildContext _context;
  static Widget getBar(News news) => Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                // width: 50,
                //  height: 150,
                padding: EdgeInsets.fromLTRB(9, 4, 9, 4),
                child: Center(
                    child: ((news.sentiment == "Positive") ? good : bad)),
              )),
          Expanded(
              flex: 1,
              child: Container(
                  padding: EdgeInsets.all(9),
                  child: Center(
                      child: Text(
                    news.score.toString(),
                    style: TextStyle(color: Colors.grey),
                  )))),
          Expanded(
              flex: 1,
              child: Container(
                  alignment: Alignment(0, 0),
                  child: IconButton(
                    iconSize: 18,
                    icon: Icon(
                      Icons.data_usage,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      //open url in browser
                      //url
                    },
                  )))
        ],
      );
  TabController _controller;
  int _index;

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      print("---------token:" + token);
      //print("--------idToken"+user.id);
      Firestore.instance.runTransaction((Transaction transaction) async {
        DocumentReference ref =
            Firestore.instance.document("users/" + user.emailId);
        Map<String, String> data1 = <String, String>{
          "userName": user.name,
          "tokenId": token,
        };
        DocumentSnapshot postSnapshot = await transaction.get(ref);
        if (!postSnapshot.exists) {
          transaction.set(ref, data1);
        }
      });
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  @override
  initState() {
    SignIn.getUser()
        .then((User user1) => setState(() {
              user = user1;
              firebaseCloudMessaging_Listeners();
            }))
        .catchError((e) {
      print(e);
      Navigator.of(context).pushReplacementNamed(SplashScreen.tag);
    });
    if (time.hour > 12) greetings = "Afternoon ";
    if (time.hour > 17) greetings = "Evening ";

    _controller.addListener(() {
      maxOut = false;
    });
    getSize()
    .then((int x) => getAll())
    .then((_) {
      _list = ListView.builder(itemBuilder: (context, index) {
        if (index >= newsList.length) {
          return null;
        }
        return newsTile2(newsList[index]);
        });
    })
    .then((_) => setState(() {}));
    /*   _list = ListView.builder(
          itemCount: x,
          itemBuilder: (context, index) {
            print("itembuilder");
            if (maxOut == true) {
              print("*****returning null maxout");
              return null;
            }
            if (index >= x) {
              print("*****returning null index out");
              return null;
            }

            return FutureBuilder(
              future: this._fetchEntry(index),
              builder: (context, snapshot) {
                print("future builder" + index.toString());
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    return CircularProgressIndicator();
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      if (snapshot.data != null) {
                        var productInfo = snapshot.data;
                        if (productInfo['success'] != false)
                          return newsTile(productInfo);
                        else
                          return Container();
                      }
                    }
                }
              },
            );

            //print("building news" + i.toString());
          },
        );
*/

    super.initState();
  }

  //constructor
  MyHomePageState() {
    _controller = TabController(vsync: this, length: tabs.length);
    time = DateTime.now();
    _index = 0;
    //views = <Widget>[Container(color: Colors.blue,height: 200,), Container(color: Colors.blue,height: 200,), Container(color: Colors.blue,height: 200,)];
  }
  static final good = Container(
    height: 25,
    width: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3), color: Colors.greenAccent),
    child: Center(
        child: Text(
      "Good",
      style: TextStyle(color: Colors.white),
    )),
  );
  static final bad = Container(
    height: 25,
    width: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3), color: Colors.red),
    child: Center(
        child: Text(
      "Bad",
      style: TextStyle(color: Colors.white),
    )),
  );
  bool maxOut = false;
  var _list;

  var views;
  final tabs = <Widget>[
    Tab(
      child: Text("Today",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: Colors.black,
          )),
    ),
    Tab(
      child: Text("This Week",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: Colors.black,
          )),
    ),
    Tab(
      child: Text("All",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: Colors.black,
          )),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    _context = context;
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size(_width, _height / 6),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(12),
            ),
            ListTile(
              title: Text(
                (user != null) ? greetings + user.name : greetings,
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
              ),
              subtitle: Text("Here's your news feed"),
              trailing: Text(
                "45% +ve",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 30,
                    fontWeight: FontWeight.w300),
              ),
            ),
            Divider(
              color: Colors.grey,
              indent: 5,
            ),
            TabBar(
              controller: _controller,
              tabs: tabs,
              indicatorWeight: 1,
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          (_list != null) ? _list : Container(),
          (_list != null) ? _list : Container(),
          (_list != null) ? _list : Container()
        ],
      ),
    );
  }
}
