import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  SettingsButton({
    required this.onTap,
    required this.text,
  });

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          height: 80,
          width: (MediaQuery.of(context).size.width) * 0.95,
          padding: EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            '$text',
            style: theme.textTheme.headline6?.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
