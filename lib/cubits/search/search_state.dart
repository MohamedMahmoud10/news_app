import 'package:news_app/models/news_models.dart';

abstract class SearchStates {}

class SearchInitial extends SearchStates {}

class SerachLoading extends SearchStates {}

class SearchLoadingSuccess extends SearchStates {
  final List<Articles> searchList;
  SearchLoadingSuccess(this.searchList);
}
