import 'package:flutter/material.dart';
import 'package:hardwareders/core/cache/cache_manager.dart';
import 'package:provider/provider.dart';

import '../../../core/components/custom_elevated_button.dart';
import '../../../product/components/custom_card.dart';
import '../../login/model/user_model.dart';
import '../../login/view/login_page.dart';
import '../../login/viewmodel/login_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.userModel}) : super(key: key);
  final UserModel? userModel;
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final UserModel userModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userModel = widget.userModel!;
  }

  final String _appBarTitle = "AnaSayfa";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Text(
              'Welcome ${userModel.firstName}',
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.blueGrey),
            ),
            SizedBox(height: 30),
            BuildCard(
                title: "Name Surname",
                subtitle: '${userModel.firstName} ${userModel.lastName}'),
            BuildCard(title: 'Gender', subtitle: '${userModel.gender}'),
            BuildCard(title: 'Mail', subtitle: '${userModel.email}'),
            CustomElevatedButton(
              onPressed: () => onPressedLogOut(context),
              title: 'Çıkış Yap',
            )
          ],
        ),
      ),
    );
  }

  onPressedLogOut(BuildContext context) {
    CacheManager.deleteAll();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (_) => LoginViewModel(),
        child: const Login(),
      ),
    ));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(_appBarTitle),
      actions: [
        CircleAvatar(
          backgroundColor: Colors.black54,
          child: ClipOval(
            child: Image.network(userModel.image.toString()),
          ),
        )
      ],
    );
  }
}
