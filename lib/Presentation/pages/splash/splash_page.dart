import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_bloc/Application/auth/bloc/auth_bloc_bloc.dart';
import 'package:notes_app_bloc/Presentation/routes/routes.gr.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthBlocState>(
      listener: (context, state) {
       state.map(initial: (_){},
        authenticated: (_)=>AutoRouter.of(context).pushNamed(NotesRoute.name), 
        unauthenticated:(_)=>AutoRouter.of(context).pushNamed(SignInRoute.name), 
        );
      },
      child: Container(),
    );
  }
}
