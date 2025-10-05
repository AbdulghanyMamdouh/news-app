import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/tab/tab_item.dart';
import 'package:news_app/home/news/news_widget.dart';
import 'package:news_app/model/source_response/source_response.dart';

class TabWidget extends StatefulWidget {
  final List<Source> sourceList;

  const TabWidget({super.key, required this.sourceList});

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.sourceList.length,
      child: Column(
        children: [
          TabBar(
            tabAlignment: TabAlignment.start,
            labelPadding: const EdgeInsets.all(4),
            isScrollable: true,
            indicatorColor: Colors.transparent,
            dividerColor: Colors.transparent,
            onTap: (index) {
              ApiManager.pageSize = 1;


              selectedIndex = index;
              setState(() {});
            },
            tabs: widget.sourceList
                .map((source) => TabItem(
                    isSelected:
                        selectedIndex == widget.sourceList.indexOf(source),
                    source: source))
                .toList(),
          ),
          Expanded(child: NewsWidget(source: widget.sourceList[selectedIndex]))
        ],
      ),
    );
  }
}
