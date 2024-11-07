import 'package:emenu/models/setting.dart';
import 'package:emenu/repositories/connection_repository.dart';
import 'package:emenu/utils/global.dart';
import 'package:emenu/utils/settings.dart';
import 'package:flutter/material.dart';

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
  final _isCashierController = TextEditingController();
  final _typeController = TextEditingController();
  final _sectionController = TextEditingController();

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
    _isCashierController.dispose();
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
    _isCashierController.text = setting.isCashier;
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      // Perform registration logic

      var setting = Setting(
          serverIP: _serverIpController.text,
          posGroup: _posGroupController.text,
          posId: _posIdController.text,
          type: _typeController.text,
          storeNo: _storeNoController.text,
          vat: _vatController.text,
          isCashier: _isCashierController.text);
      var settings = Settings();
      await settings.write(setting);

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Save Successful')),
        );
    }
  }

  void _testConnection() async {
    var serverIp = _serverIpController.text;
    bool isConnected = await _connectionRepository.checkConnection(Global.serviceUrl(serverIp));

    String message = isConnected ? 'Connection Successful' : 'Connection unsuccessful';
    ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(message)),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _serverIpController,
                decoration: const InputDecoration(labelText: 'Server IP'),
                validator: (value) {
                  return null;
                },
              ),
               TextFormField(
                controller: _storeNoController,
                decoration: const InputDecoration(labelText: 'StoreNo'),
                validator: (value) {
                  return null;
                },
              ),
              TextFormField(
                controller: _posGroupController,
                decoration: const InputDecoration(labelText: 'POS Group'),
                validator: (value) {
                  return null;
                },
              ),
              TextFormField(
                controller: _posIdController,
                decoration: const InputDecoration(labelText: 'POS ID'),
                validator: (value) {
                  return null;
                },
              ),
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'Type'),
                validator: (value) {
                  return null;
                },
              ),
              TextFormField(
                controller: _vatController,
                decoration: const InputDecoration(labelText: 'VAT'),
                validator: (value) {
                  return null;
                },
              ),
              TextFormField(
                controller: _isCashierController,
                decoration: const InputDecoration(labelText: 'Cashier'),
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
                  const SizedBox(width: 10,),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _save,
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
