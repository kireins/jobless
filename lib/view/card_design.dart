import 'package:flutter/material.dart';
import 'package:jobless/theme.dart';
import 'package:jobless/view/category_screen.dart';

class CategoryCard extends StatelessWidget {
  final String jobType;
  final String jobImage;

  const CategoryCard({ required this.jobType, required this.jobImage}) ;




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>
            CategoryPage(name: jobType, imageUrl: jobImage)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        width: 150.0,
        height: 200.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(jobImage)
          )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              jobType, style: whiteTextStyle.copyWith(fontSize: 18.0, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}







