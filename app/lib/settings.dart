import 'package:flutter/material.dart';
import 'config.dart';
import 'news.dart';
import 'config.dart';
import 'Modals.dart';
import 'Auth.dart';
import 'SplashScreen.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage();
  @override
  State<StatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  static BuildContext _context;
  int _index = 1;
  User user;

  @override
  void initState() {
    // TODO: implement initState
    //how allowed multiple .then here
    SignIn.getUser()
        .then((User user1) => setState(() => user = user1))
        .catchError((e) {
      print(e);
      Navigator.of(context).pushReplacementNamed(SplashScreen.tag);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Home",
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                //padding: EdgeInsets.all(25),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 15,
                      child: Container(
                          decoration: BoxDecoration(
                              // shape: BoxShape.circle,
                              // color: Colors.white,
                              ),
                          child: Container(
                            height: 100,
                            width: 120,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      (user!=null)?
                                      (user.photoUrl != null)
                                          ? user.photoUrl
                                          : Config.testImg:Config.testImg,
                                    ))),
                          )),
                    ),
                    Expanded(
                      flex: 1, //padding
                      child: Container(),
                    ),
                    Expanded(
                        flex: 5,
                        child: Text((user != null) ? user.name : "-",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.w300))),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                          padding: EdgeInsets.all(15),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () => setState(() =>
                                        Config.category = Categories.HYEGINE),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: (Config.category ==
                                                  Categories.HYEGINE)
                                              ? Colors.blue[300]
                                              : Colors.white,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(15),
                                              topLeft: Radius.circular(15))),
                                      child: Center(child: Text("Hygine")),
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () => setState(() =>
                                        Config.category = Categories.CRASH),
                                    child: Container(
                                      color:
                                          (Config.category == Categories.CRASH)
                                              ? Colors.blue[300]
                                              : Colors.white,
                                      child: Center(child: Text("Crash")),
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () => setState(() =>
                                        Config.category = Categories.POSITIVE),
                                    child: Container(
                                      color: (Config.category ==
                                              Categories.POSITIVE)
                                          ? Colors.blue[300]
                                          : Colors.white,
                                      child: Center(child: Text("Positive")),
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () => setState(() =>
                                        Config.category = Categories.OTHERS),
                                    child: Container(
                                      color:
                                          (Config.category == Categories.OTHERS)
                                              ? Colors.blue[300]
                                              : Colors.white,
                                      child: Center(child: Text("Others")),
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () => setState(() =>
                                        Config.category = Categories.URGENT),
                                    child: Container(
                                      color:
                                          (Config.category == Categories.URGENT)
                                              ? Colors.blue[300]
                                              : Colors.white,
                                      child: Center(child: Text("Urgent")),
                                    ),
                                  )),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                    onTap: () => setState(
                                        () => Config.category = Categories.ALL),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: (Config.category ==
                                                  Categories.ALL)
                                              ? Colors.blue[300]
                                              : Colors.white,
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(15),
                                              topRight: Radius.circular(15))),
                                      child: Center(child: Text("All")),
                                    )),
                              ),
                            ],
                          )),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Column(
                          children: <Widget>[
                            Row(children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Email",
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 18),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  (user != null) ? user.emailId : "-",
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 15),
                                ),
                              )
                            ]),
                            Padding(
                              padding: EdgeInsets.all(10),
                            ),
                            Row(children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Mobile",
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 18),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  (user != null)
                                      ? ((user.mobileNo != null)
                                          ? user.mobileNo
                                          : "None")
                                      : "-",
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 15),
                                ),
                              )
                            ]),
                            Padding(
                              padding: EdgeInsets.all(10),
                            ),
                            FlatButton(
                              child: Text("Logout"),
                              onPressed: () {
                                SignIn.logout();
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                  builder: (context)=>SplashScreen(),
                                ), (w)=>true);
                              },
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
      ),

      // floatingActionButton: FloatingActionButton(
      //     mini: true,
      //     foregroundColor: Colors.grey,
      //     backgroundColor: Colors.white,
      //     onPressed: (){
      //       Navigator.pop(context);
      //     },
      //     child: Icon(Icons.arrow_back),
      //   ),
      //    floatingActionButtonLocation: _Location(),
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
