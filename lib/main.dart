import 'package:eccm_client/pages/home_page.dart';
import 'package:eccm_client/pages/setting_page.dart';
import 'package:eccm_client/pages/widget_test_page.dart';
import 'package:eccm_client/services/api_service.dart';
import 'package:eccm_client/services/config_service.dart';
import 'package:eccm_client/utils/get_it_instance.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ConfigService configService = await ConfigService.create();
  setupLocator(configService);
  runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final _router = GoRouter(
    initialLocation: HomePage.PATH,
    routes: [
      GoRoute(
        path: HomePage.PATH,
        builder: (BuildContext context, GoRouterState state) => const HomePage()
      ),
      GoRoute(
        path: SettingPage.PATH,
        builder: (BuildContext context, GoRouterState state) => const SettingPage()
      ),
    ],
    redirect: (GoRouterState state) {
      String? redirection = null;
      if (state.location == HomePage.PATH) {
        final ApiService apiService = locator<ApiService>();
        final bool isApiConfig = apiService.isApiConfig();
        final bool inSetting = state.subloc == SettingPage.PATH;
        if (!isApiConfig) {
          redirection = inSetting ? null : SettingPage.PATH;
        }
        else if (inSetting) {
          redirection = HomePage.PATH;
        }
      }
      return redirection;
    }
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ECCM Client',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: this._router.routerDelegate,
      routeInformationParser: this._router.routeInformationParser,
    );
  }
}

