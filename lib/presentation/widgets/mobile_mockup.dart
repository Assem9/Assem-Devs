import 'package:flutter/material.dart';
import 'package:my_portfolio/utils/my_colors.dart';
import '../../business_logic/cubits/portfolio_cubit.dart';
import '../../data/models/screen_size.dart';

class MobileMockupWidget extends StatelessWidget {
  final double width;
  final double height;
  final String image ;
  final bool rotate ;

  const MobileMockupWidget({
    super.key,
    required this.width,
    required this.height,
    required this.image,
    required this.rotate
  });

  double getBorderRadius(context){
    bool isNotMobile = PortfolioCubit.get(context).screenSize != ScreenSize.isMobile ;
    if(isNotMobile){
      return 20 ;
    }else{
      return 10;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: rotate? 4 : 3,
      child: Container(
        width: width,
        height:  height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(getBorderRadius(context)),
        ),
        child: _buildMobileShape(context),
      ),
    );
  }

  Widget _buildMobileShape(context){
    bool isNotMobile = PortfolioCubit.get(context).screenSize != ScreenSize.isMobile ;
    double borderSize = isNotMobile ? 5 : 2.5 ;
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[700],
        border: Border.all(
        color: Colors.black,
        width: borderSize,
      ), //.all(width: 5,color: Colors.black),
        borderRadius: BorderRadius.circular(getBorderRadius(context) ),
        boxShadow: const [
          BoxShadow(
            color: MyColors.purple,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildMobileNotch(context),
          Expanded(
            child: RotatedBox(
              quarterTurns: rotate? 4 : 1,
              child: Container(
                decoration: BoxDecoration(

                    image: DecorationImage(image:  NetworkImage(image),fit: BoxFit.contain)
                ),
              ),
            ),
          ),
          _buildMobileBottomNotch(context)
        ],
      ),
    );
  }

  Widget _buildMobileBottomNotch(context){
    bool isNotMobile = PortfolioCubit.get(context).screenSize != ScreenSize.isMobile ;
    return Container(
      height: isNotMobile ? 10 :5,
      padding: EdgeInsets.symmetric(
          horizontal: isNotMobile ? 10 :5
      ),
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius:  BorderRadius.only(
              bottomLeft: Radius.circular(getBorderRadius(context) ),//-(5/1.5)
              bottomRight: Radius.circular(getBorderRadius(context) )
          )

      ),
    );
  }

  Widget _buildMobileNotch(context){
    bool isNotMobile = PortfolioCubit.get(context).screenSize != ScreenSize.isMobile ;
    return Container(
      height: isNotMobile ? 30 :15,
      alignment: AlignmentDirectional.centerStart,
      padding: EdgeInsets.symmetric(
          horizontal: isNotMobile ? 10 :5
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius:  BorderRadius.only(
            topLeft: Radius.circular(getBorderRadius(context) ),//-(5/1.5)
            topRight: Radius.circular(getBorderRadius(context) )
        )

      ),
      child: _buildFrontCam(context),
    ) ;
  }

  Widget _buildFrontCam(context){
    bool isNotMobile = PortfolioCubit.get(context).screenSize != ScreenSize.isMobile ;
    return Container(
      width: isNotMobile? 15 : 9,
      height: isNotMobile? 12 : 9,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 2.0, color: MyColors.dark),
      ),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: MyColors.black2,
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 15 * 0.6,
                height: 15 * 0.6,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}