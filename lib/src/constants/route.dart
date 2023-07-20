import 'package:get/get.dart';
import 'package:pkkl/src/middleware.dart';
import 'package:pkkl/src/pages/index.dart';
import 'package:pkkl/src/pages/controller.dart';
import 'package:pkkl/src/pages/login/controller.dart';
import 'package:pkkl/src/pages/login/index.dart';
import 'package:pkkl/src/pages/evaluation/controller.dart';
import 'package:pkkl/src/pages/evaluation/index.dart';
import 'package:pkkl/src/pages/score/controller.dart';
import 'package:pkkl/src/pages/score/index.dart';
import 'package:pkkl/src/pages/user/controller.dart';
import 'package:pkkl/src/pages/user/index.dart';

const index = '/';
const login = '/login';
const user = '/user';
const evaluation = '/evaluation';
const score = '/score';

const mainRoute = index;
const loginRoute = login;
const userRoute = user;
const evaluationRoute = evaluation;
const scoreRoute = score;

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
        name: evaluation,
        page: () => const EvaluationPage(),
        binding: BindingsBuilder(
          () => Get.put<EvaluationController>(EvaluationController()),
        ),
      ),
      GetPage(
        name: score,
        page: () => const ScorePage(),
        binding: BindingsBuilder(
          () => Get.put<ScoreController>(ScoreController()),
        ),
      ),
    ],
  ),
  GetPage(
    name: login,
    page: () => const LoginPage(),
    binding: BindingsBuilder(
      () => Get.put<LoginController>(LoginController()),
    ),
  ),
];
