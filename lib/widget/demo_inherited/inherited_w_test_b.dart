import 'package:flutter/material.dart';
import 'package:flutter_learn/widget/demo_inherited/inherited_w_page.dart';

class TestWidgetB extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final inheritedContext = InheritedContext.of(context);

    final inheritedTestModel = inheritedContext.inheritedTestModel;

    print('TestWidgetB 中 count的值: ${inheritedTestModel.count}');

    return new Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
      child: new Text('当前count:${inheritedTestModel.count}', style: new TextStyle(fontSize: 20.0),),
    );
  }
}