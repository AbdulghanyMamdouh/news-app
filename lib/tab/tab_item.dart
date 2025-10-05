import 'package:flutter/material.dart';
import 'package:news_app/model/source_response/source_response.dart';
import 'package:news_app/my_theme.dart';

class TabItem extends StatelessWidget {
  final bool isSelected;
  final Source source;
  const TabItem({super.key, required this.isSelected, required this.source});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 13),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: isSelected ? MyTheme.primaryLightColor : Colors.transparent,
        border: Border.all(
          color: MyTheme.primaryLightColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(source.name ?? '',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color:
                    isSelected ? MyTheme.whiteColor : MyTheme.primaryLightColor,
                fontWeight: FontWeight.normal,
              )),
    );
  }
}
