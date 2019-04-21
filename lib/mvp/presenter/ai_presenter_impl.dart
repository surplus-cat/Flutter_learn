import 'package:flutter_learn/mvp/presenter/ai_presenter.dart';
import 'package:flutter_learn/mvp/repository/ai_repository.dart';
import 'package:flutter_learn/mvp/repository/ai_repository_impl.dart';


class AIPresenterImpl implements AIPresenter {

  AIView _view;

  AIRepository _repository;

  AIPresenterImpl(this._view) {
    _view.setPresenter(this);
  }

  @override
  loadAIData(String type, int pageNum, int pageSize) {
    assert(_view != null);

    _repository.fetch(type, pageNum, pageSize).then((data) {
      _view.onloadFLSuc(data);
    }).catchError((error) {
      print(error);
      _view.onloadFLFail();
    });
  }

  @override
  init() {
    // TODO: implement init
    _repository = new AIRepositoryImpl();
  }
}