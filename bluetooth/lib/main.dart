import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluetooth App',
      home: BluetoothScreen(),
    );
  }
}

class BluetoothScreen extends StatefulWidget {
  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<ScanResult> scanResults = [];
  bool isScanning = false;

  @override
  void initState() {
    super.initState();
    _startScan();
  }

  void _startScan() {
    setState(() {
      isScanning = true;
    });

    flutterBlue.startScan(timeout: Duration(seconds: 4)).then((_) {
      setState(() {
        isScanning = false;
      });
    });

    flutterBlue.scanResults.listen((results) {
      setState(() {
        scanResults = results;
      });
    });
  }

  void _stopScan() {
    flutterBlue.stopScan();
    setState(() {
      isScanning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Devices'),
        actions: [
          isScanning
              ? IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: _stopScan,
                )
              : IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: _startScan,
                )
        ],
      ),
      body: scanResults.isEmpty
          ? Center(child: Text('No devices found'))
          : ListView.builder(
              itemCount: scanResults.length,
              itemBuilder: (BuildContext context, int index) {
                ScanResult result = scanResults[index];
                BluetoothDevice device = result.device;
                return ListTile(
                  title: Text(device.name.isEmpty ? 'Unknown Device' : device.name),
                  subtitle: Text(device.id.toString()),
                );
              },
            ),
    );
  }
}
