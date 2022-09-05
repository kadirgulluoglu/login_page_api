import 'package:flutter/material.dart';
import 'package:hardwareders/core/enum/state_enum.dart';
import 'package:provider/provider.dart';
import '../../../core/components/custom_elevated_button.dart';
import '../../../core/init/theme/theme.dart';
import '../../home/view/home_page.dart';
import '../viewmodel/login_viewmodel.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  //editingcontroller
  late final TextEditingController _emailcontroller;
  late final TextEditingController _passwordcontroller;

  final String _titleLogin = 'Giriş Yap';
  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _passwordcontroller = TextEditingController();
    _emailcontroller = TextEditingController();
  }
  //TODO deneme
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);
    Size size = MediaQuery.of(context).size;
    return viewModel.stateStatus == StateStatus.busy
        ? buildCircularProgressIndicator()
        : viewModel.stateStatus == StateStatus.error
            ? buildLogin(size, viewModel)
            : HomeView(userModel: viewModel.userModel);
  }
  Scaffold buildLogin(Size size, LoginViewModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.07,
                vertical: size.height * 0.14,
              ),
              child: Form(
                key: _formkey,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildLoginText(size),
                        SizedBox(height: size.height * 0.10),
                        buildEposta(),
                        SizedBox(height: size.height * 0.02),
                        buildSifre(viewModel),
                        buildSifrenimiunuttun(),
                        buildRememberMe(viewModel),
                        SizedBox(height: size.height * 0.02),
                        buildLoginButton(viewModel),
                        buildSignupButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            viewModel.isLoading
                ? Positioned.fill(
                    child: Container(
                    color: Colors.black.withOpacity(0.3),
                    child: Center(
                        child: CircularProgressIndicator(color: primary)),
                  ))
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  SizedBox buildLoginText(Size size) {
    return SizedBox(
      width: size.width * 0.6,
      child: FittedBox(
        child: Text(
          _titleLogin,
          style: TextStyle(color: primary, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Material buildCircularProgressIndicator() {
    return Material(
      child: Center(
        child: CircularProgressIndicator(
          color: primary,
        ),
      ),
    );
  }

  Widget buildEposta() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kullanıcı Adı',
          style: TextStyle(
            color: primary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          height: 60,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "Boş Mail girdiniz";
              }
              return null;
            },
            onSaved: (value) {
              _emailcontroller.text = value!;
            },
            autofocus: false,
            textInputAction: TextInputAction.next,
            controller: _emailcontroller,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Theme.of(context).disabledColor,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 15),
                prefixIcon: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                hintText: "Kullanıcı Adı",
                hintStyle:
                    TextStyle(color: Theme.of(context).secondaryHeaderColor)),
          ),
        )
      ],
    );
  }

  Widget buildSifre(LoginViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Şifre',
          style: TextStyle(
            color: primary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ]),
          height: 60,
          child: TextFormField(
            validator: (value) {
              RegExp regexp = RegExp(r'^.{6,}$');
              if (value!.isEmpty) {
                return "Şifre Boş girilemez";
              }
              if (!regexp.hasMatch(value)) {
                return "Hatalı şifre girdiniz";
              }
              return null;
            },
            onSaved: (value) {
              _passwordcontroller.text = value!;
            },
            autofocus: false,
            controller: _passwordcontroller,
            obscureText: viewModel.isObscure,
            textInputAction: TextInputAction.done,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 15),
                border: InputBorder.none,
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    viewModel.changeObscure();
                  },
                  icon: Icon(
                    viewModel.isObscure
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.white,
                  ),
                ),
                hintText: "Şifre",
                hintStyle:
                    TextStyle(color: Theme.of(context).secondaryHeaderColor)),
          ),
        )
      ],
    );
  }

  Widget buildSifrenimiunuttun() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: Text(
          'Şifremi Unuttum',
          style: TextStyle(
            color: primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildRememberMe(LoginViewModel viewModel) {
    return SizedBox(
      height: 30,
      child: Row(
        children: [
          Theme(
            data: ThemeData(
              unselectedWidgetColor: primary,
            ),
            child: Checkbox(
              value: viewModel.rememberMe,
              checkColor: Colors.white,
              activeColor: primary,
              onChanged: (value) {
                viewModel.rememberMe = value ?? false;
              },
            ),
          ),
          Text(
            'Beni Hatırla',
            style: TextStyle(
              color: primary,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget buildLoginButton(LoginViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: CustomElevatedButton(
        onPressed: () {
          login(viewModel, _emailcontroller.text, _passwordcontroller.text);
        },
        title: _titleLogin,
      ),
    );
  }

  Widget buildSignupButton() {
    return GestureDetector(
      onTap: () {},
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Hesabınız yok mu ? ",
              style: TextStyle(
                  color: primary, fontSize: 18, fontWeight: FontWeight.w500),
            ),
            TextSpan(
                text: "KAYIT OL",
                style: TextStyle(
                  color: primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }

  void login(LoginViewModel viewModel, String username, String password) async {
    if (_formkey.currentState?.validate() ?? false) {
      viewModel.changeLoading();
      _formkey.currentState?.save();
      bool hasData = await viewModel.fetchUserLogin(username, password);
      if (hasData) {
        navigateHome(viewModel);
      } else {
        viewModel.changeLoading();
      }
    }
  }

  void navigateHome(LoginViewModel viewModel) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeView(
              userModel: viewModel.userModel,
            )));
  }
}
