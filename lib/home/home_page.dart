import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploff_app/core/utils/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()
        ..add(CategoryEvent())
        ..add(BannerEvent()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.whiteColors,
            appBar: AppBar(
              backgroundColor: Colors.white,
              toolbarHeight: 100.h,
              elevation: 0,
              title: SizedBox(
                height: 48.h,
                child: TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    fillColor: AppColors.whiteColors,
                    filled: true,
                    prefixIcon: const Icon(Icons.search_rounded),
                    hintText: 'Search...',
                    // hintStyle: AppStyle.SFProDisplay24xW500White,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.whiteColors),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: 60.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.categoryResponse?.categories?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColors,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 10.w),
                                  child: Center(
                                    child: Text(state.categoryResponse
                                            ?.categories?[index].name ??
                                        ''),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      height: 172.h,
                      // width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.all(8.w),
                        child: PageView.builder(
                            controller: _controller,
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.bannerResponse?.banners?.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 343.w,
                                      height: 156.h,
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteColors,
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      child: Image.network(
                                        state.bannerResponse?.banners?[index]
                                                .image ??
                                            '',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                  ),
                  SmoothPageIndicator(
                      controller: _controller,
                      count: 2,
                      effect: ExpandingDotsEffect(
                          activeDotColor: AppColors.yellowColors,
                          dotColor: AppColors.white,
                          dotHeight: 4,
                          dotWidth: 8,
                          spacing: 4))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
