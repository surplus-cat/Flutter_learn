import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_learn/common/widget/progress_dialog.dart';
import 'package:flutter_learn/model/ai_model.dart';
import 'package:flutter_learn/mvp/presenter/ai_presenter.dart';
import 'package:flutter_learn/mvp/presenter/ai_presenter_impl.dart';
import 'package:flutter_learn/util/routes_util.dart';


class IOSAppPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    _IOSAppPageState view = new _IOSAppPageState();
    AIPresenter presenter = new AIPresenterImpl(view);
    presenter.init();
    return view;
  }
}


class _IOSAppPageState extends State<IOSAppPage> implements AIView {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  ScrollController _scrollController;

  List<AIModel> datas = [];

  AIPresenter _alPresenter;

  int curPageNum = 1;

  bool isSlideUp = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = new ScrollController()..addListener(_scrollListener);
    _refreshData();
    print('IOS');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadData();
    }
  }

  Future<Null> _refreshData() {
    isSlideUp = false;

    final Completer<Null> completer = new Completer<Null>();

    curPageNum = 1;

    _alPresenter.loadAIData('ios', curPageNum, 10);

    setState(() {});

    completer.complete(null);

    return completer.future;
  }

  Future<Null> _loadData() {
    isSlideUp = true;

    final Completer<Null> completer = new Completer<Null>();

    curPageNum = curPageNum + 1;

    _alPresenter.loadAIData("Android", curPageNum, 10);

    setState(() {});

    completer.complete(null);

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    var content;

    if (datas.isEmpty) {
      content = getProgressDialog();
    } else {
      content = new ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        itemCount: datas.length,
        itemBuilder: buildItem,
      );
    }

    var _refreshIndicator = new RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refreshData,
      child: content,
    );

    return _refreshIndicator;
  }

  Widget buildItem(BuildContext context, int index) {
    final AIModel item = datas[index];
    return new ListTile(
      onTap: (){
        RouteUtil.route2Web(context, item.desc, item.url);
      },
      title: new Text(item.desc), //子item的标题
      trailing: new Icon(
        Icons.arrow_right,
      ), //显示右侧的箭头，不显示则传null
    );
  }

  @override
  void onloadFLFail() {
    // TODO: implement onloadFLFail
  }

  @override
  void onloadFLSuc(List<AIModel> list) {
    //异步处理，防止报错
    if (!mounted) return;
    setState(() {
      if(isSlideUp) {
        datas.addAll(list);
      } else {
        datas = list;
      }
    });
  }

  @override
  setPresenter(AIPresenter presenter) {
    // TODO: implement setPresenter
    _alPresenter = presenter;
  }
}

class TabiOSPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new IOSAppPage(),
    );
  }
}