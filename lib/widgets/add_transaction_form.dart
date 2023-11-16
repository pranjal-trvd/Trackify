import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackify/utils/appvalidator.dart';
import 'package:trackify/widgets/category_dropdown.dart';
import 'package:uuid/uuid.dart';

class AddTransactionForm extends StatefulWidget {
  const AddTransactionForm({super.key});

  @override
  State<AddTransactionForm> createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  var type = "credit";
  var category = "Others";
  var isLoading = false;
  var appValidator = AppValidator();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var amountEditController = TextEditingController();
  var titleEditController = TextEditingController();
  var uid = Uuid();

  Future<void> _submitForm() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final user = FirebaseAuth.instance.currentUser;
      int timeStamp = DateTime.now().millisecondsSinceEpoch;
      var amount = int.parse(amountEditController.text);
      DateTime date = DateTime.now();

      var id = uid.v4();
      String monthyear = DateFormat('MMM y').format(date);
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      int remainingAmount = userDoc['remainingAmount'];
      int totalCredit = userDoc['totalCredit'];
      int totalDebit = userDoc['totalDebit'];

      if (type == "credit") {
        totalCredit += amount;
        remainingAmount += amount;
      } else {
        totalDebit += amount;
        // totalCredit -= amount;
        remainingAmount -= amount;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        "remainingAmount": remainingAmount,
        "totalCredit": totalCredit,
        "totalDebit": totalDebit,
        "updatedAt": timeStamp,
      });

      var data = {
        "id": id,
        "title": titleEditController.text,
        "amount": amount,
        "type": type,
        "timestamp": timeStamp,
        "totalCredit": totalCredit,
        "totalDebit": totalCredit,
        "remainingAmount": remainingAmount,
        "monthyear": monthyear,
        "category": category,
      };

      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("transactions")
          .doc(id)
          .set(data);

      Navigator.pop(context);

      // await authService.userLogin(data, context);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            TextFormField(
              controller: titleEditController,
              validator: appValidator.isEmptyCheck,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: "Title",
              ),
            ),
            TextFormField(
              controller: amountEditController,
              validator: appValidator.isEmptyCheck,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Amount",
              ),
            ),
            CategoryDropDown(
              cattype: category,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    category = value;
                  });
                }
              },
            ),
            DropdownButtonFormField(
              value: "credit",
              items: [
                DropdownMenuItem(
                  child: Text("Credit"),
                  value: "credit",
                ),
                DropdownMenuItem(
                  child: Text("Debit"),
                  value: "debit",
                )
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    type = value;
                  });
                }
              },
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                if (isLoading == false) {
                  _submitForm();
                }
              },
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Text("Add Transaction"),
            ),
          ],
        ),
      ),
    );
  }
}
