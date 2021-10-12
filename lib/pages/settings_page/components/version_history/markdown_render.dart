import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spaceportal/pages/settings_page/components/version_history/version_history.dart';

class VersionHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Changelog',
          style: TextStyle(
            color: theme.accentColor,
          ),
        ),
        iconTheme: IconThemeData(
          color: theme.accentColor,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(9),
        height: (MediaQuery.of(context).size.height),
        width: (MediaQuery.of(context).size.width),
        child: Scrollbar(
          interactive: true,
          child: Markdown(
            styleSheet: MarkdownStyleSheet(
              p: TextStyle(fontSize: 17),
            ),
            physics: BouncingScrollPhysics(),
            data: markdownData,
          ),
        ),
      ),
    );
  }
}
