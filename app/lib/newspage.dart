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
  static Widget bar = Row(
    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Expanded(
        flex: 1,
        child: Container(
            // width: 50,
            //  height: 150,
            padding: EdgeInsets.fromLTRB(9, 4, 9, 4),
            child: Center(child: good)),
      ),
      Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.all(9),
              child: Center(
                  child: Text(
                "Score",
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
                  Navigator.of(_context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Scaffold(
                      appBar: AppBar(),
                      body: Container(),
                    );
                  }));
                },
              )))
    ],
  );
  static final bad = Container(
    height: 25,
    width: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3), color: Colors.greenAccent),
    child: Center(
        child: Text(
      "Bad",
      style: TextStyle(color: Colors.red),
    )),
  );
  @override
  Widget build(BuildContext context) {
    _context=context;
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.height;
    return Scaffold(
      
      backgroundColor: Colors.grey[200],
      body: Container(
        //  child: Center(child: Icon(Icons.pages),),
        child: Column(
          children: <Widget>[
            Hero(
              tag: "NewsImage0",
              child: Container(
                height: 260,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: NetworkImage(Config.textImg)),
                  // borderRadius: BorderRadius.only(
                  //    topLeft: Radius.circular(10),
                  //    bottomLeft: Radius.circular(10))
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(2)),
            bar,
           // Padding(padding: EdgeInsets.all(2)),
            Container(
                padding: EdgeInsets.fromLTRB(9, 4, 4, 4),
                
                  //  child: Hero(
                  //    tag: "headline" + 0.toString(),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                        child:Text(
                        "Kritagya k tatte chatta pakda gaya jai, library me kr rahe the kand",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      )),
                    ),//),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment(-1, 0),
                                    child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Text(
                                          "Times of India",
                                          style: TextStyle(color: Colors.grey),
                                        )),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment(1, 0),
                                    child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 10, 0),
                                        child: Text("Date-Time",
                                            style:
                                                TextStyle(color: Colors.grey))),
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
                      child: Text(
                        "Details"
                      ),
                    )
            ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        foregroundColor: Colors.grey,
        backgroundColor: Colors.white,
        onPressed: (){
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
      floatingActionButtonLocation: _Location(),
    );
  }
}
class _Location extends FloatingActionButtonLocation{
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    // TODO: implement getOffset
    return Offset(10, 20);
  }

}