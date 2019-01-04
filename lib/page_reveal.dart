import 'dart:math';

import 'package:flutter/material.dart';

class PageReveal extends StatelessWidget {
  final double revealPercent;
  final Widget child;
  PageReveal({this.revealPercent, this.child});
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      clipper: CircleRevealClipper(revealPercent),
      child: child,
      
    );
  }
}


class CircleRevealClipper extends CustomClipper<Rect>{

  final double revealPercent;

  CircleRevealClipper(this.revealPercent);
  @override
  Rect getClip(Size size) {
    final epiCenter = Offset(size.width / 2 , size.height*0.9);    //where the circle begin
 // print("epi center is ");
   //   print(revealPercent);

   // print(epiCenter);
  
    /*
        |*
    dy  |  *
        |____*
         dx

         cacluclate distance between center of circle to top left of the screen to make sure we fill the screen
    */
    double theta = atan(epiCenter.dy / epiCenter.dx);  // atan  ==> - tan
    final distanceToCorner  = epiCenter.dy / sin(theta);
    final raduis = distanceToCorner  * revealPercent;
    final diamater = 2 * raduis;


    Rect rect= Rect.fromLTWH(epiCenter.dx - raduis, epiCenter.dy - raduis, diamater, diamater);
    return rect;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }


}