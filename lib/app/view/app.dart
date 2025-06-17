import 'package:app_ui/app_ui.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:quizapp/app/cubit/app_cubit.dart';
import 'package:quizapp/home/home.dart';
import 'package:quizapp/l10n/l10n.dart';
import 'package:quizapp/login/login.dart';
import 'package:user_repository/user_repository.dart';

List<Page<dynamic>> onGenerateAppPages(
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
    required this.userRepository,
    super.key,
  });

  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<UserRepository>.value(
      value: userRepository,
      child: BlocProvider<AppCubit>(
        create: (_) => AppCubit(userRepository: userRepository),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

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
        listenWhen: (_, current) => current.isFailure,
        listener: (context, state) {
          final l10n = context.l10n;
          return switch (state.failure) {
            AuthUserChangesFailure() => context.showSnackBar(
              l10n.authFailureMessage,
            ),
            SignOutFailure() => context.showSnackBar(
              l10n.signOutFailureMessage,
            ),
            _ => context.showSnackBar(l10n.unknownFailureMessage),
          };
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
