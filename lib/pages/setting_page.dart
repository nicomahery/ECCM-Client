import 'package:eccm_client/pages/home_page.dart';
import 'package:eccm_client/services/api_service.dart';
import 'package:eccm_client/services/config_service.dart';
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
  final ConfigService _configService = locator<ConfigService>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _apiLocationController = TextEditingController();
  final TextEditingController _apiSecretHeaderController = TextEditingController();
  final TextEditingController _apiSecretController = TextEditingController();


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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Setting'),
        actions: [
          IconButton(
              onPressed: () async {

                if (_formKey.currentState!.validate()) {
                  this._configService.apiLocation = this._apiLocationController.value.text;
                  this._configService.apiSecretHeader = this._apiSecretHeaderController.value.text;
                  this._configService.apiSecret = this._apiSecretController.value.text;
                  if (await this._apiService.ping()) {
                    this._configService.saveParametersToPreferences();
                    context.go(HomePage.PATH);
                  }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('API not working')));
                  }
                }
              },
              icon: const Icon(Icons.check)
          )
        ],
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                validator: (value) => this._validateField(value),
                controller: this._apiLocationController,
              ),
              TextFormField(
                validator: (value) => this._validateField(value),
                controller: this._apiSecretHeaderController,
              ),
              TextFormField(
                validator: (value) => this._validateField(value),
                controller: this._apiSecretController,
              ),
            ],
          ),
        )
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
