import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_bloc/Presentation/routes/routes.gr.dart';

import '../../../../Application/auth/bloc/auth_bloc_bloc.dart';
import '../../../../Application/auth/sign_in_form/sign_in_form_bloc.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
            () {},
            (either) => either.fold((failure) {
                 FlushbarHelper.createError(
                message: failure.map(
                  cancelledByUser: (_) => 'Cancelled',
                  serverError: (_) => 'Server error',
                  emailAlreadyInUse: (_) => 'Email already in use',
                  invalidEmailAndPasswordCombination: (_) =>
                      'Invalid email and password combination',
                ),
              ).show(context);
            }, (r) {
                      AutoRouter.of(context).replace(const NotesOverviewRoute());
              context
                  .read<AuthBloc>()
                  .add(const AuthBlocEvent.authCheckedRequested());
                }));
      },
      builder: (context, state) {
        return Form(
          autovalidateMode: AutovalidateMode.always,
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: [
              const Text(
                '📝',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 130),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email',
                ),
                autocorrect: false,
                onChanged: (value) => context
                    .read<SignInFormBloc>()
                    .add(SignInFormEvent.emailChanged(value)),
                validator: (_) => context
                    .read<SignInFormBloc>()
                    .state
                    .emailAddress
                    .value
                    .fold(
                      (f) => f.maybeMap(
                        invalidEmail: (_) => 'Invalid Email',
                        orElse: () => null,
                      ),
                      (_) => null,
                    ),
              ),
              const SizedBox(height: 28),
              TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                  autocorrect: false,
                  obscureText: true,
                  onChanged: (value) => context
                      .read<SignInFormBloc>()
                      .add(SignInFormEvent.passwordChanged(value))),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<SignInFormBloc>().add(
                              const SignInFormEvent
                                  .signInWithEmailAndPassword(),
                            );
                      },
                      child: const Text('SIGN IN'),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<SignInFormBloc>().add(
                              const SignInFormEvent
                                  .registerWithEmailAndPassword(),
                            );
                      },
                      child: const Text('REGISTER'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<SignInFormBloc>()
                      .add(const SignInFormEvent.signInWithGooglePressesd());
                },
                // color: Colors.lightBlue,
                child: const Text(
                  'SIGN IN WITH GOOGLE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
               if (state.isSubmitting) ...[
                const SizedBox(height: 8),
                const LinearProgressIndicator(value: null),
              ]
            ],
            
          ),
        );
      },
    );
  }
}
