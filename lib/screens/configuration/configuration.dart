import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grocy_app/screens/configuration/json/bbuddy/bbuddy_system_info.dart';
import 'package:grocy_app/screens/configuration/json/grocy/grocy_system_info.dart';
import 'package:grocy_app/screens/home.dart';
import 'package:preferences/preference_page.dart';
import 'package:preferences/preferences.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;

class Configuration extends StatefulWidget {
  @override
  _ConfigurationState createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  final RoundedLoadingButtonController _grocyTestBtnController =
      new RoundedLoadingButtonController();
  final RoundedLoadingButtonController _bbuddyBtnController =
      new RoundedLoadingButtonController();
  GrocySystemInfo _grocySystemInfo;
  BbuddySystemInfo _bbuddySystemInfo;

  _ConfigurationState() {
    if (PrefService.getString('grocy_system_info') != null)
      _grocySystemInfo = GrocySystemInfo.fromJson(jsonDecode(PrefService.getString('grocy_system_info')));

    if (PrefService.getString('bbuddy_system_info') != null)
      _bbuddySystemInfo = BbuddySystemInfo.fromJson(jsonDecode(PrefService.getString('bbuddy_system_info')));
  }

  void _persistSetting(String key, String value) {
    PrefService.setString(key, value);
  }

  void _testApiConnection(
      BuildContext context,
      String baseUrl,
      String apiKey,
      String authHeader,
      RoundedLoadingButtonController buttonController) async {
    final url = '$baseUrl/api/system/info';

    try {
      final response = await http.get(url, headers: {authHeader: apiKey});

      if (response.statusCode == 200) {
        buttonController.success();
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
                'Success! HTTP Status ${response.statusCode.toString()}.')));

        _setSystemInfo(authHeader, response.body);
      } else {
        buttonController.error();
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('HTTP Error ${response.statusCode.toString()}.')));

        Timer(Duration(seconds: 3), () => buttonController.reset());
      }
    } on HttpException catch (error) {
      throw error;
    }
  }

  _setSystemInfo(String authHeader, String data) {
    // Zu müde um mir was besseres auszudenken die Responses zu unterscheiden
    switch (authHeader) {
      // Und die ganzen Strings müssen auch irgendwo hin... (TODO)
      case 'GROCY-API-KEY':
        _persistSetting('grocy_system_info', data);

        setState(() {
          _grocySystemInfo = GrocySystemInfo.fromJson(jsonDecode(data));
        });
        break;
      case 'BBUDDY-API-KEY':
        setState(() {
          _persistSetting('bbuddy_system_info', data);

          _bbuddySystemInfo = BbuddySystemInfo.fromJson(jsonDecode(data));
        });
        break;
    }
  }

  void _pushHomeRoute(context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: Key('configuration'),
        appBar: AppBar(
          title: Center(child: Text("Configuration")),
          actions: <Widget>[
            if (!Navigator.canPop(context)) IconButton(
              icon: Icon(Icons.close),
              onPressed: (_grocySystemInfo != null && _bbuddySystemInfo != null)
                  ? () => _pushHomeRoute(context)
                  : null,
            )
          ],
        ),
        body: Builder(builder: (BuildContext context) {
          return PreferencePage([
            PreferencePageLink(
              'Grocy Settings',
              leading: _grocySystemInfo != null ? Icon(Icons.cloud_done, color: Colors.green) : Icon(Icons.cloud),
              trailing: Icon(Icons.keyboard_arrow_right),
              desc: _grocySystemInfo != null ? 'Connected to Grocy ${_grocySystemInfo.grocyVersion.version}' : null,
              page: PreferencePage([
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
                        _grocyTestBtnController)),
                if (_grocySystemInfo != null) Card(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                  elevation: 5,
                  child: ListBody(
                    children: <Widget>[
                      ListTile(
                          title: Text('${_grocySystemInfo.grocyVersion?.version}, released ${_grocySystemInfo.grocyVersion?.releaseDate}'),
                          subtitle: Text('Grocy Version')),
                      ListTile(
                          title: Text(_grocySystemInfo.phpVersion),
                          subtitle: Text('PHP Version')),
                      ListTile(
                          title: Text(_grocySystemInfo.sqLiteVersion),
                          subtitle: Text('PHP Version')),
                    ],
                  ),
                ),
              ])
            ),
            PreferencePageLink(
              'Barcode Buddy Settings',
              leading: _bbuddySystemInfo != null ? Icon(Icons.cloud_done, color: Colors.green) : Icon(Icons.cloud),
              trailing: Icon(Icons.keyboard_arrow_right),
              desc: _bbuddySystemInfo != null ? 'Connected to Barcode Buddy ${_bbuddySystemInfo.data.version}' : null,
              page: PreferencePage([
                TextFieldPreference('Barcode Buddy URL', 'bbuddy_server_url',
                    onChange: (String value) {
                      _persistSetting('bbuddy_server_url', value);
                    }),
                TextFieldPreference('Barcode Buddy API Key', 'bbuddy_api_key',
                    onChange: (String value) {
                      _persistSetting('bbuddy_api_key', value);
                    }),
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
                      _bbuddyBtnController),
                ),
                if (_bbuddySystemInfo?.data?.version != null) Card(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                  elevation: 5,
                  child: ListTile(
                    title: Text(_bbuddySystemInfo?.data?.version),
                    subtitle: Text('Barcode Buddy Version'),
                  ),
                )
              ])
            ),
          ]);
        }));
  }

  void onButtonPress() {
    Navigator.pushReplacementNamed(context, "home");
  }
}
