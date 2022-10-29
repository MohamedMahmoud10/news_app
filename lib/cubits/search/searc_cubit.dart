import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/search/search_state.dart';
import 'package:news_app/data_layer/repositry/repositry.dart';
import 'package:news_app/models/news_models.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit(this.repositry) : super(SearchInitial());
  final Repositry repositry;
  List<Articles> articlesSearchList = [];

  static SearchCubit get(context) => BlocProvider.of(context);

  Future<void> getAllSearchList(String value) async {
    emit(SerachLoading());
    articlesSearchList = [];
    try {
      articlesSearchList = await repositry.getNewsSearchData(value);
      emit(SearchLoadingSuccess(articlesSearchList));
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
