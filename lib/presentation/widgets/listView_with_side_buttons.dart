import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../business_logic/cubits/portfolio_cubit.dart';
import '../../utils/my_colors.dart';
import '../../data/models/screen_size.dart';

class ListViewWithSideButtons extends StatelessWidget {
  const ListViewWithSideButtons({
    Key? key, required this.scrollController,
    required this.listLength,
    required this.builder, this.sideWidth
  }) : super(key: key);

  final ScrollController scrollController ;
  final int listLength ;
  final double? sideWidth ;
  final Widget Function(BuildContext, int) builder;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            PortfolioCubit.get(context).screenSize != ScreenSize.isMobile || sideWidth != null?
            SizedBox(width: sideWidth?? 30,): Container(),
            Expanded(
              child: ListView.separated(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemCount: listLength,
                itemBuilder: (context, index)=> builder(context, index)
              ),
            ),
            PortfolioCubit.get(context).screenSize != ScreenSize.isMobile || sideWidth != null?
            SizedBox(width: sideWidth??30,): Container(),

          ],
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          child: InkWell(
            onTap: () {
              // Scroll the list to the left
              scrollController.animateTo(
                scrollController.offset - (MediaQuery.of(context).size.width/2) + 50,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: CircleAvatar(
                radius: PortfolioCubit.get(context).screenSize == ScreenSize.isDesktop
                    ? 30 : 15,
                backgroundColor:  MyColors.purple1.withOpacity(0.2),
                child: Center(child: const Icon(Icons.arrow_back_ios))),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () {
              scrollController.animateTo(
                scrollController.offset + ( MediaQuery.of(context).size.width/2)- 50,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: CircleAvatar(
                radius: PortfolioCubit.get(context).screenSize == ScreenSize.isDesktop
                    ? 30 : 15,
                backgroundColor: MyColors.purple1.withOpacity(0.2),
                child: const Center(child: Icon(Icons.arrow_forward_ios))
            ),
          ),
        ),
      ],
    );
  }


}
