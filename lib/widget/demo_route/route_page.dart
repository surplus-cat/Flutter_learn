import 'package:flutter/material.dart';

import 'package:flutter_learn/widget/demo_route/route_page_with_value.dart';

class RouteAppPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _RouteAppAPageState();
  }
}


class _RouteAppAPageState extends State<RouteAppPage> {

  var _result;

  _onPressed1() async {
    bool value = await Navigator.push(context, 
      new MaterialPageRoute<bool>(builder: (BuildContext context) {
        return new Center(
          child: new GestureDetector(
            child: new Text('OK'),
            onTap: () {
              Navigator.pop(context, true);
            },
          ),
        );
      })
    );

    setState(() {
      _result = value; 
    });
  }

  _onPressed2() {
    showDialog<Null>(
      context: context,
      child: new AlertDialog(content: new Text('这是一个表情'), actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Text('确定'),
        )
      ],)
    );
  }

  void _onPressed3() {
    Navigator.of(context).push(new PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return new RoutePageWithValue('来自RoutePage路由测试3');
      },
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
        return new FadeTransition(
          opacity: animation,
          child: new RotationTransition(
            turns: new Tween<double>(begin: 0.5, end: 1.0).animate(animation),
            child: child,
          ),
        );
      }
      )
    );
  }

  void _onPressed4() {
    // 带返回值
    Navigator.of(context).pushNamed('/RoutePageWithValue1').then((value) {
      _result = value;
    });
  }  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Route 学习'),
        centerTitle: true,
      ),
      body: new Center(
        child: new ListView(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: new RaisedButton(
                child: new Text('路由测试1-MaterialPageRoute'),
                onPressed: _onPressed1,
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: new RaisedButton(
                child: new Text('路由测试2-showDialog'),
                onPressed: _onPressed2,
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: new RaisedButton(
                child: new Text('路由测试3-传递参数'),
                onPressed: _onPressed3,
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: new RaisedButton(
                child: new Text('路由测试4-带返回值'),
                onPressed: _onPressed4,
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: new Text('参数: $_result'),
            )
          ],
        )
      ),
    );
  }
}


class RoutePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new RouteAppPage()
    );
  }
}