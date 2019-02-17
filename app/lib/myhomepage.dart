import 'package:flutter/material.dart';
import 'config.dart';
import 'newspage.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
      static BuildContext _context;
      static Widget bar=Row(
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
                                          Navigator.of(_context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return Scaffold(
                                              appBar: AppBar(),
                                              body: Container(),
                                            );
                                          }));
                                        },
                                      )))
                            ],
                          );
  TabController _controller;
  int _index;
  MyHomePageState() {
    _controller = TabController(vsync: this, length: tabs.length);
    _index = 0;
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
        borderRadius: BorderRadius.circular(3), color: Colors.greenAccent),
    child: Center(
        child: Text(
      "Bad",
      style: TextStyle(color: Colors.red),
    )),
  );
  static final _list = ListView.builder(
    itemCount: 5,
    itemBuilder: (context, i) {
      return Container(
          padding: EdgeInsets.all(15),
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(1.0, 6.0),
                  blurRadius: 4.0,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
              color: Colors.red,
            ),
            child: Row(
              children: <Widget>[
                new Expanded(
                    flex: 2,
                    
                    child: Hero(
                      tag: "NewsImage"+i.toString(),
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(Config.textImg)),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                      ),
                    ),),
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
                          child: bar,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                              padding: EdgeInsets.fromLTRB(9, 4, 4, 4),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return NewsPage(bar: bar,);
                                    
                                  }));
                                },
                                child: Hero(
                                  tag: "headline"+i.toString(),
                                  child:Text(
                                    "Railway minister ne patriyon pe mara muth, saaf krne aaye modi."),
                              ))),
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
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
    },
  );

  final views = <Widget>[_list, _list, _list];
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
    _context=context;
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size(_width, _height / 5),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(12),
            ),
            ListTile(
              title: Text(
                "Morning," + " Yogesh",
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
        children: views,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i) => setState(() => _index = i),
        currentIndex: _index,
        fixedColor: Colors.grey,
        type: BottomNavigationBarType.shifting,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: (_index == 0) ? Colors.blue : Colors.grey[600],
              ),
              title: Text("Home", style: TextStyle(color: Colors.grey[600]))),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: (_index == 1) ? Colors.blue : Colors.grey[600],
              ),
              title: Text("Search", style: TextStyle(color: Colors.grey[600]))),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: (_index == 2) ? Colors.blue : Colors.grey[600],
              ),
              title:
                  Text("Profile", style: TextStyle(color: Colors.grey[600]))),
        ],
      ),
    );
  }
}
