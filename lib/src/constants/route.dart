import 'package:get/get.dart';
import 'package:pkkl/src/index.dart';
import 'package:pkkl/src/pages/controller.dart';
import 'package:pkkl/src/pages/login/index.dart';

const index = '/';
const login = '/login';

const mainRoute = index;
const loginRoute = login;

final routes = [
  GetPage(
    name: index,
    page: () => const MainPage(),
    binding: BindingsBuilder(() => {Get.put(MainController())}),
    children: [
      GetPage(
        name: login,
        page: () => const LoginPage(),
      ),
    ],
  ),
];
