import 'package:flutter/material.dart';
import 'package:trackify/utils/icons_list.dart';

// ignore: must_be_immutable
class CategoryDropDown extends StatelessWidget {
  CategoryDropDown({super.key, this.cattype, required this.onChanged});
  final String? cattype;
  final ValueChanged<String?> onChanged;
  var appIcons = AppIcons();
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
        value: cattype,
        isExpanded: true,
        hint: Text("Select Ctegory"),
        items: appIcons.homeExpensesCategories
            .map((e) => DropdownMenuItem<String>(
                  value: e['name'],
                  child: Row(
                    children: [
                      Icon(
                        e['icon'],
                        color: Colors.black45,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        e['name'],
                        style: TextStyle(color: Colors.black45),
                      ),
                    ],
                  ),
                ))
            .toList(),
        onChanged: onChanged);
  }
}
