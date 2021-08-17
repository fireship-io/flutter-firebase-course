import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizapp/l10n/l10n.dart';
import 'package:quizapp/login/cubit/login_cubit.dart';
import 'package:ui_toolkit/ui_toolkit.dart';
import 'package:user_repository/user_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage._({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginPage._());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: kInsets,
        child: BlocProvider(
          create: (_) => LoginCubit(
            userRepository: context.read<UserRepository>(),
          ),
          child: const _LoginContent(),
        ),
      ),
    );
  }
}

class _LoginContent extends StatelessWidget {
  const _LoginContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (_, current) => current.isFailure,
      listener: (context, state) {
        final l10n = context.l10n;
        final failure = state.failure;
        if (failure is AnonymousSignInFailure) {
          context.showSnackBar(l10n.anonymousSignInFailureMessage);
        } else if (failure is GoogleSignInFailure) {
          context.showSnackBar(l10n.googleSignInFailureMessage);
        } else if (failure is AppleSignInFailure) {
          context.showSnackBar(l10n.appleSignInFailureMessage);
        } else if (failure is AppleSignInNotSupportedFailure) {
          context.showSnackBar(l10n.appleSignInNotSupportedFailureMessage);
        } else {
          context.showSnackBar(l10n.unknownFailureMessage);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const FlutterLogo(size: 150),
          const _Preamble(),
          const _Tagline(),
          if (Platform.isAndroid) const _GoogleSignInButton(),
          // At the moment, the preferable solution on Android is blocked by
          // https://github.com/FirebaseExtended/flutterfire/issues/2691
          if (Platform.isIOS) const _AppleSignInButton(),
          const _AnonymousSignInButton(),
        ],
      ),
    );
  }
}

class _Preamble extends StatelessWidget {
  const _Preamble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      context.l10n.loginPreamble,
      style: context.textTheme.headline5,
      textAlign: TextAlign.center,
    );
  }
}

class _Tagline extends StatelessWidget {
  const _Tagline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      context.l10n.loginTagline,
      textAlign: TextAlign.center,
    );
  }
}

class _GoogleSignInButton extends StatelessWidget {
  const _GoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSigningInWithGoogle = context.select<LoginCubit, bool>(
      (cubit) => cubit.state.isSigningInWithGoogle,
    );
    return _SignInButton(
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

class _AppleSignInButton extends StatelessWidget {
  const _AppleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSigningInWithApple = context.select<LoginCubit, bool>(
      (cubit) => cubit.state.isSigningInWithApple,
    );
    return _SignInButton(
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

class _AnonymousSignInButton extends StatelessWidget {
  const _AnonymousSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSigningInAnonymously = context.select<LoginCubit, bool>(
      (cubit) => cubit.state.isSigningInAnonymously,
    );
    return _SignInButton(
      text: context.l10n.loginAsGuestButtonLabel,
      processing: isSigningInAnonymously,
      onPressed: isSigningInAnonymously
          ? null
          : () => context.read<LoginCubit>().signInAnonymously(),
    );
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton({
    Key? key,
    required this.text,
    this.icon,
    this.color,
    this.processing = false,
    required this.onPressed,
  }) : super(key: key);

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
        label: Expanded(child: child),
      );
    }
    return TextButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
