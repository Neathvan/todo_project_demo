import 'package:flutter/material.dart';
import 'package:todo_project_demo/helper/colors.dart';
import 'package:todo_project_demo/helper/k_extension.dart';

class SearchTextFieldBar extends StatelessWidget {
  final ValueChanged<String> onSearch;
  SearchTextFieldBar({
    required this.onSearch,
    super.key,
  });

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      onChanged: (value) => onSearch(value),
      decoration: InputDecoration(
        hintText: 'Search...',
        contentPadding: EdgeInsets.symmetric(
            vertical: Measure.paddingLevel1, horizontal: Measure.paddingLevel1),
        suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              textEditingController.clear();
              onSearch('');
            }),
        prefixIcon: const Icon(Icons.search),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: KColors.black),
            borderRadius: BorderRadius.circular(Measure.borderRaduisl1)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: KColors.black),
          borderRadius: BorderRadius.circular(Measure.borderRaduisl1),
        ),
      ),
    );
  }
}
