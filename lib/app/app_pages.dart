import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quizapp/home/home.dart';
import 'package:quizapp/login/login.dart';

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
      return [HomePage.page()];
    }
    return pages;
  }
}
