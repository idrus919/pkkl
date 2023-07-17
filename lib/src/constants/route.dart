import 'package:get/get.dart';
import 'package:pkkl/src/middleware.dart';
import 'package:pkkl/src/pages/index.dart';
import 'package:pkkl/src/pages/controller.dart';
import 'package:pkkl/src/pages/login/index.dart';
import 'package:pkkl/src/pages/rank/controller.dart';
import 'package:pkkl/src/pages/rank/index.dart';
import 'package:pkkl/src/pages/user/controller.dart';
import 'package:pkkl/src/pages/user/index.dart';

const index = '/';
const login = '/login';
const user = '/user';
const rank = '/rank';

const mainRoute = index;
const loginRoute = login;
const userRoute = user;
const rankRoute = rank;

final routes = [
  GetPage(
    name: index,
    page: () => const MainPage(),
    binding: BindingsBuilder(() => Get.put<MainController>(MainController())),
    middlewares: [AppMiddleware()],
    children: [
      GetPage(
        name: user,
        page: () => const UserPage(),
        binding: BindingsBuilder(
          () => Get.put<UserController>(UserController()),
        ),
      ),
      GetPage(
        name: rank,
        page: () => const RankPage(),
        binding: BindingsBuilder(
          () => Get.put<RankController>(RankController()),
        ),
      ),
    ],
  ),
  GetPage(
    name: login,
    page: () => const LoginPage(),
  ),
];
