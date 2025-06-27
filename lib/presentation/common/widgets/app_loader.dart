import 'package:flutter/cupertino.dart';

import 'app_card.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({this.inCard = false, this.color, super.key});

  final bool inCard;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final indicator = CupertinoActivityIndicator(color: color);
    return inCard ? AppCard(child: indicator) : indicator;
  }
}
