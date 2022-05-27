import 'package:socket_io_client/socket_io_client.dart' as SocketIO;
import '../utils/get_it_instance.dart';
import '../utils/static_const_values.dart';
import 'config_service.dart';

class SocketService {
  late ConfigService _configService;
  SocketIO.Socket? _socketServer;
  bool _isConnectedToServer = false;

  SocketService() {
    this._configService = locator<ConfigService>();
  }

  void connectSocket() {
    if (this._configService.webSocketServerLocation != null && this._configService.webSocketServerSecret != null && !this._isConnectedToServer) {
      this._socketServer = SocketIO.io(
        'ws://${this._configService.webSocketServerLocation}',
        {
          'transports': ['websocket'],
          'auth': {
            'secret': this._configService.webSocketServerSecret
          },
        }
      );
      this._socketServer?.on('disconnect', (data) {
        print('disconnected from server');
        this._isConnectedToServer = false;
      });
      this._isConnectedToServer = true;
    }
  }

  void disconnectSocket() {
    this._socketServer?.dispose();
    this._socketServer = null;
    this._isConnectedToServer = false;
  }

  Future<bool> testConnection() async {
    if (this._socketServer == null) {
      return false;
    }
    bool? ret;
    this._socketServer?.emitWithAck(
      'test',
      '${this._socketServer?.id}',
      ack: (response) => ret = response == 'OK'
    );
    ret = await Future.any([
      Future(() async {
        await Future.delayed(Duration(seconds: SOCKET_SERVER_CONNECTION_TEST_TIMEOUT_IN_SECONDS));
        return false;
      }),
      Future(() async {
        while (ret == null) {
          await Future.delayed(Duration(microseconds: 100));
        }
        return ret;
      }),
    ]);
    return ret ?? false;
  }

  void _serverSafetyChecks() {
    if (!this._isConnectedToServer) {
      this.connectSocket();
    }
  }

  Future<String?> queryCommand(String command) async {
    this._serverSafetyChecks();
    if (this._socketServer == null || !this._isConnectedToServer) {
      return null;
    }
    String? ret;
    this._socketServer?.emitWithAck(
        'query_command',
        command,
        ack: (response) => ret = response.toString()
    );
    bool exit = false;
    ret = await Future.any([
      Future(() async {
        await Future.delayed(Duration(seconds: SOCKET_SERVER_CONNECTION_TEST_TIMEOUT_IN_SECONDS));
        return null;
      }),
      Future(() async {
        while (ret == null && !exit) {
          await Future.delayed(Duration(microseconds: 100));
        }
        return ret;
      }),
    ]);
    exit = true;
    return ret == 'KO' ? null : ret;
  }
}