import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizapp/app/cubit/app_cubit.dart';
import 'package:quizapp/profile/cubit/profile_cubit.dart';
import 'package:quizapp/shared/shared.dart';
import 'package:quizapp/l10n/l10n.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:user_repository/user_repository.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
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
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listenWhen: (_, current) => current.action.isLogOut,
      listener: (_, __) => context.read<AppCubit>().logOut(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kDeepOrange,
          title: const DisplayName(),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
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
      ),
    );
  }
}

class DisplayName extends StatelessWidget {
  const DisplayName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displayName =
        context.select((ProfileCubit cubit) => cubit.state.user.displayName);
    return Text(displayName.isNotEmpty
        ? displayName
        : context.l10n.guestProfileDisplayName);
  }
}

const _kProfilePhotoSize = 100.0;

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final photoURL =
        context.select((ProfileCubit cubit) => cubit.state.user.photoURL);
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
                    return Container(
                      color: context.theme.canvasColor,
                      child: const Icon(
                        FontAwesomeIcons.userCircle,
                        size: _kProfilePhotoSize,
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        : const Empty();
  }
}

class EmailAddress extends StatelessWidget {
  const EmailAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final email =
        context.select((ProfileCubit cubit) => cubit.state.user.email);
    return Text(email, style: context.textTheme.headline5);
  }
}

class TotalCompletedQuizzes extends StatelessWidget {
  const TotalCompletedQuizzes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalCompletedQuizzes = context
        .select((ProfileCubit cubit) => cubit.state.user.totalCompletedQuizzes);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$totalCompletedQuizzes',
          style: context.textTheme.headline2,
        ),
        Text(
          context.l10n.totalCompletedQuizzesLabel,
          style: context.textTheme.subtitle1,
        ),
      ],
    );
  }
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      onPressed: context.read<ProfileCubit>().logOut,
      backgroundColor: kRed,
      label: Text(context.l10n.logOutButtonLabel),
    );
  }
}
