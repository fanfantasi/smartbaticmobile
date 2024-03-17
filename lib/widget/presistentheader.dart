import 'package:chat_apps/constanta/string.dart';
import 'package:flutter/material.dart';

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final String title;

  PersistentHeader(this.title);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
      color: Colors.white.withOpacity(.9),
      child: Column(children: [
        Row(
          children: [
            Container(
              width: 3,
              height: 20,
              color: (shrinkOffset == 0.0) ? kPrimaryColor : Colors.black87,
            ),
            const SizedBox(
              width: 5.0,
            ),
            Flexible(
              child: Text(title,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      color: (shrinkOffset == 0.0)
                          ? Colors.black54
                          : kPrimaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ]),
    );
  }

  @override
  double get maxExtent => 40.0;

  @override
  double get minExtent => 40.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
