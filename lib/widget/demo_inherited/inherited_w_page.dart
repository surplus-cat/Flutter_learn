import 'package:flutter/material.dart';
import 'package:flutter_learn/model/inherited_test_model.dart';
import 'package:flutter_learn/widget/demo_inherited/inherited_w_test_a.dart';
import 'package:flutter_learn/widget/demo_inherited/inherited_w_test_b.dart';
import 'package:flutter_learn/widget/demo_inherited/inherited_w_test_c.dart';

class InheritedContext extends InheritedWidget {

  // 数据
  final InheritedTestModel inheritedTestModel;

  //点击+号的方法
  final Function() increment;

  //点击-号的方法
  final Function() decrement;

  InheritedContext({
    Key key,
    @required this.inheritedTestModel,
    @required this.increment,
    @required this.decrement,
    @required Widget child,
  }) : super(key: key, child: child);

  static InheritedContext of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(InheritedContext);
  }

  //是否重建widget就取决于数据是否相同

  @override
  bool updateShouldNotify(InheritedContext oldWidget) {
    return inheritedTestModel != oldWidget.inheritedTestModel;
  }
}

class InheritedWidgetTestContainer extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _InheritedWidgetTestContainerState();
  }
}

class _InheritedWidgetTestContainerState extends State<InheritedWidgetTestContainer> {
  
  InheritedTestModel inheritedTestModel;

  _initData() {
    inheritedTestModel = new InheritedTestModel(0);
  }

  @override
  void initState() {
    // TODO: implement initState
    _initData();
    super.initState();
  }

  _incrementCount() {
    setState(() {
      inheritedTestModel = new InheritedTestModel(inheritedTestModel.count + 1);
    });
  }

  _decrementCount() {
    setState(() {
      inheritedTestModel = new InheritedTestModel(inheritedTestModel.count - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new InheritedContext(
      inheritedTestModel: inheritedTestModel,
      increment: _incrementCount,
      decrement: _decrementCount,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('InheritedWidget'),
          centerTitle: true,
        ),
        body: new Column(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: new Text('我们常使用的\nTheme.of(context).textTheme\nModiaQuery.of(context).size等\n就是通过InheritedWidget实现的'),
            ),
            new TestWidgetA(),
            new TestWidgetB(),
            new TestWidgetC(),
          ],
        ),
      ),
    );
  }
}