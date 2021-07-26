import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizapp/about/about.dart';
import 'package:quizapp/l10n/l10n.dart';
import 'package:quizapp/profile/profile.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/shared/shared.dart';

import 'bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage._({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomePage._());

  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
      create: (_) => NavBarController(),
      child: Scaffold(
        appBar: AppBar(
          title: const _HomeTitle(),
          actions: const [_ProfileButton()],
        ),
        body: const _HomeBody(),
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}

class _HomeTitle extends StatelessWidget {
  const _HomeTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navBarItem =
        context.select((NavBarController controller) => controller.item);
    return Text(context.l10n.navBarItem(navBarItem));
  }
}

class _ProfileButton extends StatelessWidget {
  const _ProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navBarItem =
        context.select((NavBarController controller) => controller.item);
    return navBarItem.isTopics
        ? IconButton(
            icon: const Icon(
              FontAwesomeIcons.userCircle,
              color: kPink,
            ),
            onPressed: () =>
                context.read<NavBarController>().item = NavBarItem.profile,
          )
        : const Empty();
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: context.read<NavBarController>(),
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        AboutView(),
        AboutView(),
        ProfileView(),
      ],
    );
  }
}

extension _AppLocalizationsExtensions on AppLocalizations {
  String navBarItem(NavBarItem item) {
    switch (item) {
      case NavBarItem.topics:
        return topicsLabel;
      case NavBarItem.about:
        return aboutLabel;
      case NavBarItem.profile:
        return profileLabel;
      default:
        throw UnimplementedError('$item');
    }
  }
}
