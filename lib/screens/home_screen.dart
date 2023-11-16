import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trackify/screens/login_screen.dart';
import 'package:trackify/widgets/add_transaction_form.dart';
import 'package:trackify/widgets/hero_card.dart';
import 'package:trackify/widgets/transaction_cards.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isLogoutLoading = false;
  final user = FirebaseAuth.instance.currentUser;
  logOut() async {
    setState(() {
      isLogoutLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginView()));
    setState(() {
      isLogoutLoading = false;
    });
  }

  _dialogBuilder(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: AddTransactionForm(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _dialogBuilder(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue.shade900,
      ),
      appBar: AppBar(
        title: Text(
          "Hello,",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade900,
        actions: [
          IconButton(
            onPressed: () {
              logOut();
            },
            icon: isLogoutLoading
                ? const CircularProgressIndicator()
                : const Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                  ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroCard(
              userId: user!.uid,
            ),
            TransactionsCard(),
          ],
        ),
      ),
    );
  }
}
