import 'package:emenu/config/themes/app_text_styles.dart';
import 'package:emenu/main.dart';
import 'package:emenu/models/setting.dart';
import 'package:emenu/modules/auth/bloc/login_bloc.dart';
import 'package:emenu/repositories/connection_repository.dart';
import 'package:emenu/utils/global.dart';
import 'package:emenu/utils/screen_util.dart';
import 'package:emenu/utils/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final _formKey = GlobalKey<FormState>();

  final _serverIpController = TextEditingController();
  final _storeNoController = TextEditingController();
  final _posGroupController = TextEditingController();
  final _posIdController = TextEditingController();
  final _vatController = TextEditingController();
  final _exitModeController = TextEditingController();
  final _typeController = TextEditingController();
  final _sectionController = TextEditingController();
  final _passwordController = TextEditingController();
  final _logoNameController = TextEditingController();

  final _connectionRepository = ConnectionRepository();

  late final Setting setting;

  @override
  void dispose() {
    _serverIpController.dispose();
    _posGroupController.dispose();
    _posIdController.dispose();
    _typeController.dispose();
    _sectionController.dispose();
    _storeNoController.dispose();
    _vatController.dispose();
    _exitModeController.dispose();
    _passwordController.dispose();
    _logoNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getSettings();
    });
  }

  _getSettings() async {
    var settings = Settings();
    setting = await settings.read();
    _serverIpController.text = setting.serverIP;
    _posGroupController.text = setting.posGroup;
    _posIdController.text = setting.posId;
    _typeController.text = setting.type;
    _storeNoController.text = setting.storeNo;
    _vatController.text = setting.vat;
    _exitModeController.text = setting.exitMode;
    _logoNameController.text = setting.logoName;
  }

  void _save(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Perform registration logic

      var setting = Setting(
          serverIP: _serverIpController.text,
          posGroup: _posGroupController.text,
          posId: _posIdController.text,
          type: _typeController.text,
          storeNo: _storeNoController.text,
          vat: _vatController.text,
          exitMode: _exitModeController.text,
          logoName: _logoNameController.text);
      var settings = Settings();
      await settings.write(setting);

      _passwordController.text = "";

      context.read<LoginBloc>().add(const RefreshLogo());

      Navigator.of(context).pop();

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Save Successful')),
        );
    }
  }

  void _testConnection() async {
    var serverIp = _serverIpController.text;
    bool isConnected = await _connectionRepository
        .checkConnection(Global.serviceUrl(serverIp));

    String message = isConnected ? 'Connection OK' : 'Connection FAILED';
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 4;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        child: Padding(
          padding: EdgeInsets.only(left: width, right: width, top: 20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  controller: _serverIpController,
                  decoration: const InputDecoration(
                    labelText: 'Server IP',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _storeNoController,
                  decoration: const InputDecoration(
                    labelText: 'StoreNo',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _posGroupController,
                  decoration: const InputDecoration(
                    labelText: 'POS Group',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _posIdController,
                  decoration: const InputDecoration(
                    labelText: 'POS ID',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _typeController,
                  decoration: const InputDecoration(
                    labelText: 'Type',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _vatController,
                  decoration: const InputDecoration(
                    labelText: 'VAT',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _exitModeController,
                  decoration: const InputDecoration(
                    labelText: 'Exit Mode',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _logoNameController,
                  decoration: const InputDecoration(
                    labelText: 'Logo',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _testConnection,
                        child: const Text('Test Connection'),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          _showCustomDialog(context);
                        },
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCustomDialog(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      useRootNavigator: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5, // Custom width
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Password',
                  style: AppTextStyles.dialogTitle,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        if (_passwordController.text ==
                            ScreenUtil.getCurrentDate('ddMMyy')) {
                          _save(context);
                        } else {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              const SnackBar(content: Text('Invalid password')),
                            );
                        }
                      },
                      child: const Text('OK'),
                    )),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
