import 'package:flutter/material.dart';
import 'package:meseros_app/shared_preferences/preference.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              TextFormField(
                initialValue: Preferences.ipServer,
                onChanged: (value) {
                  Preferences.ipServer = value;
                  setState(() {});
                },
                decoration: const InputDecoration(
                  label: Text('IP DB'),
                ),
              ),
              TextFormField(
                initialValue: Preferences.port,
                onChanged: (value) {
                  Preferences.port = value;
                  setState(() {});
                },
                decoration: const InputDecoration(
                  label: Text('PORT'),
                ),
              )
            ],
          ),
        )));
  }
}