import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:quizapp/app/cubit/app_cubit.dart';
import 'package:quizapp/home/home.dart';
import 'package:quizapp/l10n/l10n.dart';
import 'package:quizapp/login/login.dart';
import 'package:ui_toolkit/ui_toolkit.dart';
import 'package:user_repository/user_repository.dart';

List<Page> onGenerateAppPages(
  AppStatus status,
  List<Page<dynamic>> pages,
) {
  if (status.isUnauthenticated) {
    return [LoginPage.page()];
  }
  if (status.isNewlyAuthenticated) {
    return [HomePage.page()];
  }
  return pages;
}

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.userRepository,
  }) : super(key: key);

  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<UserRepository>.value(
      value: userRepository,
      child: BlocProvider<AppCubit>(
        create: (_) => AppCubit(userRepository: userRepository),
        child: const _AppView(),
      ),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => context.l10n.appTitle,
      theme: QuizTheme.dark(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocListener<AppCubit, AppState>(
        listener: (context, state) {
          if (state.isFailure) {
            final failure = state.failure;
            final l10n = context.l10n;
            if (failure is AuthUserChangesFailure) {
              context.showSnackBar(l10n.authFailureMessage);
            } else if (failure is SignOutFailure) {
              context.showSnackBar(l10n.signOutFailureMessage);
            } else {
              context.showSnackBar(l10n.unknownFailureMessage);
            }
          }
        },
        child: FlowBuilder(
          onGeneratePages: onGenerateAppPages,
          state: context.select<AppCubit, AppStatus>(
            (cubit) => cubit.state.status,
          ),
        ),
      ),
    );
  }
}
