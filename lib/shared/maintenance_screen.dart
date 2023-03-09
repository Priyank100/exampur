import 'package:flutter/material.dart';
import '../utils/images.dart';

class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({Key? key}) : super(key: key);

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Images.maintenanceImg),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                  'Our App is currently undergoing scheduled maintenance. We should be back shortly. Thank you for your patience.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
