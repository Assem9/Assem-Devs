import 'package:flutter/cupertino.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_cubit.dart';
import 'package:my_portfolio/data/models/screen_size.dart';

import '../../utils/my_colors.dart';

class MyDriver extends StatelessWidget {
  const MyDriver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3,
      margin: PortfolioCubit.get(context).screenSize == ScreenSize.isMobile
          ? const EdgeInsets.symmetric(vertical: 10)
          : const EdgeInsets.symmetric(vertical: 40),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: MyColors.purple.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ]
      ),
    );
  }
}
