import 'package:flutter/material.dart';

class DisplayCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget content;
  final List<Widget> actions;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final BoxDecoration? cardDecoration;

  const DisplayCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.actions,
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.all(10.0),
    this.titleStyle,
    this.subtitleStyle,
    this.cardDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      color: backgroundColor,
      margin: EdgeInsets.all(8),
      child: Container(
        decoration: cardDecoration ?? BoxDecoration(),
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: titleStyle ?? Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: subtitleStyle ?? Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            content,
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: actions,
            ),
          ],
        ),
      ),
    );
  }
}
