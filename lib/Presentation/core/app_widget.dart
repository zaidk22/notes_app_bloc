import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_bloc/Application/auth/bloc/auth_bloc_bloc.dart';
import 'package:notes_app_bloc/Presentation/pages/sign_in/sign_in_page.dart';
import 'package:notes_app_bloc/Presentation/core/styles/app_theme.dart';
import 'package:notes_app_bloc/Presentation/routes/routes.dart';
import 'package:notes_app_bloc/injection.dart';

import '../home_screen.dart';


class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppRouter appRouter = AppRouter();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthBloc>()..add(const AuthBlocEvent.authCheckedRequested()),
        ),

      ],
      child: MaterialApp.router(
        routerConfig: appRouter.config(),
        debugShowCheckedModeBanner: false,
       
        title: 'Notes App',
            theme: AppTheme.light,
                darkTheme: AppTheme.dark,
       
      ),
    );
  }
}
