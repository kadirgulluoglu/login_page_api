import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/init/theme/theme.dart';
import 'screen/login/view/login_page.dart';
import 'screen/login/viewmodel/login_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeLight().theme,
      home: ChangeNotifierProvider(
        create: (_) => LoginViewModel(),
        child: const Login(),
      ),
    );
  }
}
