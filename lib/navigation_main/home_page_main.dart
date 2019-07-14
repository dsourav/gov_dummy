import 'package:connectivity/connectivity.dart';
import 'package:design_demo/cart_fragments/cart_fragment_main.dart';
import 'package:design_demo/feedback_fragments/feedback_main.dart';
import 'package:design_demo/home_fragments/home_fragment_main.dart';
import 'package:design_demo/my_oreders_fragment/me_order_fragment_main.dart';
import 'package:design_demo/profile_fragments/profile_main.dart';
import 'package:design_demo/transaction_history_fragments/transact_history_main.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import 'package:flutter_offline/flutter_offline.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePAgeMAin extends StatefulWidget {
  final draawerItems = [
    new DrawerItem("Feed", Icons.rss_feed),
    new DrawerItem("My Orders", Icons.shopping_basket),
    new DrawerItem("Cart", Icons.shopping_cart),
    new DrawerItem("Transaction History", Icons.money_off),
    new DrawerItem("Profile", Icons.account_circle),
    new DrawerItem("Feedback", Icons.feedback),
  ];

  @override
  _HomePAgeMAinState createState() => _HomePAgeMAinState();
}

class _HomePAgeMAinState extends State<HomePAgeMAin> {
  int _selectedDrawerIndex = 0;
  bool state = false;
  bool connected = true;
  var subscription;

  Future<void> _getConnectivityStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        connected=true;
      });
      // I am connected to a mobile network.
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
     setState(() {
       connected=true;
     });
    }
    else{
      setState(() {
        connected=false;
      });
    }
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new HomeFragmentMain();

      case 1:
        return new MyOrdersFragmentMain();

      case 2:
        return new CartFragmentMain();

      case 3:
        return new TransactionHistoryMain();

      case 4:
        return new ProfileMAin();

      case 5:
        return new FeedbackMain();

      default:
        return new Text("Error");
    }
  }

  _onSelectedItem(int pos) {
    setState(() {
      _selectedDrawerIndex = pos;
      Navigator.of(context).pop();
    });
  }

  @override
  initState() {
    super.initState();

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
    });
  }

  @override
  Widget build(BuildContext context) {
    _getConnectivityStatus();
    var drawerOptions = <Widget>[];
    for (int i = 0; i < widget.draawerItems.length; i++) {
      var d = widget.draawerItems[i];

      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectedItem(i),
      ));
    }
    
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.draawerItems[_selectedDrawerIndex].title),
        ),
        drawer: new Drawer(
          child: new Column(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text("sourav"),
                accountEmail: null,
                currentAccountPicture: new CircleAvatar(
                  child: new Icon(Icons.person),
                ),
              ),
              new Column(
                children: drawerOptions,
              )
            ],
          ),
        ),

        //  body:_getDrawerItemWidget(_selectedDrawerIndex)

        body: new Column(
          children: <Widget>[
            new Visibility(
              visible: !connected,
              child: new Container(
                color: Colors.red,
                child: new Center(
                  child: new Text("OFFLINE",style: new TextStyle(color: Colors.white),),
                ),
              ),
            ),
            new Expanded(
              child: _getDrawerItemWidget(_selectedDrawerIndex),
            )
          ],
        ));
  }

  @override
  dispose() {
    super.dispose();

    subscription.cancel();
  }
}
