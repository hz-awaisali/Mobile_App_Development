import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanResultDialog extends StatelessWidget {
  final String scannedValue;
  final VoidCallback onClose;

  const ScanResultDialog({
    super.key,
    required this.scannedValue,
    required this.onClose,
  });

  bool _isUrl(String text) {
    return text.startsWith('http://') || 
           text.startsWith('https://') || 
           text.startsWith('www.');
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url.startsWith('www.') ? 'https://$url' : url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isUrl = _isUrl(scannedValue);

    return AlertDialog(
      title: const Text(
        'Scan Result',
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: SelectableText(
              scannedValue,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: scannedValue));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Copied to clipboard'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                icon: const Icon(Icons.copy),
                label: const Text('Copy'),
              ),
              if (isUrl)
                TextButton.icon(
                  onPressed: () => _launchUrl(scannedValue),
                  icon: const Icon(Icons.open_in_browser),
                  label: const Text('Open'),
                ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onClose,
          child: const Text('Close'),
        ),
      ],
    );
  }
}