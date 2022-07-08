import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:rekrutacja/barcode.dart';

import 'boxes.dart';

class BarCodeScanner extends StatefulWidget {
  const BarCodeScanner({Key? key}) : super(key: key);

  @override
  State<BarCodeScanner> createState() => _BarCodeScannerState();
}

class _BarCodeScannerState extends State<BarCodeScanner> {
  String? _qrInfo = 'Scan a QR/Bar code';
  bool _camState = false;

  Future addBarCode(String barCodeValue) async {
    final date = DateTime.now();
    String formatedDate = DateFormat('dd-MM-yyyy - kk:mm').format(date);
    final barCode = BarCode(barCodeValue: barCodeValue, scanDate: formatedDate);
    final box = Boxes.getCodes();
    box.add(barCode);
  }

  _qrCallback(String? code) {
    setState(() {
      _camState = false;
      _qrInfo = code;
    });
  }

  _scanCode() {
    setState(() {
      _camState = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _scanCode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = 280;
    return Scaffold(
      appBar: AppBar(
        title: Text('Scann'),
      ),
      body: _camState
          ? Center(
              child: SizedBox(
                height: 1000,
                width: 500,
                child: QRBarScannerCamera(
                  onError: (context, error) => Text(
                    error.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                  qrCodeCallback: (code) {
                    _qrCallback(code);
                  },
                ),
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _qrInfo!,
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: buttonWidth,
                      child: TextButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                          onPressed: () {
                            addBarCode(_qrInfo!);
                            _scanCode();
                          },
                          child: Text(
                            'Zapisz kod',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: buttonWidth,
                      child: TextButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                          onPressed: () {
                            addBarCode(_qrInfo!);
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Zapisz kod i wyjdź',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: buttonWidth,
                      child: TextButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                          onPressed: () {
                            _scanCode();
                          },
                          child: Text(
                            'Dodaj nowy kod',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          )),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
