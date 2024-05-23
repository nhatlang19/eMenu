import 'package:emenu/models/setting.dart';
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
  final _typeController = TextEditingController();
  final _serviceTaxController = TextEditingController();
  final _sectionController = TextEditingController();

  late final Setting setting;

  @override
  void dispose() {
    _serverIpController.dispose();
    _storeNoController.dispose();
    _posGroupController.dispose();
    _posIdController.dispose();
    _vatController.dispose();
    _typeController.dispose();
    _serviceTaxController.dispose();
    _sectionController.dispose();
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
    _storeNoController.text = setting.storeNo;
    _posGroupController.text = setting.posGroup;
    _posIdController.text = setting.posId;
    _vatController.text = setting.vat;
    _typeController.text = setting.type;
    _serviceTaxController.text = setting.serviceTax;
    _sectionController.text = setting.section;
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      // Perform registration logic

      var setting = Setting(
          serverIP: _serverIpController.text,
          storeNo: _storeNoController.text,
          posGroup: _posGroupController.text,
          posId: _posIdController.text,
          vat: _vatController.text,
          type: _typeController.text,
          serviceTax: _serviceTaxController.text,
          section: _sectionController.text);
      var settings = Settings();
      await settings.write(setting);

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Save Successful')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _serverIpController,
                decoration: InputDecoration(labelText: 'Server IP'),
                validator: (value) {
                  return null;
                },
              ),
              TextFormField(
                controller: _storeNoController,
                decoration: InputDecoration(labelText: 'Store No'),
                validator: (value) {
                  return null;
                },
              ),
              TextFormField(
                controller: _posGroupController,
                decoration: InputDecoration(labelText: 'POS Group'),
                obscureText: true,
                validator: (value) {
                  return null;
                },
              ),
              TextFormField(
                controller: _posIdController,
                decoration: InputDecoration(labelText: 'POS ID'),
                validator: (value) {
                  return null;
                },
              ),
              TextFormField(
                controller: _vatController,
                decoration: InputDecoration(labelText: 'VAT'),
                validator: (value) {
                  return null;
                },
              ),
              TextFormField(
                controller: _typeController,
                decoration: InputDecoration(labelText: 'Type'),
                validator: (value) {
                  return null;
                },
              ),
              TextFormField(
                controller: _serviceTaxController,
                decoration: InputDecoration(labelText: 'Service Tax'),
                obscureText: true,
                validator: (value) {
                  return null;
                },
              ),
              TextFormField(
                controller: _sectionController,
                decoration: InputDecoration(labelText: 'Section'),
                validator: (value) {
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _save,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
