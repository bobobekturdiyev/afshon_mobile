import 'package:afshon_ar/core/resources/app_colors.dart';
import 'package:afshon_ar/core/resources/app_icons.dart';
import 'package:afshon_ar/core/resources/app_toast.dart';
import 'package:afshon_ar/core/resources/styles.dart';
import 'package:afshon_ar/core/widgets/w_bottomsheet.dart';
import 'package:afshon_ar/presentation/main/presentation/widgets/w_subject.dart';
import 'package:afshon_ar/routes.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:url_launcher/url_launcher.dart';

import '../manager/search/search_bloc.dart';
import '../manager/subject_screen_bloc.dart';
import '../widgets/w_object3d_item.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadModel();
  }

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
                context.router.push(const SearchRoute());
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
                      mainAxisExtent: 160,
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
          floatingActionButton: BlocProvider(
            create: (context) => SearchBloc(subjectRepo: context.read()),
            child: Builder(builder: (context) {
              return BlocListener<SearchBloc, SearchState>(
                listener: (context, state) {
                  if (state is LoadingSearch) {
                    showDialog(
                      context: context,
                      builder: (context) => Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.cardColor,
                              borderRadius: BorderRadius.circular(16)),
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  if (state is LoadedSearch || state is ErrorSearch) {
                    context.router.pop();
                  }
                  if (state is LoadedSearch && state.objects.isNotEmpty) {
                    if (state.objects.length == 1) {
                      _launchARView(context, state.objects.first.url);
                    } else {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => WBottomSheet(
                          title: 'Choose from options',
                          body: ListView.separated(
                            separatorBuilder: (_, index) => const Divider(
                              color: Color(0xFF4D4D4D),
                              height: 1,
                            ),
                            itemBuilder: (_, index) => WObject3DItem(
                                object3ddto: state.objects[index]),
                            itemCount: state.objects.length,
                          ),
                        ),
                      );
                    }
                  } else if (state is LoadedSearch && state.objects.isEmpty) {
                    AppToast.show(
                        context: context,
                        message: 'There is no result for your image');
                  }
                },
                child: FloatingActionButton(
                  onPressed: () async {
                    final image = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                    );
                    var recognitions = await Tflite.runModelOnImage(
                      path: image?.path ?? "",
                      imageMean: 127.5,
                      imageStd: 127.5,
                      threshold: 0.2,
                      numResults: 10,
                    );
                    final value = recognitions?.firstOrNull;
                    if (value != null) {
                      final label = value['label'];
                      context.read<SearchBloc>().add(SearchText(text: label));
                    }
                  },
                  backgroundColor: AppColors.primaryColor,
                  child: SvgPicture.asset(
                    AppIcons.camera,
                    colorFilter: const ColorFilter.mode(
                        AppColors.white, BlendMode.srcIn),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Future<void> _launchARView(BuildContext context, String modelUrl) async {
    final String encodedModelUrl = Uri.encodeComponent(modelUrl);
    final String arUrl =
        'https://arvr.google.com/scene-viewer/1.0?file=$encodedModelUrl&mode=ar_preferred';

    if (!await launchUrl(Uri.parse(arUrl))) {
      AppToast.show(context: context, message: "Cannot launch the model");
    }
  }

  Future<void> loadModel() async {
    String? res = await Tflite.loadModel(
      model: "assets/mobilenet.tflite",
      labels: "assets/labels.txt",
      numThreads: 1,
      isAsset: true,
      useGpuDelegate: false,
    );
  }
}
