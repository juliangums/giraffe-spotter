import 'package:flutter/material.dart';
import 'package:giraffe_spotter/models/Item.dart';
import 'package:giraffe_spotter/pages/home/widgets/ArticleCard.dart';

class GridViewWidget extends StatelessWidget{

  final List<Item> dataItems;
  GridViewWidget({required this.dataItems});

  @override
  Widget build(BuildContext context) {
    final width  = MediaQuery.of(context).size.width;
    return Flexible(
        child: Container(
          width: width,
          child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 5),
              shrinkWrap: true,
              itemCount: dataItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 18, childAspectRatio: 0.65),
              itemBuilder: (context,index){
                final itemData = dataItems[index];
                return ArticleCard(itemData: itemData, page: true);
              }
          ),
        )
    );
  }
  
}