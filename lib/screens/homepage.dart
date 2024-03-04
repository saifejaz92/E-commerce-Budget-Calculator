import 'package:budget_app/screens/product_pricing.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2c2c2a),
        centerTitle: true,
        title: const Text(
          "E-Com Budget Calculator",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ProductPricing(),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  )),
              TextButton(
                  onPressed: () {
                    const link = "https://softoof.com/";
                    launchUrl(
                      Uri.parse(link),
                      mode: LaunchMode.inAppWebView,
                    );
                  },
                  child: const Text("Developed By Softoof Solutions."))
            ],
          ),
        ),
      ),
    );
  }
}
