import '/common/widgets/custome_shapes/container/container.dart';
import '/common/widgets/custome_shapes/curved_edges/curved_edges_widget.dart';
import '/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TPrimeryHeaderContainer extends StatelessWidget {
  const TPrimeryHeaderContainer({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return TCurveEdgeWidget(
      child: Container(
        color: Colors.grey[200],
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: TCircularContainer(
                backgroundColor: TColors.textwhite.withOpacity(0.1),
              ),
            ),
            Positioned(
                top: 100,
                right: -300,
                child: TCircularContainer(
                  backgroundColor: TColors.textwhite.withOpacity(0.1),
                )),
            child,
          ],
        ),
      ),
    );
  }
}
