import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:tv_randshow/src/utils/styles.dart';

class InfoBoxWidget extends StatelessWidget {
  const InfoBoxWidget({Key key, this.typeInfo, this.value}) : super(key: key);
  final int typeInfo;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        alignment: Alignment.topCenter,
        margin: SMALL_INSESTS,
        padding: SMALL_INSESTS,
        constraints: const BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              selectTitle(typeInfo, context),
              style: const TextStyle(color: StyleColor.WHITE, fontSize: 16),
            ),
            Text(
              value > 0 ? value.toString() : '--',
              style: TextStyle(
                  color: StyleColor.WHITE,
                  fontSize: 26,
                  fontWeight: FontWeight.w700),
            ),
            if (typeInfo <= 2)
              typeInfo == 2
                  ? Text(
                      FlutterI18n.translate(
                          context, 'app.modal.duration_metric'),
                      style: TextStyle(
                          color: StyleColor.WHITE,
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                    )
                  : Text(
                      FlutterI18n.translate(
                          context, 'app.modal.episode_season_metric'),
                      style: TextStyle(
                          color: StyleColor.WHITE,
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                    ),
          ],
        ),
        decoration: BoxDecoration(
          color: StyleColor.PRIMARY,
          borderRadius: BORDER_RADIUS,
        ),
      ),
    );
  }

  String selectTitle(int typeInfo, BuildContext context) {
    switch (typeInfo) {
      case 0:
        return FlutterI18n.translate(context, 'app.modal.seasons');
        break;
      case 1:
        return FlutterI18n.translate(context, 'app.modal.episodes');
        break;
      case 2:
        return FlutterI18n.translate(context, 'app.modal.duration');
        break;
      case 3:
        return FlutterI18n.translate(context, 'app.modal.season');
        break;
      case 4:
        return FlutterI18n.translate(context, 'app.modal.episode');
        break;
      default:
        return FlutterI18n.translate(context, 'app.modal.undefined');
    }
  }
}
