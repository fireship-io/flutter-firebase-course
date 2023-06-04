import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/app/cubit/app_cubit.dart';
import 'package:quizapp/l10n/l10n.dart';
import 'package:quizapp/profile/cubit/profile_cubit.dart';
import 'package:user_repository/user_repository.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (_) => ProfileCubit(
        userRepository: context.read<UserRepository>(),
      ),
      child: const Profile(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: QuizColors.deepOrange,
        title: const DisplayName(),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: 50),
          ProfilePhoto(),
          EmailAddress(),
          Spacer(),
          TotalCompletedQuizzes(),
          Spacer(),
          LogOutButton(),
          Spacer(),
        ],
      ),
    );
  }
}

class DisplayName extends StatelessWidget {
  const DisplayName({super.key});

  @override
  Widget build(BuildContext context) {
    final displayName =
        context.select((ProfileCubit cubit) => cubit.state.displayName);
    return Text(
      displayName.isNotEmpty
          ? displayName
          : context.l10n.guestProfileDisplayName,
    );
  }
}

const _kProfilePhotoSize = 100.0;

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    final photoURL =
        context.select((ProfileCubit cubit) => cubit.state.photoURL);
    return photoURL.isNotEmpty
        ? Stack(
            alignment: AlignmentDirectional.center,
            children: [
              const Loader(),
              ClipOval(
                child: FadeInImage.memoryNetwork(
                  image: photoURL,
                  placeholder: kTransparentImage,
                  width: _kProfilePhotoSize,
                  height: _kProfilePhotoSize,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (_, __, ___) {
                    return ColoredBox(
                      color: context.theme.canvasColor,
                      child: const Icon(
                        FontAwesomeIcons.circleUser,
                        size: _kProfilePhotoSize,
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}

class EmailAddress extends StatelessWidget {
  const EmailAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final email = context.select((ProfileCubit cubit) => cubit.state.email);
    return Text(email, style: context.textTheme.headlineSmall);
  }
}

class TotalCompletedQuizzes extends StatelessWidget {
  const TotalCompletedQuizzes({super.key});

  @override
  Widget build(BuildContext context) {
    final totalCompletedQuizzes = context
        .select((ProfileCubit cubit) => cubit.state.totalCompletedQuizzes);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$totalCompletedQuizzes',
          style: context.textTheme.displayMedium,
        ),
        Text(
          context.l10n.totalCompletedQuizzesLabel,
          style: context.textTheme.titleMedium,
        ),
      ],
    );
  }
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      onPressed: context.read<AppCubit>().logOut,
      backgroundColor: QuizColors.red,
      label: Text(context.l10n.logOutButtonLabel),
    );
  }
}
