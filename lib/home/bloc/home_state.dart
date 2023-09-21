part of 'home_bloc.dart';

@immutable
class HomeState extends Equatable {
  final CategoryResponse? categoryResponse;
  final BannerResponse? bannerResponse;

  const HomeState({this.categoryResponse, this.bannerResponse});

  HomeState copyWith({CategoryResponse? getCategoriesResponse, BannerResponse? bannerResponse}) {
    return HomeState(
        categoryResponse: getCategoriesResponse ?? this.categoryResponse,
        bannerResponse: bannerResponse ?? this.bannerResponse
    );
  }

  @override
  List<Object?> get props => [categoryResponse, bannerResponse];
}