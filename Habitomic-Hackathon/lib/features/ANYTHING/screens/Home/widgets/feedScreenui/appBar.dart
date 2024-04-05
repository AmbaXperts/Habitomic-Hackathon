import 'package:flutter/material.dart';

class tabbar extends StatelessWidget implements PreferredSizeWidget {
  final TabController control;
  const tabbar({
    super.key,
    required this.control,
  });

  @override
  Widget build(BuildContext context) {
    return const Material(
      color: Colors.black87,
      child: TabBar(
        // controller: control,
        isScrollable: true,
        tabs: [
          Tab(
            child: Text('yy'),
          ),
          Tab(
            child: Text('rrr'),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => throw UnimplementedError();
}
