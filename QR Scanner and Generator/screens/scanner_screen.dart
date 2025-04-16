import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../widgets/scan_result_dialog.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController cameraController = MobileScannerController();
  bool _torchOn = false;
  bool _scanning = true;

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        actions: [
          IconButton(
            icon: Icon(_torchOn ? Icons.flash_on : Icons.flash_off),
            onPressed: () async {
              await cameraController.toggleTorch();
              setState(() {
                _torchOn = !_torchOn;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                MobileScanner(
                  controller: cameraController,
                  onDetect: (capture) {
                    if (!_scanning) return;
                    
                    final List<Barcode> barcodes = capture.barcodes;
                    if (barcodes.isNotEmpty) {
                      final String code = barcodes.first.rawValue ?? 'Unknown';
                      setState(() {
                        _scanning = false;
                      });
                      
                      showDialog(
                        context: context,
                        builder: (context) => ScanResultDialog(
                          scannedValue: code,
                          onClose: () {
                            Navigator.pop(context);
                            setState(() {
                              _scanning = true;
                            });
                          },
                        ),
                      );
                    }
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: 250,
                  height: 250,
                ),
              ],
            ),
          ),
          Container(
            color: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 16),
            width: double.infinity,
            child: const Text(
              'Align QR code within the frame',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}