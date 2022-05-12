import 'package:flutter/material.dart';
import 'package:quizapp/l10n/l10n.dart';
import 'package:shared/shared.dart';
import 'package:ui_toolkit/ui_toolkit.dart';

enum NavBarItem { topics, about, profile }

extension NavBarItemExtensions on NavBarItem {
  bool get isTopics => this == NavBarItem.topics;
}

class NavBarController extends PageController {
  NavBarController({NavBarItem initialItem = NavBarItem.topics})
      : _notifier = ValueNotifier<NavBarItem>(initialItem),
        super(initialPage: initialItem.index) {
    _notifier.addListener(_listener);
  }

  final ValueNotifier<NavBarItem> _notifier;

  NavBarItem get item => _notifier.value;
  set item(NavBarItem newItem) => _notifier.value = newItem;

  void _listener() {
    jumpToPage(item.index);
  }

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Theme(
      data: context.theme.copyWith(
        highlightColor: QuizColors.transparent,
        splashColor: QuizColors.transparent,
      ),
      child: BottomNavigationBar(
        onTap: (index) {
          context.read<NavBarController>().item = NavBarItem.values[index];
        },
        currentIndex: context
            .select((NavBarController controller) => controller.item.index),
        items: [
          BottomNavigationBarItem(
            label: l10n.topicsLabel,
            icon: const Icon(FontAwesomeIcons.graduationCap),
          ),
          BottomNavigationBarItem(
            label: l10n.aboutLabel,
            icon: const Icon(FontAwesomeIcons.bolt),
          ),
          BottomNavigationBarItem(
            label: l10n.profileLabel,
            icon: const Icon(FontAwesomeIcons.circleUser),
          ),
        ],
      ),
    );
  }
}
