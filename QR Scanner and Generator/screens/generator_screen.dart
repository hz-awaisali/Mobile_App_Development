import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class GeneratorScreen extends StatefulWidget {
  const GeneratorScreen({super.key});

  @override
  State<GeneratorScreen> createState() => _GeneratorScreenState();
}

class _GeneratorScreenState extends State<GeneratorScreen> {
  final TextEditingController _textController = TextEditingController();
  String _qrData = '';
  final GlobalKey _qrKey = GlobalKey();
  bool _showQR = false;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _captureAndShareQR() async {
    try {
      // Get the render object
      final RenderRepaintBoundary boundary =
      _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      // Convert to image
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        // Convert to bytes
        final Uint8List pngBytes = byteData.buffer.asUint8List();

        // Get temporary directory
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/qr_code.png');

        // Write to file
        await file.writeAsBytes(pngBytes);

        // Share the file
        await Share.shareXFiles(
          [XFile(file.path)],
          text: 'QR Code for: $_qrData',
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error sharing QR code: $e"),
            backgroundColor: Colors.red,
          )
      );
    }
  }

  Future<void> _copyQRDataToClipboard() async {
    await Clipboard.setData(ClipboardData(text: _qrData));
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("QR code data copied to clipboard"),
          backgroundColor: Colors.green,
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate QR Code'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enter text or URL to generate QR code:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: 'Enter text or URL',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                minLines: 1,
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_textController.text.isNotEmpty) {
                    setState(() {
                      _qrData = _textController.text;
                      _showQR = true;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Generate QR Code',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 30),
              if (_showQR) ...[
                Center(
                  child: RepaintBoundary(
                    key: _qrKey,
                    child: QrImageView(
                      data: _qrData,
                      version: QrVersions.auto,
                      size: 250,
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(10),
                      // Remove or comment this if you don't have the asset
                      // embeddedImage: const AssetImage('assets/logo.png'),
                      // embeddedImageStyle: const QrEmbeddedImageStyle(
                      //   size: Size(50, 50),
                      // ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _captureAndShareQR,
                        icon: const Icon(Icons.share),
                        label: const Text('Share'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _copyQRDataToClipboard,
                        icon: const Icon(Icons.copy),
                        label: const Text('Copy Text'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}