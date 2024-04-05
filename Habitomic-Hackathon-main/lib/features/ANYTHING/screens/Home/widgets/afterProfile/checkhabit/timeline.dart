import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class timeline extends StatelessWidget {
  final bool isfirst;
  final bool islast;
  final bool ispast;
  const timeline({
    super.key,
    required this.isfirst,
    required this.islast,
    required this.ispast,
  });

  @override
  Widget build(BuildContext conext) {
    return SizedBox(
      width: 80,
      child: TimelineTile(
        axis: TimelineAxis.horizontal,
        isFirst: isfirst,
        isLast: islast,
        beforeLineStyle: LineStyle(color: ispast ? Colors.purple : Colors.grey),
        indicatorStyle: IndicatorStyle(
          color: ispast ? Colors.purple : Colors.grey,
          iconStyle: IconStyle(
              iconData: Icons.done,
              color: ispast ? Colors.purple : Colors.grey),
        ),
      ),
    );
  }
}
