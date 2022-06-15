import 'package:flutter/material.dart';
import 'package:moot/Animation/FadeAnimation.dart';
import 'package:moot/components/RoundedButton.dart';
import 'package:moot/components/theme.dart';
import 'package:moot/screens/auth/login_screen.dart';
import 'package:moot/models/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: Color.fromARGB(255, 231, 224, 224),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
                FadeAnimation(
                  1.8,
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: 130,
                        ),
                        Text(
                          'Let’s get started!',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: createMaterialColor(const Color(0xff4C74D9))),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0, left: 30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                        1.8,
                        Align(
                          heightFactor: 2,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Email',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: createMaterialColor(const Color(0xff4C74D9)),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      FadeAnimation(
                        1.8,
                        Container(
                          decoration: BoxDecoration(
                              color: createMaterialColor(Color.fromARGB(41, 179, 179, 179)),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.only(left: 20, bottom: 6, top: 6),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "e.g lets.moot@example.com",
                              hintStyle: TextStyle(color: Colors.grey[600]),
                              suffixIcon: IconButton(
                                onPressed: _emailController.clear,
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Your Email';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      FadeAnimation(
                        1.8,
                        Align(
                          heightFactor: 2,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Display Name',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: createMaterialColor(const Color(0xff4C74D9)),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      FadeAnimation(
                        1.8,
                        Container(
                          decoration: BoxDecoration(
                              color: createMaterialColor(Color.fromARGB(41, 179, 179, 179)),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.only(left: 20, bottom: 6, top: 6),
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            controller: _nameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "e.g Calry Nimbu",
                              hintStyle: TextStyle(color: Colors.grey[600]),
                              suffixIcon: IconButton(
                                onPressed: _nameController.clear,
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Your Name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      FadeAnimation(
                        1.8,
                        Align(
                          heightFactor: 2,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Username',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: createMaterialColor(const Color(0xff4C74D9)),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      FadeAnimation(
                        1.8,
                        Container(
                          decoration: BoxDecoration(
                              color: createMaterialColor(Color.fromARGB(41, 179, 179, 179)),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.only(left: 20, bottom: 6, top: 6),
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            controller: _usernameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "e.g @let’s.moot",
                              hintStyle: TextStyle(color: Colors.grey[600]),
                              suffixIcon: IconButton(
                                onPressed: _usernameController.clear,
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Your Username';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      FadeAnimation(
                        1.8,
                        Align(
                          heightFactor: 2,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Password',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: createMaterialColor(const Color(0xff4C74D9)),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      FadeAnimation(
                        1.8,
                        Container(
                          decoration: BoxDecoration(
                              color: createMaterialColor(Color.fromARGB(41, 179, 179, 179)),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.only(left: 20, bottom: 6, top: 6),
                          child: TextFormField(
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "careful, follow the require",
                              hintStyle: TextStyle(color: Colors.grey[600]),
                              suffixIcon: IconButton(
                                onPressed: _passwordController.clear,
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Your password';
                              } else if (value.length < 8) {
                                return 'Required 8 Characters';
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      FadeAnimation(
                        2,
                        Consumer<AuthProvider>(
                          builder: (context, value, child) {
                            final isLoading = value.state == AuthProviderState.loading;
                            final isError = value.state == AuthProviderState.error;

                            if (isLoading) {
                              return const CircularProgressIndicator();
                            }
                            if (isError) {
                              Future.delayed(
                                Duration.zero,
                                () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("${value.errorMessage}")),
                                  );
                                  value.changeState(AuthProviderState.none);
                                },
                              );
                            }

                            return RoundedButtonWidget(
                              buttonText: 'Register',
                              onpressed: () async {
                                if (!_formKey.currentState!.validate()) return;

                                var user = await value.registUser(
                                    _usernameController.text.trim(),
                                    _emailController.text.trim(),
                                    _nameController.text.trim(),
                                    _passwordController.text.trim());

                                String? message = value.register?.message;
                                if (value.register != null) {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("$message")),
                                  );
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
                                }
                              },
                              width: double.infinity,
                              color: 0xff4C74D9,
                            );
                          },
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const FadeAnimation(
                              1.5,
                              Text(
                                "Have a moot account?",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 90, 90, 90), fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            FadeAnimation(
                                2,
                                RoundedButtonWidget(
                                  buttonText: 'Login',
                                  onpressed: () async {
                                    Navigator.pushAndRemoveUntil(context,
                                        MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
                                  },
                                  width: double.infinity,
                                  color: 0xffFF7262,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
