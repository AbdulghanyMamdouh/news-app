import 'package:flutter/material.dart';
import 'package:news_app/model/category.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryItem extends StatelessWidget {
  final CategoryDM category;
  final int index;
  const CategoryItem({super.key, required this.category, required this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
          color: category.color,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(25),
            topRight: const Radius.circular(25),
            bottomLeft: Radius.circular(
              (index % 2 != 0) ? 0 : 25,
            ),
            bottomRight: Radius.circular(
              (index % 2 != 0) ? 25 : 0,
            ),
          )),
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Image.asset(
            category.imagePath,
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.16,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Text(
              category.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
