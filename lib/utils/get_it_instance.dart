import 'package:eccm_client/services/api_service.dart';
import 'package:eccm_client/services/config_service.dart';
import 'package:eccm_client/services/socket_service.dart';
import 'package:eccm_client/services/trip_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator(ConfigService configService) async {

  locator.registerSingleton(configService);
  locator.registerSingleton(ApiService());
  locator.registerSingleton(SocketService());
  locator.registerSingleton(TripService());
}