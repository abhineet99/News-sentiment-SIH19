import 'package:flutter/material.dart';
import 'config.dart';
import 'news.dart';

class NewsPage extends StatefulWidget {
  News news;
  NewsPage({this.news});
  @override
  State<StatefulWidget> createState() => NewsPageState(news: news);
}

class NewsPageState extends State<NewsPage> {
  static BuildContext _context;
  News news;
  NewsPageState({this.news});
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
  static Widget getBar(News news) => Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                // width: 50,
                //  height: 150,
                padding: EdgeInsets.fromLTRB(9, 4, 9, 4),
                child: Center(child: ((news.sentiment == "Positive") ? good : bad)),
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
  
  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        //  child: Center(child: Icon(Icons.pages),),
        child: Column(
          children: <Widget>[
            Hero(
              tag: "NewsImage"+news.id.toString(),
              child: Container(
                height: 260,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: NetworkImage(news.imageUrl)),
                  // borderRadius: BorderRadius.only(
                  //    topLeft: Radius.circular(10),
                  //    bottomLeft: Radius.circular(10))
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(2)),
            getBar(news),
            // Padding(padding: EdgeInsets.all(2)),
            Container(
              padding: EdgeInsets.fromLTRB(9, 4, 4, 4),

              //  child: Hero(
              //    tag: "headline" + 0.toString(),
              child: Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                  child: Text(
                    news.title,
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  )),
            ), //),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                              style: TextStyle(color: Colors.grey))),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.grey[500],
              indent: 15,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text("-"),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        foregroundColor: Colors.grey,
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
      floatingActionButtonLocation: _Location(),
    );
  }
}

class _Location extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    // TODO: implement getOffset
    return Offset(10, 20);
  }
}
