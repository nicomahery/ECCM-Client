import 'package:eccm_client/pages/home_page.dart';
import 'package:eccm_client/pages/live_page.dart';
import 'package:eccm_client/pages/setting_page.dart';
import 'package:eccm_client/pages/trip_list_page.dart';
import 'package:eccm_client/pages/trip_page.dart';
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
      GoRoute(
        path: TripListPage.PATH,
        builder: (BuildContext context, GoRouterState state) => const TripListPage()
      ),
      GoRoute(
        path: LivePage.PATH,
        builder: (BuildContext context, GoRouterState state) => const LivePage()
      ),
      GoRoute(
        path: TripPage.PATH + '/:id',
        builder: (BuildContext context, GoRouterState state) => TripPage(tripId: state.params['id'])
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
        primarySwatch: Colors.grey,
        splashColor: Colors.grey,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade700,
          foregroundColor: Colors.white
        ),
        cardTheme: CardTheme(
          color: Colors.black,
        ),
        dividerTheme: DividerThemeData(
          color: Colors.white,
          thickness: 2
        ),

        inputDecorationTheme: InputDecorationTheme(
          iconColor: Colors.grey,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          helperStyle: TextStyle(
            color: Colors.grey,
          ),
          suffixStyle: TextStyle(
            color: Colors.grey,
          ),
          labelStyle: TextStyle(
            color: Colors.grey,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.grey,
                style: BorderStyle.solid
            ),
            borderRadius: const BorderRadius.all(Radius.zero)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white,
                style: BorderStyle.solid
            ),
            borderRadius: const BorderRadius.all(Radius.zero)
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              style: BorderStyle.solid
            ),
            borderRadius: const BorderRadius.all(Radius.zero)
          ),

        )
      ),
      routerDelegate: this._router.routerDelegate,
      routeInformationParser: this._router.routeInformationParser,
      debugShowCheckedModeBanner: false,
    );
  }
}

