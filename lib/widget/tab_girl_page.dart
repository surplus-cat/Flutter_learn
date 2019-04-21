import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_learn/common/widget/progress_dialog.dart';
import 'package:flutter_learn/model/fl_model.dart';
import 'package:flutter_learn/mvp/presenter/fl_presenter.dart';
import 'package:flutter_learn/mvp/presenter/fl_presenter_impl.dart';
import 'package:flutter_learn/widget/demo_gesture/multi_touch_page.dart';

final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

class GirlsAppPage extends StatefulWidget {
  GirlsAppPage({Key key}) : super(key: key);

  @override
  _GirlsAppPageState createState() {
    // TODO: implement createState
    _GirlsAppPageState view = new _GirlsAppPageState();
    FLPresenter presenter = new FLPresenterImpl(view);
    presenter.init();
    return view;
  }
}

class _GirlsAppPageState extends State<GirlsAppPage> implements FLView {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  ScrollController _scrollController;

  List<FLModel> datas = [];

  FLPresenter _flPresenter;

  int curPageNum = 1;

  bool isSlideUp = false;

  // 判断是否到达底部
  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadData();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 初始刷新数据
    _refreshData();
    // 滚动条绑定函数
    _scrollController = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // 销毁移除绑定
    _scrollController.removeListener(_scrollListener);
  }

  Future<Null> _refreshData() {
    isSlideUp = false;

    final Completer<Null> completer = new Completer<Null>();

    curPageNum = 1;

    _flPresenter.loadFLData(curPageNum, 10);

    setState(() {});

    completer.complete(null);

    return completer.future;
  }

  Future<Null> _loadData() {
    isSlideUp = true;

    final Completer<Null> completer = new Completer<Null>();

    curPageNum = curPageNum + 1;

    _flPresenter.loadFLData(curPageNum, 10);

    setState(() {});

    completer.complete(null);

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var content;

    if (datas.isEmpty) {
      content = getProgressDialog();
    } else {
      content = new ListView.builder(
        //设置physics属性总是可滚动
        physics: AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        itemCount: datas.length,
        itemBuilder: buildCard,
      );
    }

    var _refreshIndicator = new RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refreshData,
      child: content,
    );

    return _refreshIndicator;
  }

  void _goPhotoView(String url) {
    Navigator.of(context).push(new PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return new MultiTouchPage(url);
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
    ));
  }

  Widget buildCard(BuildContext context, int index) {
    final String item = datas[index].url;
    return new GestureDetector(
      onTap: () {
        _goPhotoView(item);
      },
      child: new Card(
        child: new Image.network(item),
      ),
    );
  }

  @override
  void onloadFLFail() {
    // TODO: implement onloadFLFail
  }

  @override
  void onloadFLSuc(List<FLModel> list) {
    if (!mounted) return; //异步处理，防止报错
    setState(() {
      if (isSlideUp) {
        datas.addAll(list);
      } else {
        datas = list;
      }
    });
  }

  @override
  setPresenter(FLPresenter presenter) {
    // TODO: implement setPresenter
    _flPresenter = presenter;
  }
}

class TabGirlPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new GirlsAppPage(),
    );
  }
}