import 'package:flutter/material.dart';
import 'package:flutter_proj/Home_Screen.dart';
import 'package:flutter_proj/Stats.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatefulWidget {
  @override
  State<QRScannerPage> createState() => _QRScannerPage();
}

class _QRScannerPage extends State<QRScannerPage> {
  bool isScanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.cancel,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'QR Scanner',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                ),
                child: MobileScanner(
                  onDetect: (barcodeCapture) {
                    if (isScanned) return;

                    final Barcode? barcode = barcodeCapture.barcodes.first;
                    if (barcode != null && barcode.rawValue != null) {
                      final scannedData = barcode.rawValue!;

                      setState(() {
                        isScanned = true;
                      });

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Stats(str: scannedData),
                        ),
                      );
                    } else {
                      setState(() {
                        isScanned = true;
                      });

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home_Screen(),
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Scan the QR code to see your friend's stats",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
