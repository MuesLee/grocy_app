import 'dart:async';

import 'package:flutter/material.dart';
import 'package:preferences/preference_page.dart';
import 'package:preferences/preferences.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;

class Configuration extends StatefulWidget {
  @override
  _ConfigurationState createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  final RoundedLoadingButtonController _grocyTestBtnController = new RoundedLoadingButtonController();
  final RoundedLoadingButtonController _bbuddyBtnController = new RoundedLoadingButtonController();

  _persistSetting(String key, String value) {
    PrefService.setString(key, value);
  }

  void _testApiConnection(BuildContext context, String baseUrl, String apiKey, String authHeader, RoundedLoadingButtonController buttonController) async {
    final url = '$baseUrl/api/system/info';

    try {
      final response = await http.get(url, headers: {authHeader: apiKey});

      if (response.statusCode == 200) {
        buttonController.success();
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Success! HTTP Status ${response.statusCode.toString()}.')));
      } else {
        buttonController.error();
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('HTTP Error ${response.statusCode.toString()}.')));
        Timer(Duration(seconds: 3), () => buttonController.reset());
      }
    } catch(error) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: Key('configuration'),
        appBar: AppBar(
          title: Center(child: Text("Configuration")),
        ),
        body:
          Builder(
            builder: (BuildContext context) {
              return PreferencePage([
                Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Text('Grocy Settings', style: TextStyle(fontWeight: FontWeight.bold))
                ),
                TextFieldPreference(
                  'Grocy Server URL',
                  'grocy_server_url',
                  onChange: (String value) {
                    _persistSetting('grocy_server_url', value);
                  },
                ),
                TextFieldPreference(
                  'Grocy API Key',
                  'grocy_api_key',
                  onChange: (String value) {
                    _persistSetting('grocy_api_key', value);
                  },
                ),
                RoundedLoadingButton(
                  child: Text(
                    'Test Connection',
                    style: TextStyle(color: Colors.white),
                  ),
                  controller: _grocyTestBtnController,
                  color: Colors.deepPurple,
                  onPressed: () => _testApiConnection(
                    context,
                    PrefService.getString('grocy_server_url'),
                    PrefService.getString('grocy_api_key'),
                    'GROCY-API-KEY',
                    _grocyTestBtnController
                  )
                ),
                Divider(
                  color: Colors.deepPurple,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text('Barcode Buddy Settings', style: TextStyle(fontWeight: FontWeight.bold))
                ),
                TextFieldPreference(
                  'Barcode Buddy URL',
                  'bbuddy_server_url',
                  onChange: (String value) {
                    _persistSetting('bbuddy_server_url', value);
                  }
                ),
                TextFieldPreference(
                  'Barcode Buddy API Key',
                  'bbuddy_api_key',
                  onChange: (String value) {
                    _persistSetting('bbuddy_api_key', value);
                  }
                ),
                RoundedLoadingButton(
                  child: Text(
                    'Test Connection',
                    style: TextStyle(color: Colors.white),
                  ),
                  controller: _bbuddyBtnController,
                  color: Colors.deepPurple,
                  onPressed: () => _testApiConnection(
                      context,
                      PrefService.getString('bbuddy_server_url'),
                      PrefService.getString('bbuddy_api_key'),
                      'BBUDDY-API-KEY',
                      _bbuddyBtnController
                  ),
                )
              ]);
            }
          )

    );
  }

  void onButtonPress() {
    Navigator.pushReplacementNamed(context, "home");
  }
}
