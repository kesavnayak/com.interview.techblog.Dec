import 'package:flutter/material.dart';
import 'package:techblog/Articles/article_list.dart';
import 'package:techblog/Auth/profile.dart';
import 'package:techblog/DashBoard/dashboard.dart';
import 'package:techblog/Interview/interview_list.dart';

Widget getPage(int index) {
  switch (index) {
    case 0:
      return DashboardScreen();
    case 1:
      return InterviewListScreen();
    case 2:
      return ArticleListScreen();
    //case 3:
    //   return ComapnyScreen();
    //   break;
    // case 4:
    //   return MobileScreen();
    //   break;
    case 3:
      return Profile();
    default:
      return DashboardScreen();
  }
}
