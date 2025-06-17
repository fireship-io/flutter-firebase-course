import 'dart:io';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/l10n/l10n.dart';
import 'package:quizapp/login/cubit/login_cubit.dart';
import 'package:user_repository/user_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage._();

  static Page<dynamic> page() => const MaterialPage<void>(
    key: ValueKey('login_page'),
    child: LoginPage._(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: kInsets,
        child: BlocProvider(
          create: (_) => LoginCubit(
            userRepository: context.read<UserRepository>(),
          ),
          child: const LoginContent(),
        ),
      ),
    );
  }
}

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (_, current) => current.isFailure,
      listener: (context, state) {
        final l10n = context.l10n;
        return switch (state.failure) {
          AnonymousSignInFailure() => context.showSnackBar(
            l10n.anonymousSignInFailureMessage,
          ),
          GoogleSignInFailure() => context.showSnackBar(
            l10n.googleSignInFailureMessage,
          ),
          AppleSignInFailure() => context.showSnackBar(
            l10n.appleSignInFailureMessage,
          ),
          AppleSignInNotSupportedFailure() => context.showSnackBar(
            l10n.appleSignInNotSupportedFailureMessage,
          ),
          _ => context.showSnackBar(l10n.unknownFailureMessage),
        };
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const FlutterLogo(size: 150),
          const Preamble(),
          const Tagline(),
          if (Platform.isAndroid) const GoogleSignInButton(),
          // At the moment, the preferable solution on Android is blocked by
          // https://github.com/FirebaseExtended/flutterfire/issues/2691
          if (Platform.isIOS) const AppleSignInButton(),
          const AnonymousSignInButton(),
        ],
      ),
    );
  }
}

class Preamble extends StatelessWidget {
  const Preamble({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      context.l10n.loginPreamble,
      style: context.textTheme.headlineSmall,
      textAlign: TextAlign.center,
    );
  }
}

class Tagline extends StatelessWidget {
  const Tagline({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      context.l10n.loginTagline,
      textAlign: TextAlign.center,
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isSigningInWithGoogle = context.select<LoginCubit, bool>(
      (cubit) => cubit.state.isSigningInWithGoogle,
    );
    return SignInButton(
      text: context.l10n.loginWithGoogleButtonLabel,
      icon: FontAwesomeIcons.google,
      color: Colors.black45,
      processing: isSigningInWithGoogle,
      onPressed: isSigningInWithGoogle
          ? null
          : () => context.read<LoginCubit>().signInWithGoogle(),
    );
  }
}

class AppleSignInButton extends StatelessWidget {
  const AppleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isSigningInWithApple = context.select<LoginCubit, bool>(
      (cubit) => cubit.state.isSigningInWithApple,
    );
    return SignInButton(
      text: context.l10n.loginWithAppleButtonLabel,
      color: Colors.black45,
      icon: FontAwesomeIcons.apple,
      processing: isSigningInWithApple,
      onPressed: isSigningInWithApple
          ? null
          : () => context.read<LoginCubit>().signInWithApple(),
    );
  }
}

class AnonymousSignInButton extends StatelessWidget {
  const AnonymousSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isSigningInAnonymously = context.select<LoginCubit, bool>(
      (cubit) => cubit.state.isSigningInAnonymously,
    );
    return SignInButton(
      text: context.l10n.loginAsGuestButtonLabel,
      processing: isSigningInAnonymously,
      onPressed: isSigningInAnonymously
          ? null
          : () => context.read<LoginCubit>().signInAnonymously(),
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.icon,
    this.color,
    this.processing = false,
  });

  final String text;
  final IconData? icon;
  final Color? color;
  final bool processing;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final style = TextButton.styleFrom(
      backgroundColor: color,
    );
    final child = AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: processing
          ? const Loader()
          : Text(
              text.toUpperCase(),
              textAlign: TextAlign.center,
            ),
    );
    if (icon != null) {
      return TextButton.icon(
        style: style,
        icon: Icon(icon),
        onPressed: onPressed,
        label: child,
      );
    }
    return TextButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
