import "package:flutter/material.dart";
import "package:trackify/screens/sign_up.dart";
import "package:trackify/services/auth_service.dart";
import "package:trackify/utils/appvalidator.dart";

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  var authService = AuthService();
  var isLoading = false;

  Future<void> _submitForm() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      var data = {
        "email": _emailController.text,
        "password": _passwordController.text,
      };
      await authService.userLogin(data, context);
      setState(() {
        isLoading = false;
      });
    }
  }

  var appValidator = AppValidator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF252634),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              const SizedBox(
                height: 80.0,
              ),
              const SizedBox(
                width: 250,
                child: Text(
                  "Login Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              TextFormField(
                controller: _emailController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: _buildInputDecoration("Email", Icons.email),
                validator: appValidator.validateEmail,
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _passwordController,
                style: const TextStyle(color: Colors.white),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: _buildInputDecoration("Password", Icons.lock),
                validator: appValidator.validatePassword,
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF15900)),
                  onPressed: () {
                    isLoading ? print("Loading..") : _submitForm();
                  },
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const Text(
                          "Login",
                          style: TextStyle(fontSize: 20),
                        ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpView(),
                    ),
                  );
                },
                child: const Text(
                  "Create new account",
                  style: TextStyle(color: Color(0xFFF15900), fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData suffixIcon) {
    return InputDecoration(
      fillColor: const Color(0xAA494A59),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0x35949494),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      filled: true,
      labelStyle: const TextStyle(color: Color(0xFF949494)),
      labelText: label,
      suffixIcon: Icon(
        suffixIcon,
        color: const Color(0xFF949494),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
