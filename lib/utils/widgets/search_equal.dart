import 'package:flutter/material.dart';
import 'package:playlist/utils/imagePath.dart';

class SearchIcon extends StatelessWidget {
  const SearchIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Icon(Icons.search),
          VerticalDivider(thickness: 1,width: 5,),
          Image.asset(ImagePath.equal,height: 30,)
        ],
      ),
    );
  }
}
