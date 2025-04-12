import 'package:flutter/material.dart';
import 'package:flutter_proj/Home_Screen.dart';
import 'package:flutter_proj/Stats.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatefulWidget{
  State<QRScannerPage> createState()=>_QRScannerPage();
}

class _QRScannerPage extends State<QRScannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height/3,
              width: MediaQuery.of(context).size.width/2-40,
              child:MobileScanner(
              onDetect: (barcodeCapture) {
                final Barcode? barcode = barcodeCapture.barcodes.first;
                if (barcode != null && barcode.rawValue != null) {
                  final scannedData = barcode.rawValue!;
                  if (scannedData is String){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Stats(str: scannedData.toString(),),
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home_Screen(),
                      ),
                    );
                  }
                }
              },
            ),
            ),
          )
        ],
      ),
    );
  }
}
