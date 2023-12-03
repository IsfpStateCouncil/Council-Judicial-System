import 'package:council_of_state/functions/AfterBuild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/staticdata.dart';
import '../providerclasses.dart/providerUserData.dart';
import '../providerclasses.dart/providerlanguage.dart';

class Login extends StatefulWidget {
  const Login({
    Key? key,
  }) : super(key: key);

  static const routeName = 'login_screen';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool _obscurePassword = true;

  late SharedPreferences _sharedPreferences;
  String? languge;
  void initState() {
    super.initState();
    _loadLanguage(); // Load stored data when the widget initializes
  }

  Future<void> _loadLanguage() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      languge = _sharedPreferences.getString('language') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    checkConnection(context, Login.routeName);
    final languageProvider = Provider.of<LanguageProvider>(context);
    languageProvider.changelanguage(languge);
    return Scaffold(
      body: Container(
        color: StaticData.backgroundColors,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Image.asset(
                  StaticData.imageLogo,
                  height: 300,
                  width: 300,
                ),
                const SizedBox(height: 10),
                Text(
                  languageProvider.getCurrentData('login', context),
                  style: TextStyle(
                      fontSize: 40,
                      color: StaticData.font,
                      fontFamily: StaticData.fontFamily),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60),
                TextFormField(
                  controller: _controllerUsername,
                  keyboardType: TextInputType.name,
                  //textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    labelText:
                        languageProvider.getCurrentData('userName', context),
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelStyle: TextStyle(
                      fontFamily: StaticData.fontFamily,
                    ),
                  ),
                  onEditingComplete: () => _focusNodePassword.requestFocus(),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return languageProvider.getCurrentData(
                          'plzEnterUserName', context);
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _controllerPassword,
                  focusNode: _focusNodePassword,
                  obscureText: _obscurePassword,
                  //textDirection: TextDirection.rtl,
                  //keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText:
                        languageProvider.getCurrentData('password', context),
                    prefixIcon: const Icon(Icons.password_outlined),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {});
                          if (_obscurePassword) {
                            _obscurePassword = false;
                          } else {
                            _obscurePassword = true;
                          }
                        },
                        icon: _obscurePassword
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelStyle: TextStyle(
                      fontFamily: StaticData.fontFamily,
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return languageProvider.getCurrentData(
                          'plzEnterPassword', context);
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 60),
                Column(
                  children: [
                    Consumer<ProviderUserData>(
                        builder: (context, user_data, child) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              StaticData.button, // Background color
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () async {
                          var userName = _controllerUsername.text.trim();
                          user_data.setterUser(
                              userName, _controllerPassword.text.trim());
                          await user_data.login(
                              context,
                              _controllerUsername.text.trim(),
                              _controllerPassword.text.trim());
                        },
                        child: Text(
                            languageProvider.getCurrentData('login', context),
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: StaticData.fontFamily)),
                      );
                    })
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNodePassword.dispose();
    _controllerUsername.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }
}
