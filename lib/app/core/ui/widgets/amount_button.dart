import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:burgerstore/app/core/ui/styles/colors_app.dart';

import '../styles/text_styles.dart';

class AmountButton extends StatelessWidget {
  final double width;
  final double height;

  final int amount;
  final VoidCallback incrementTap;
  final VoidCallback decrementTap;

  const AmountButton(
      {super.key,
      required this.width,
      required this.height,
      required this.amount,
      required this.incrementTap,
      required this.decrementTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(width: 1, color: Colors.grey)),
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: decrementTap,
            icon: Icon(
              CupertinoIcons.minus,
              size: 22,
              color: context.colors.secondary,
            ),
          ),
          Text(
            amount.toString(),
            style: TextStyles.instance.textMedium.copyWith(
              fontSize: 18,
              color: context.colors.secondary,
            ),
          ),
          IconButton(
            onPressed: incrementTap,
            icon: Icon(
              CupertinoIcons.add,
              size: 22,
              color: context.colors.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
