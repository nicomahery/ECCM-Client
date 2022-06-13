import 'package:eccm_client/pages/home_page.dart';
import 'package:eccm_client/services/api_service.dart';
import 'package:eccm_client/services/config_service.dart';
import 'package:eccm_client/services/socket_service.dart';
import 'package:eccm_client/utils/get_it_instance.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);
  static const String PATH = '/setting';
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final ApiService _apiService = locator<ApiService>();
  final SocketService _socketService = locator<SocketService>();
  final ConfigService _configService = locator<ConfigService>();
  Color? _apiConnectionStatusColor = Colors.grey;
  Color? _socketConnectionStatusColor = Colors.grey;
  final _apiFormKey = GlobalKey<FormState>();
  final _socketFormKey = GlobalKey<FormState>();
  final TextEditingController _apiLocationController = TextEditingController();
  final TextEditingController _apiSecretHeaderController = TextEditingController();
  final TextEditingController _apiSecretController = TextEditingController();
  final TextEditingController _socketServerLocationController = TextEditingController();
  final TextEditingController _socketSecretController = TextEditingController();


  @override
  void initState() {
    super.initState();
    if (this._configService.apiLocation != null) {
      this._apiLocationController.text = this._configService.apiLocation!;
    }
    if (this._configService.apiSecretHeader != null) {
      this._apiSecretHeaderController.text = this._configService.apiSecretHeader!;
    }
    if (this._configService.apiSecret != null) {
      this._apiSecretController.text = this._configService.apiSecret!;
    }
    if (this._configService.webSocketServerLocation != null) {
      this._socketServerLocationController.text = this._configService.webSocketServerLocation!;
    }
    if (this._configService.webSocketServerSecret != null) {
      this._socketSecretController.text = this._configService.webSocketServerSecret!;
    }
  }

  Future<bool> _validateAPIConnection() async {
    if (this._apiFormKey.currentState!.validate()) {
      this._configService.apiLocation = this._apiLocationController.value.text;
      this._configService.apiSecretHeader = this._apiSecretHeaderController.value.text;
      this._configService.apiSecret = this._apiSecretController.value.text;
      bool isTestSuccessful = await this._apiService.ping();
      this._apiConnectionStatusColor = isTestSuccessful ? Colors.green: Colors.red;
      if (this.mounted) {
        setState(() {});
      }
      return isTestSuccessful;
    }
    return false;
  }

  Future<bool> _validateSocketConnection() async {
    if (this._socketFormKey.currentState!.validate()) {
      this._socketService.disconnectSocket();
      this._configService.webSocketServerLocation = this._socketServerLocationController.value.text;
      this._configService.webSocketServerSecret = this._socketSecretController.value.text;
      this._socketService.connectSocket();
      bool isTestSuccessful = await this._socketService.testConnection();
      this._socketConnectionStatusColor = isTestSuccessful ? Colors.green : Colors.red;
      if (this.mounted) {
        setState(() {});
      }
      return isTestSuccessful;
    }
    return false;
  }


  @override
  void dispose() {
    this._apiLocationController.dispose();
    this._apiSecretHeaderController.dispose();
    this._apiSecretController.dispose();
    this._socketServerLocationController.dispose();
    this._socketSecretController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Setting'),
        actions: [
          IconButton(
              onPressed: () async {

                List<bool> results = await Future.wait([
                  this._validateAPIConnection(),
                  this._validateSocketConnection()
                ]);
                if (this.mounted) {
                  setState(() {});
                }
                if (results.first) {
                  this._configService.saveParametersToPreferences();
                  await Future.delayed(Duration(milliseconds: 1500));
                  context.go(HomePage.PATH);
                }
              },
              icon: const Icon(Icons.check),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: height * 0.05),
                width: width * 0.8,
                child: Form(
                  key: _apiFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'API Settings (used for trip summary)',
                        style: TextStyle(
                            color: this._apiConnectionStatusColor,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.02),
                        child: TextFormField(
                          validator: (value) => this._validateField(value),
                          controller: this._apiLocationController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.link),
                            hintText: 'example.com',
                            labelText: 'API Location *',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.012),
                        child: TextFormField(
                          validator: (value) => this._validateField(value),
                          controller: this._apiSecretHeaderController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.short_text),
                            labelText: 'Secret header *',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.012),
                        child: TextFormField(
                          obscureText: true,
                          validator: (value) => this._validateField(value),
                          controller: this._apiSecretController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.key),
                            labelText: 'Secret value *',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: height * 0.05),
                width: width * 0.8,
                child: Form(
                  key: _socketFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Socket Settings (used for live data)',
                        style: TextStyle(
                            color: this._socketConnectionStatusColor,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.02),
                        child: TextFormField(
                          validator: (value) => this._validateField(value),
                          controller: this._socketServerLocationController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.link),
                            hintText: 'example.com',
                            labelText: 'Socket Server Location',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.012),
                        child: TextFormField(
                          obscureText: true,
                          validator: (value) => this._validateField(value),
                          controller: this._socketSecretController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.key),
                            labelText: 'Socket Server Secret value',

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }

  String? _validateField(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }
}
