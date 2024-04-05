import '/common/widgets/custome_shapes/curved_edges/curved+edges.dart';
import 'package:flutter/material.dart';

class TCurveEdgeWidget extends StatelessWidget {
  const TCurveEdgeWidget({
    super.key,
    this.child,
  });
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TCustopmcurvedEdges(),
      child: child,
    );
  }
}
