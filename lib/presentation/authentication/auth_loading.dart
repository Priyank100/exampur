import 'package:exampur_mobile/presentation/authentication/sign_in.dart';
import 'package:exampur_mobile/presentation/home/bottom_navigation.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthLoading extends StatefulWidget {
  @override
  _AuthLoadingState createState() => _AuthLoadingState();
}

class _AuthLoadingState extends State<AuthLoading> {
  bool _userSignedIn = false;
  bool _loading = true;
  String pho = "";

  fetchSession() async {
    String url = 'https://auth.exampur.xyz/user';
    }


  }

  @override
  initState() {
    super.initState();
    fetchSession();
  }

  Widget build(BuildContext context) {
    return _loading
        ? LoadingIndicator(context)
        : _userSignedIn
            ? BottomNavigation()
            : SignIn();
  }
}
