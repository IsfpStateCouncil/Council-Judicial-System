import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/staticdata.dart';
import '../providerclasses.dart/providerlanguage.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.searchController,
    this.onChanged,
  });

  final TextEditingController searchController;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
          decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(width: 3, color: StaticData.button),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: StaticData.button),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    width: 3, color: StaticData.borderTextFieldColor),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              suffixIcon: const Icon(Icons.search),
              border: InputBorder.none,
              hintStyle: TextStyle(
                fontFamily: StaticData.fontFamily,
              ),
              hintTextDirection: StaticData.arabicTextDirection,
              hintText:
                  languageProvider.getCurrentData('texthintsearch', context)),
          controller: searchController,
          onChanged: onChanged),
    );
  }
}
