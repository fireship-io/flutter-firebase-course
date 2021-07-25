import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizapp/login/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/app_cubit.dart';

class AppPages {
  static List<Page> onGenerateAppPages(
    AppStatus status,
    List<Page<dynamic>> pages,
  ) {
    if (status.isUnauthenticated) {
      return [LoginPage.page()];
    }
    if (status.isNewlyAuthenticated) {
      return [
        const MaterialPage(
          child: TopicsPage(),
        )
      ];
    }
    return pages;
  }
}

class TopicsPage extends StatelessWidget {
  const TopicsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Topics'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AppCubit>().logOut();
            },
            icon: const Icon(FontAwesomeIcons.signOutAlt),
          ),
        ],
      ),
    );
  }
}
