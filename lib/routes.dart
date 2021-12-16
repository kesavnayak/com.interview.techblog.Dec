import 'package:get/get.dart';
import 'package:techblog/Articles/article.dart';
import 'package:techblog/Articles/article_list.dart';
import 'package:techblog/Articles/articles.dart';
import 'package:techblog/Auth/Profile/account.dart';
import 'package:techblog/Auth/Profile/bookmark.dart';
import 'package:techblog/Auth/Success/login_success_screen.dart';
import 'package:techblog/Auth/get_phone.dart';
import 'package:techblog/Auth/select_country.dart';
import 'package:techblog/Auth/verify.dart';
import 'package:techblog/Bindings/index.dart';
import 'package:techblog/DashBoard/dashboard.dart';
import 'package:techblog/Home/home.dart';
import 'package:techblog/Internet/internet_widget.dart';
import 'package:techblog/Interview/interview.dart';
import 'package:techblog/Interview/interview_list.dart';
import 'package:techblog/Onboarding/intro.dart';
import 'package:techblog/Views/root_screen.dart';

final List<GetPage> appPages = [
  GetPage(
    name: "/",
    page: () => RootScreen(),
    binding: RootScreenBindings(),
  ),
  GetPage(
    name: TestInternetWidget.pageId,
    page: () => TestInternetWidget(),
  ),
  GetPage(
    name: IntroScreen.pageId,
    page: () => IntroScreen(),
  ),
  GetPage(
    name: BottomNavBar.pageId,
    page: () => BottomNavBar(),
  ),
  GetPage(
    name: DashboardScreen.pageId,
    page: () => DashboardScreen(),
  ),
  GetPage(
    name: InterviewListScreen.pageId,
    page: () => InterviewListScreen(),
  ),
  // GetPage(
  //   name: MobileScreen.pageId,
  //   page: () => MobileScreen(),
  // ),
  // GetPage(
  //   name: ComapnyScreen.pageId,
  //   page: () => ComapnyScreen(),
  // ),
  GetPage(
    name: InterviewScreen.pageId,
    page: () => InterviewScreen(),
  ),
  GetPage(
    name: ArticleListScreen.pageId,
    page: () => ArticleListScreen(),
  ),
  GetPage(
    name: ArticlesScreen.pageId,
    page: () => ArticlesScreen(),
  ),
  GetPage(
    name: ArticleScreen.pageId,
    page: () => ArticleScreen(),
  ),
  GetPage(
    name: SelectCountry.pageId,
    page: () => SelectCountry(),
  ),
  GetPage(
    name: LoginSuccessScreen.pageId,
    page: () => LoginSuccessScreen(),
  ),
  GetPage(
    name: PhoneAuthVerify.pageId,
    page: () => PhoneAuthVerify(),
  ),
  GetPage(
    name: BookmarkPage.pageId,
    page: () => BookmarkPage(),
  ),
  GetPage(
    name: AccountPage.pageId,
    page: () => AccountPage(),
  ),
  GetPage(
    name: PhoneAuthGetPhone.pageId,
    page: () => PhoneAuthGetPhone(),
  ),
];
