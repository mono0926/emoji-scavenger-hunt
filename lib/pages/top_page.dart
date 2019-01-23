import 'package:emoji_scavenger_hunt/pages/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class TopPage extends StatelessWidget {
  const TopPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      child: Container(
        color: theme.primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 88, // TODO: adjust
              child: SvgPicture.asset('assets/images/logo.svg'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 48,
                vertical: 32,
              ),
              child: Text(
                'Locate the emoji we show you in the real world with your phone’s camera. A neural network will try to guess what it’s seeing.\nMake sure your sound is on.',
                textAlign: TextAlign.center,
                style: theme.accentTextTheme.body1,
              ),
            ),
            RaisedButton(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.volume_up,
                    color: theme.iconTheme.color,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'LET\'S PLAY',
                    style: theme.primaryTextTheme.title,
                  ),
                ],
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(RootPage.routeName);
              },
            ),
            const SizedBox(height: 16),
            Text(
              'Emoji Scavenger Hunt is best experienced on phones.',
              style: theme.accentTextTheme.caption,
            ),
            ButtonTheme(
              height: 28,
              child: FlatButton(
                padding: EdgeInsets.zero,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                child: Text(
                  'Privacy & Terms',
                  style: theme.accentTextTheme.caption.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
                onPressed: () {
                  launch('https://policies.google.com');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
