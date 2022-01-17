// import 'package:exampur_mobile/Localization/language_constrants.dart';
// import 'package:exampur_mobile/data/model/response/languagemodel.dart';
// import 'package:exampur_mobile/provider/locallization_provider.dart';
// import 'package:exampur_mobile/utils/appBar.dart';
// import 'package:exampur_mobile/utils/app_constants.dart';
// import 'package:exampur_mobile/utils/dimensions.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../main.dart';
//
// class SettingsScreen extends StatefulWidget {
//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }
//
// class _SettingsScreenState extends State<SettingsScreen> {
//   final GlobalKey<FormState> _key = GlobalKey<FormState>();
//   void _changeLanguage(Language language) async {
//     Locale _locale = await setLocale(language.languageCode);
//     MyApp.setLocale(context, _locale);
//   }
//
//   void _showSuccessDialog() {
//     showTimePicker(context: context, initialTime: TimeOfDay.now());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(getTranslated(context, 'home_page')!),
//         actions: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: DropdownButton<Language>(
//               underline: SizedBox(),
//               icon: Icon(
//                 Icons.language,
//                 color: Colors.white,
//               ),
//               onChanged: (Language? language) {
//                 _changeLanguage(language!);
//               },
//               items: Language.languageList()
//                   .map<DropdownMenuItem<Language>>(
//                     (e) => DropdownMenuItem<Language>(
//                   value: e,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: <Widget>[
//                       Text(
//                         e.flag,
//                         style: TextStyle(fontSize: 30),
//                       ),
//                       Text(e.name)
//                     ],
//                   ),
//                 ),
//               )
//                   .toList(),
//             ),
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: _drawerList(),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(20),
//
//       ),
//     );
//   }
//
//
//
//   Container _drawerList() {
//     TextStyle _textStyle = TextStyle(
//       color: Colors.white,
//       fontSize: 24,
//     );
//     return Container(
//       color: Theme.of(context).primaryColor,
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           DrawerHeader(
//             child: Container(
//               height: 100,
//               child: CircleAvatar(),
//             ),
//           ),
//           ListTile(
//             leading: Icon(
//               Icons.info,
//               color: Colors.white,
//               size: 30,
//             ),
//             title: Text(
//               getTranslated(context, 'about_us')!,
//               style: _textStyle,
//             ),
//             onTap: () {
//               // To close the Drawer
//               Navigator.pop(context);
//               // Navigating to About Page
//               //Navigator.pushNamed(context, aboutRoute);
//             },
//           ),
//           ListTile(
//             leading: Icon(
//               Icons.settings,
//               color: Colors.white,
//               size: 30,
//             ),
//             title: Text(
//               getTranslated(context, 'settings')!,
//               style: _textStyle,
//             ),
//             onTap: () {
//               // To close the Drawer
//               Navigator.pop(context);
//               // Navigating to About Page
//              // Navigator.pushNamed(context, settingsRoute);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }