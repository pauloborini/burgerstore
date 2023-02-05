import 'package:burgerstore/core/ui/styles/colors_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles/text_styles.dart';

class AmountButton extends StatelessWidget {
  final double? width;
  final double? height;
  bool isLittle;

  final int amount;
  final VoidCallback incrementTap;
  final VoidCallback decrementTap;

  AmountButton(
      {super.key,
      this.isLittle = false,
      this.width,
      this.height,
      required this.amount,
      required this.incrementTap,
      required this.decrementTap});

  @override
  Widget build(BuildContext context) {
    return !isLittle
        ? Container(
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
                  style: context.textStyles.medium.copyWith(
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
          )
        : Container(
            width: 100,
            height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                )),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: decrementTap,
                  child: Icon(
                    CupertinoIcons.minus,
                    size: 12,
                    color: context.colors.secondary,
                  ),
                ),
                Text(
                  amount.toString(),
                  style: context.textStyles.medium.copyWith(
                    fontSize: 12,
                    color: context.colors.secondary,
                  ),
                ),
                GestureDetector(
                  onTap: incrementTap,
                  child: Icon(
                    CupertinoIcons.add,
                    size: 12,
                    color: context.colors.secondary,
                  ),
                ),
              ],
            ),
          );
  }
}
