import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:pookeedex/core/services/provider/pookee_provider.dart';
import 'package:provider/provider.dart';

import '../../core/constants/padding_const.dart';
import '../model/nature.dart';

class CustomButton extends StatefulWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.id,
      required this.function});

  final String text;

  final int id;

  final Function function;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  void initState() {
    super.initState();
    nature = context.read<PookeeProvider>().pookee.natures.first;
  }

  late final Nature nature;

  bool get isSelected =>
      context.watch<PookeeProvider>().selectedPage == widget.id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (context.read<PookeeProvider>().selectedPage != widget.id) {
          widget.function();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(360),
          ),
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    nature.natureColor.firstColor,
                    nature.natureColor.secondColor,
                  ],
                )
              : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: nature.natureColor.shadowColor.withOpacity(0.7),
                    blurRadius: 10,
                  ),
                ]
              : null,
        ),
        child: Padding(
          padding: const PaddingConst.smallAll(),
          child: Center(
            child: Text(
              widget.text,
              style: context.textTheme.headline6?.copyWith(
                  color: isSelected
                      ? Colors.white
                      : nature.natureColor.firstColor),
            ),
          ),
        ),
      ),
    );
  }
}
