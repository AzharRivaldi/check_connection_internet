import 'package:check_connection_internet/utils/network_connection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map _source = {ConnectivityResult.none: false};
  final NetworkConnection _connectivity = NetworkConnection.instance;
  String _signal = "red";
  String _status = "";

  @override
  void initState() {
    super.initState();

    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.mobile:
        _signal = "green";
        _status = "Connected";
        break;
      case ConnectivityResult.wifi:
        _signal = "green";
        _status = "Connected";
        break;
      case ConnectivityResult.none:
      default:
        _signal = "red";
        _status = "Not Connected";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: _signal == "green" ? Colors.green : Colors.red),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              _status.toString(),
              style: const TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
