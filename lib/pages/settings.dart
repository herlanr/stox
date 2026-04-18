import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Settings()),
    );
  }
}

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool light = true;

  @override
  Widget build(BuildContext context) {

    //scrollbare list of widgets
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.dark_mode),
          title: const Text("Dark Mode"),
          trailing: Switch(
            value: light,
            onChanged: (value) {
              setState(() {
                light = value;
                //todo func aufrufen
              });
            },
          ),
        ),
      ],
    );
  }
}