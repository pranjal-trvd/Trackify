import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackify/widgets/CategoryList.dart';
import 'package:trackify/widgets/timeline_month.dart';
import 'package:trackify/widgets/type_bar_view.dart';

class TransactionScreen extends StatefulWidget {
  TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  var category = "All";
  var monthYear = "";

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    setState(() {
      monthYear = DateFormat('MMM y').format(now);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Expenses"),
        ),
        body: Column(
          children: [
            TimeLineMonth(
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    category = value;
                  });
                }
              },
            ),
            CategoryList(onChanged: (String? value) {
              if (value != null) {
                setState(() {
                  category = value;
                });
              }
            }),
            TypeTabBar(
              category: category,
              monthYear: monthYear,
            ),
          ],
        ));
  }
}
