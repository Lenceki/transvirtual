import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trans_virtual/application/bloc/auth_bloc.dart';
import 'package:trans_virtual/application/bloc/result_state.dart';
import 'package:trans_virtual/application/page/login_page_widget.dart';
import 'package:trans_virtual/data/login_repo.dart';
import 'package:trans_virtual/domain/model/user_login.dart';
import 'package:trans_virtual/domain/repository_type/auth_repo_type.dart';

import 'dashboard_page_widget.dart';

class LandingPageWidget extends StatefulWidget {

  const LandingPageWidget({super.key});
  @override
  State<LandingPageWidget> createState() => _LandingPageWidgetState();
}

class _LandingPageWidgetState extends State<LandingPageWidget>  {
  late AuthBloc authBloc;
  @override
  void initState() {

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthRepo>(
        create: (context) => AuthRepo(),
        child: BlocProvider(
            create: (context) => AuthBloc(repoType: context.read<AuthRepo>())..autoLogin(),
            child:  MaterialApp(
              initialRoute: '/',
              routes: {
                '/': (context) => const LoginPageWidget(),
                '/dashboard': (context) => const DashBoardPageWidget(),
              },
            ),

        )
    );
  }

}