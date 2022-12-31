import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LicensesPage extends StatefulWidget {
  const LicensesPage({super.key});

  @override
  State<LicensesPage> createState() => _LicensesPageState();
}

class _LicensesPageState extends State<LicensesPage> {
  List<List<String>> licenses = [];

  @override
  void initState() {
    super.initState();
    LicenseRegistry.licenses.listen((license) {
      final packages = license.packages.toList();
      final paragraphs = license.paragraphs.toList();
      final packageName = packages.map((e) => e).join('');
      final paragraphText = paragraphs.map((e) => e.text).join('\n');
      licenses.add([packageName, paragraphText]);
      setState(() => licenses = licenses);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ライセンス'),
      ),
      body: ListView.builder(
        itemCount: licenses.length,
        itemBuilder: (context, index) {
          final license = licenses[index];
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  license[0],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  license[1],
                  style: const TextStyle(fontSize: 12),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
