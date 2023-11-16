import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trackify/utils/icons_list.dart';

class CategoryList extends StatefulWidget {
  CategoryList({super.key, required this.onChanged});

  final ValueChanged<String?> onChanged;

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  String currentCat = "";
  final scrollController = ScrollController();
  var appIcons = AppIcons();
  List<Map<String, dynamic>> categoryList = [];
  var addCat = {
    "name": "All",
    "icon": FontAwesomeIcons.cartPlus,
  };

  @override
  void initState() {
    super.initState();
    setState(() {
      categoryList = appIcons.homeExpensesCategories;
      categoryList.insert(0, addCat);
    });
  }

  // scrollToSelectedMonth() {
  //   final selectedMonth = months.indexOf(currentMonth);
  //   if (selectedMonth != -1) {
  //     final scrollOffset = (selectedMonth * 100.0) - 170;
  //     scrollController.animateTo(scrollOffset,
  //         duration: Duration(microseconds: 500), curve: Curves.ease);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: ListView.builder(
        controller: scrollController,
        itemCount: categoryList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var data = categoryList[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                currentCat = data['name'];
                widget.onChanged(data['name']);
              });
              // scrollToSelectedMonth();
            },
            child: Container(
              margin: EdgeInsets.all(6),
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                color: currentCat == data['name']
                    ? Colors.blue.shade900
                    : Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Row(children: [
                  Icon(data['icon'],
                      size: 15,
                      color: currentCat == data['name']
                          ? Colors.white
                          : Colors.blue.shade900),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    data['name'],
                    style: TextStyle(
                        color: currentCat == data['name']
                            ? Colors.white
                            : Colors.blue.shade900),
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
