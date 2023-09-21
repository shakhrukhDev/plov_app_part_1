import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ploff_app/home/data/model/get_categories_response.dart';
import 'package:ploff_app/home/repository/category_repository.dart';


part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<GetCategoryEvent>(_category);
  }

  final _categoryRepository=CategoryRepository();

  Future<void> _category(GetCategoryEvent event,Emitter<HomeState>emit)async{
    final result=await _categoryRepository.getCategory();
    emit(state.copyWith(getCategoriesResponse: result));
  }
}