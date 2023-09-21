import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:ploff_app/home/data/model/banner_response.dart';
import 'package:ploff_app/home/data/model/category_response.dart';
import 'package:ploff_app/home/repository/banner_repository.dart';
import 'package:ploff_app/home/repository/category_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<CategoryEvent>(_category);
    on<BannerEvent>(_banner);
  }

  final _categoryRepository = CategoryRepository();
  final _bannerRepository = BannerRepository();

  Future<void> _category(CategoryEvent event, Emitter<HomeState> emit) async {
    final result = await _categoryRepository.getCategory();
    emit(state.copyWith(getCategoriesResponse: result));
  }

  Future<void> _banner(BannerEvent event, Emitter<HomeState> emit) async{
    final bannerRes = await _bannerRepository.getBanner();
    emit(state.copyWith(bannerResponse: bannerRes));
  }
}
