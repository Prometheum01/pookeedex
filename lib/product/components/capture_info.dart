import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:pookeedex/product/components/widgets.dart';

import '../../core/constants/padding_const.dart';
import '../model/pokemon.dart';

class CaptureInfo extends StatelessWidget {
  const CaptureInfo({super.key, required this.pookee});

  final Pokemon pookee;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoTitleWidget(
          color: pookee.mainFirstColor,
          text: 'Capture',
        ),
        Padding(
          padding: const PaddingConst.smallVertical(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _CaptureInfoColumn(
                  title: "Habitat",
                  titleColor: pookee.mainFirstColor,
                  subtitle: pookee.capture.habitat.toCapitalized(),
                  subtitleColor: Colors.black54),
              const CustomVerticalDivider(),
              _CaptureInfoColumn(
                  title: "Generation",
                  titleColor: pookee.mainFirstColor,
                  subtitle: pookee.capture.generation.toCapitalized(),
                  subtitleColor: Colors.black54),
              const CustomVerticalDivider(),
              _CaptureInfoColumn(
                  title: "Capture Rate",
                  titleColor: pookee.mainFirstColor,
                  subtitle: "${pookee.capture.captureRate.toString()}%",
                  subtitleColor: Colors.black54),
            ],
          ),
        ),
      ],
    );
  }
}

class _CaptureInfoColumn extends StatelessWidget {
  const _CaptureInfoColumn(
      {required this.title,
      required this.titleColor,
      required this.subtitle,
      required this.subtitleColor});

  final String title;
  final Color titleColor;

  final String subtitle;
  final Color subtitleColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: context.textTheme.headline5?.copyWith(
            fontSize: 18,
            color: titleColor,
          ),
        ),
        Padding(
          padding: const PaddingConst.smallVertical(),
          child: Text(
            subtitle,
            style: context.textTheme.headline5
                ?.copyWith(fontSize: 18, color: subtitleColor),
          ),
        ),
      ],
    );
  }
}
