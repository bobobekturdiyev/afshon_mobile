import 'package:afshon_ar/presentation/main/data/data_sources/subject_service.dart';
import 'package:afshon_ar/presentation/main/data/repositories/impl_subject_repo.dart';
import 'package:afshon_ar/presentation/main/domain/repositories/subject_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'locator.dart';

class Injector extends StatelessWidget {
  final Widget child;

  const Injector({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        ..._getSubjectRepo(),
      ],
      child: child,
    );
  }

  _getSubjectRepo() => [
        RepositoryProvider<SubjectService>(
          create: (context) => SubjectService(locator<Dio>()),
        ),
        RepositoryProvider<SubjectRepo>(
          create: (context) => ImplSubjectRepo(
            subjectService: context.read(),
          ),
        ),
      ];
}
