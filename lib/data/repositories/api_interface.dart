import 'package:lab_app/domain/models/card.dart';

abstract class ApiInterface {
  Future<List<CardData>?> loadData();
}