import 'package:shared_preferences/shared_preferences.dart';

const String API_LOCATION_SHARED_PREFERENCE_KEY = 'api_location';
const String API_SECRET_HEADER_SHARED_PREFERENCE_KEY = 'api_secret_header';
const String API_SECRET_SHARED_PREFERENCE_KEY = 'api_secret';
const String WEB_SOCKET_SERVER_LOCATION_SHARED_PREFERENCE_KEY = 'web_socket_server_location';
const String WEB_SOCKET_SERVER_SECRET_PREFERENCE_KEY = 'web_socket_server_secret';

class ConfigService{
  String? apiLocation;
  String? apiSecretHeader;
  String? apiSecret;
  String? webSocketServerLocation;
  String? webSocketServerServer;

  ConfigService() {
    this.setupParametersFromPreferences();
  }

  void setupParametersFromPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    this.apiLocation = sharedPreferences.getString(API_LOCATION_SHARED_PREFERENCE_KEY);
    this.apiSecretHeader = sharedPreferences.getString(API_SECRET_HEADER_SHARED_PREFERENCE_KEY);
    this.apiSecret = sharedPreferences.getString(API_SECRET_SHARED_PREFERENCE_KEY);
    this.webSocketServerLocation = sharedPreferences.getString(WEB_SOCKET_SERVER_LOCATION_SHARED_PREFERENCE_KEY);
    this.webSocketServerServer = sharedPreferences.getString(WEB_SOCKET_SERVER_SECRET_PREFERENCE_KEY);
  }

  void saveParametersToPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    this.apiLocation == null ? sharedPreferences.remove(API_LOCATION_SHARED_PREFERENCE_KEY)
        : sharedPreferences.setString(API_LOCATION_SHARED_PREFERENCE_KEY, this.apiLocation!);
    this.apiSecretHeader == null ? sharedPreferences.remove(API_SECRET_HEADER_SHARED_PREFERENCE_KEY)
        : sharedPreferences.setString(API_SECRET_HEADER_SHARED_PREFERENCE_KEY, this.apiSecretHeader!);
    this.apiSecret == null ? sharedPreferences.remove(API_SECRET_SHARED_PREFERENCE_KEY)
        : sharedPreferences.setString(API_SECRET_SHARED_PREFERENCE_KEY, this.apiSecret!);
    this.webSocketServerLocation == null ? sharedPreferences.remove(WEB_SOCKET_SERVER_LOCATION_SHARED_PREFERENCE_KEY)
        : sharedPreferences.setString(WEB_SOCKET_SERVER_LOCATION_SHARED_PREFERENCE_KEY, this.webSocketServerLocation!);
    this.webSocketServerServer == null ? sharedPreferences.remove(WEB_SOCKET_SERVER_SECRET_PREFERENCE_KEY)
        : sharedPreferences.setString(WEB_SOCKET_SERVER_SECRET_PREFERENCE_KEY, this.webSocketServerServer!);
  }


}