import 'package:flutter/material.dart';

import '../../../../generated/assets.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final AppBar appBar;
  final List<Widget>? actions;

  const BaseAppBar(
      {super.key, this.leading, required this.appBar, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 60,
      elevation: 0,
      backgroundColor: Colors.white,
      leading: leading,
      title: SizedBox(
        height: 55,
        child: Image.asset(
          Assets.imagesLogo,
          fit: BoxFit.fitHeight,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
