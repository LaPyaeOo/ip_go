import 'package:flutter/material.dart';
import 'package:ip_go/ip_go.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String privateAddress = 'Loading...';
  String publicAddress = 'Loading...';

  @override
  void initState() {
    super.initState();
    _getIPAddresses();
  }

  Future<void> _getIPAddresses() async {
    final privateIp = await IpGo.privateIp;
    final publicIp = await IpGo.publicIp;

    setState(() {
      privateAddress = privateIp ?? 'Unknown';
      publicAddress = publicIp ?? 'Unknown';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('IP Addresses')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Privat IP: $privateAddress'),
              Text('Public IP: $publicAddress'),
            ],
          ),
        ),
      ),
    );
  }
}
