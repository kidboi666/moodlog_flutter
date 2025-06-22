import 'package:flutter/material.dart';

class EntriesScreen extends StatelessWidget {
  const EntriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            color: Colors.amber,
            child: ListTile(
              title: Text("Hello World"),
              subtitle: Text("Hello World"),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            color: Colors.orange,
            child: ListTile(
              title: Text("Hello World"),
              subtitle: Text("Hello World"),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            color: Colors.green,
            child: ListTile(
              title: Text("Hello World"),
              subtitle: Text("Hello World"),
            ),
          ),
        ],
      ),
    );
  }
}
