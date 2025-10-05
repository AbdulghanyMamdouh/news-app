import 'package:flutter/material.dart';
import 'package:news_app/home/category/category_item.dart';
import 'package:news_app/model/category.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import 'package:news_app/my_theme.dart';

class CategoryFragment extends StatelessWidget {
  static const String routeName = " categorie fragments";
  final Function onCategoryIconClick;
  const CategoryFragment({super.key, required this.onCategoryIconClick});
  @override
  Widget build(BuildContext context) {
    final categoriesList = CategoryDM.getCategoriesList(context);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.pick_category,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 25,
                crossAxisSpacing: 25,
              ),
              itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    onCategoryIconClick(categoriesList[index]);
                  },
                  child: CategoryItem(
                      category: categoriesList[index], index: index)),
              itemCount: categoriesList.length,
            ),
          )
        ],
      ),
    );
  }
}
