import '/core/resources/app_colors.dart';
import '/core/resources/app_icons.dart';
import '/core/resources/styles.dart';
import '/presentation/main/data/models/subject_dto.dart';
import '/presentation/main/presentation/manager/objects/objects_screen_bloc.dart';
import '/presentation/main/presentation/widgets/w_object3d_item.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class ObjectsScreen extends StatefulWidget {
  final SubjectDto subjectDto;
  const ObjectsScreen({
    Key? key,
    required this.subjectDto,
  }) : super(key: key);

  @override
  State<ObjectsScreen> createState() => _ObjectsScreenState();
}

class _ObjectsScreenState extends State<ObjectsScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ObjectsScreenBloc(
        subjectRepo: context.read(),
        subjectId: widget.subjectDto.id,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 72),
            child: Container(
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Color(0xFF4D4D4D),
              ))),
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
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
                  Text(
                    widget.subjectDto.title,
                    style: Styles.getTextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          body: BlocBuilder<ObjectsScreenBloc, ObjectsScreenState>(
            builder: (context, state) {
              if (state is Loaded) {
                return ListView.separated(
                  separatorBuilder: (_, index) => const Divider(
                    color: Color(0xFF4D4D4D),
                    height: 1,
                  ),
                  itemBuilder: (_, index) =>
                      WObject3DItem(object3ddto: state.objects[index]),
                  itemCount: state.objects.length,
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
        ),
      ),
    );
  }
}
