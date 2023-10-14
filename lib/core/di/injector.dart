import 'package:flutter/material.dart';

class Injector extends StatelessWidget {
  final Widget child;

  const Injector({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
    // return MultiRepositoryProvider(
    //   providers: [..._getAuthRepo(), ..._getProfileRepo(), ..._getClientRepo()],
    //   child: MultiBlocProvider(providers: [
    //     BlocProvider<BottomNavBarBloc>(
    //       create: (_) => BottomNavBarBloc(),
    //     ),
    //
    //   ], child: child),
    // );
  }
}
