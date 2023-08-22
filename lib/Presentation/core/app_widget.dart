import 'package:flutter/material.dart';
import 'package:notes_app_bloc/Presentation/core/sign_in/sign_in_page.dart';
import 'package:notes_app_bloc/Presentation/core/styles/app_theme.dart';

import '../home_screen.dart';


class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
          theme: AppTheme.light,
              darkTheme: AppTheme.dark,
      home: const SignInPage(),
    );
  }
}
