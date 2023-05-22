import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class infoCard extends StatelessWidget {
  const infoCard({Key? key}) : super(key: key);

  urlLauncher(String url) async {
    try {
      await launchUrl(Uri.parse(url),
          mode: LaunchMode.externalNonBrowserApplication);
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black87,
      title: ClipRRect(
        borderRadius: BorderRadius.circular(65),
        child: Image.asset(
          height: 150,
          width: 150,
          // fit: BoxFit.cover,
          'assets/logo.png',
        ),
      ),
      content: SizedBox(
        height: 70,
        child: Column(
          children: [
            Text.rich(
              TextSpan(
                text: 'Made with ... ',
                style: const TextStyle(color: Colors.white),
                children: [
                  WidgetSpan(
                    child: Image.asset(
                      'assets/heart.png',
                      height: 20,
                      width: 20,
                    ),
                  ),
                  const TextSpan(
                      style: TextStyle(fontWeight: FontWeight.bold),
                      text: '  by SAHIL')
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => urlLauncher('https://github.com/shivin307'),
                  child: const Image(
                    height: 30,
                    image: AssetImage('assets/github1.png'),
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () => urlLauncher(
                      'https://www.linkedin.com/in/sahil-italiya-232124231'),
                  child: const Image(
                    height: 30,
                    image: AssetImage('assets/linkedin.png'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
