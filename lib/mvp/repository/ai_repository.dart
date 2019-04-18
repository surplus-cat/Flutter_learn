
import 'dart:async';
import 'package:flutter_learn/model/ai_model.dart';

abstract class AIRepository {
  Future<List<AIModel>> fetch(String type, int pageNum, int pageSize);
}