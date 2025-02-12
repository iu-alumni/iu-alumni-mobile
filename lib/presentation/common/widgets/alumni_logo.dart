import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../gen/assets.gen.dart';

class AlumniLogo extends StatelessWidget {
  const AlumniLogo({super.key});

  @override
  Widget build(BuildContext context) => SvgPicture.asset(Assets.images.alumni);
}
