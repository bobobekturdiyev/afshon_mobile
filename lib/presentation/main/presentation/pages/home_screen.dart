import 'package:afshon_ar/core/resources/app_colors.dart';
import 'package:afshon_ar/core/resources/app_icons.dart';
import 'package:afshon_ar/core/resources/app_toast.dart';
import 'package:afshon_ar/core/resources/styles.dart';
import 'package:afshon_ar/presentation/main/presentation/widgets/w_subject.dart';
import 'package:afshon_ar/presentation/search/presentation/widgets/search_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../manager/subject_screen_bloc.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SubjectScreenBloc(
        subjectRepo: _.read(),
      ),
      child: BlocListener<SubjectScreenBloc, SubjectScreenState>(
        listener: (context, state) {
          if (state is ErrorSubject) {
            AppToast.show(context: context, message: state.message);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            backgroundColor: AppColors.backgroundColor,
            title: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SearchScreen()));
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.search,
                      colorFilter: const ColorFilter.mode(
                          AppColors.white, BlendMode.srcIn),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Search the models",
                      style: Styles.getTextStyle(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: BlocBuilder<SubjectScreenBloc, SubjectScreenState>(
            builder: (context, state) {
              if (state is Loaded) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      mainAxisExtent: 200,
                    ),
                    children: List.generate(
                      state.subjects.length,
                      (index) => WSubject(
                        subjectDto: state.subjects[index],
                      ),
                    ),
                  ),
                );
              } else if (state is Loading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                    backgroundColor: AppColors.cardColor,
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: AppColors.primaryColor,
            child: SvgPicture.asset(
              AppIcons.camera,
              colorFilter:
                  const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }
}
