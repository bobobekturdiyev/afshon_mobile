import 'package:afshon_ar/core/resources/app_colors.dart';
import 'package:afshon_ar/core/resources/app_icons.dart';
import 'package:afshon_ar/core/resources/styles.dart';
import 'package:afshon_ar/core/widgets/w_textfield.dart';
import 'package:afshon_ar/presentation/main/presentation/manager/search/search_bloc.dart';
import 'package:afshon_ar/presentation/main/presentation/widgets/w_object3d_item.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(subjectRepo: context.read()),
      child: Container(
        color: AppColors.backgroundColor,
        child: SafeArea(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return Scaffold(
                backgroundColor: AppColors.backgroundColor,
                appBar: AppBar(
                  backgroundColor: AppColors.backgroundColor,
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          AppIcons.arrowLeft,
                          colorFilter: const ColorFilter.mode(
                              AppColors.white, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                  titleSpacing: 0,
                  title: WTextField(
                    controller: controller,
                    hint: 'Search',
                    textInputAction: TextInputAction.search,
                    onSubmitted: (str) => search(context, str),
                    onChanged: (str) => search(context, str),
                  ),
                  elevation: 1,
                ),
                body: Builder(
                  builder: (ctx) {
                    if (state is LoadedSearch && state.objects.isNotEmpty) {
                      return ListView.separated(
                        separatorBuilder: (_, index) => const Divider(
                          color: Color(0xFF4D4D4D),
                          height: 1,
                        ),
                        itemBuilder: (_, index) =>
                            WObject3DItem(object3ddto: state.objects[index]),
                        itemCount: state.objects.length,
                      );
                    } else if (state is LoadedSearch && state.objects.isEmpty) {
                      return _getIconData("No items found");
                    } else if (state is LoadingSearch) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                          backgroundColor: AppColors.backgroundColor,
                        ),
                      );
                    } else {
                      return _getIconData("Search for the item");
                    }
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _getIconData(String title) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppIcons.searchDoc,
            colorFilter:
                const ColorFilter.mode(Color(0xFF7C7C7C), BlendMode.srcIn),
          ),
          const SizedBox(height: 18, width: double.infinity),
          Text(
            title,
            style: Styles.getTextStyle(color: const Color(0xFF7C7C7C)),
          ),
        ],
      );

  search(BuildContext context, String str) {
    if (str != "") {
      context.read<SearchBloc>().add(SearchText(text: str));
    }
  }
}
