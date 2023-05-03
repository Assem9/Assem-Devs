import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_cubit.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_states.dart';
import 'package:my_portfolio/data/models/aboutMe.dart';
import 'package:my_portfolio/presentation/widgets/listView_with_side_buttons.dart';
import '../../constants/my_colors.dart';
import '../../data/models/screen_size.dart';
import '../widgets/my_divider.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({super.key});
  final ScrollController _scrollController =  ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PortfolioCubit,PortfolioStates>(
      listener: (context,state){},
      builder: (context,state) {
        var cubit = PortfolioCubit.get(context);
        return Container(
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(
              horizontal: cubit.screenSize == ScreenSize.isMobile ? 20 : 50
          ),
          child: Column(
            children: [
              const MyDriver(),
              Expanded(
                  child: _buildAboutMeDialog(context)
              ),
              const SizedBox(height: 10,),
              _buildText(context,'WHAT I DO'),
              Text(
                'I Use Flutter To Deliver Apps For:',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 10,),
              Expanded(
                  child: ListViewWithSideButtons(
                      scrollController: _scrollController,
                      listLength: PortfolioCubit.get(context).personalData.jobs.length,
                      builder: (context,index){
                        final job = PortfolioCubit.get(context).personalData.jobs[index];
                        return _buildJobWidget(context, job);
                      },
                  ),
              ),
            ],
          ),
        );
      },

    );
  }

  Widget _buildAboutMeDialog(context){
    var cubit = PortfolioCubit.get(context) ;
    return Container(
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: MyColors.purple,width: 4))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildText(context,'ABOUT ME'),
          Expanded(
            child: Flex(
              direction: cubit.screenSize == ScreenSize.isMobile
                ? Axis.vertical
                : Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  flex: cubit.screenSize == ScreenSize.isMobile?2 :1,
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return  const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            MyColors.purple ,
                            MyColors.white,
                            MyColors.purple,
                          ]
                      ).createShader(bounds);
                    },
                    child: SvgPicture.asset(
                      'assets/images/programer.svg',
                      placeholderBuilder: (context)=> Lottie.asset('assets/images/wave-loader.gif'),
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  flex: 3,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      cubit.personalData.aboutMeParagraph,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildText(context,String text){
    return Container(
      color: MyColors.purple,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Text(
        text,
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }

  Widget _buildJobWidget(context,Job job){
    var cubit = PortfolioCubit.get(context) ;
    var screenWidth =MediaQuery.of(context).size.width ;
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return  const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              MyColors.purple1,
              MyColors.white,
              MyColors.purple2,
            ]
        ).createShader(bounds);
      },
      child: Container(
        height: screenWidth > 400
            ? screenWidth/3
            : screenWidth - 40 ,
        width: screenWidth> 400
            ? screenWidth/3
            : screenWidth - 40 ,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: MyColors.purple)
        ),
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Text(
              job.title.toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                 // image: DecorationImage(image: NetworkImage(job.svg),fit: BoxFit.contain),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.purple.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/wave-loader.gif' ,
                    image: job.svg,
                    fit: BoxFit.contain
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
/*
Widget _buildJobsListView(context){
    return Column(
      children: [
        Text(
          'I use Flutter to deliver apps for:',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 10,),
        Expanded(
          child: Stack(
            children: [
              ListView.separated(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemCount: PortfolioCubit.get(context).personalData.jobs.length,
                itemBuilder: (context, index) {
                  final job = PortfolioCubit.get(context).personalData.jobs[index];
                  return _buildJobWidget(context, job);
                },
              ),
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                child: InkWell(
                  onTap: () {
                    // Scroll the list to the left
                    _scrollController.animateTo(
                      _scrollController.offset - MediaQuery.of(context).size.width + 50,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: CircleAvatar(
                      radius: PortfolioCubit.get(context).screenSize == ScreenSize.isDesktop
                          ? 30 : 15,
                      backgroundColor: MyColors.purple,
                      child: const Icon(Icons.arrow_back_ios)),
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    _scrollController.animateTo(
                      _scrollController.offset +  MediaQuery.of(context).size.width- 50,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: CircleAvatar(
                      radius: PortfolioCubit.get(context).screenSize == ScreenSize.isDesktop
                          ? 30 : 15,
                      backgroundColor: MyColors.purple,
                      child: const Icon(Icons.arrow_forward_ios)
                  ),
                ),
              ),
            ],
          ),
    )
      ],
    );
  }
 */


/*
Widget _scrollableListView(context){
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onHorizontalDragUpdate: (details) {
          // Calculate the new scroll offset based on the drag distance
          final newOffset = _scrollController.offset - details.delta.dx;
          // Set the new scroll offset, clamping it to the bounds of the list
          _scrollController.jumpTo(newOffset.clamp(0, _scrollController.position.maxScrollExtent));
        },
        child: ListView.separated(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => SizedBox(width: 10),
          itemCount: PortfolioCubit.get(context).personalData.jobs.length,
          itemBuilder: (context, index) {
            final job = PortfolioCubit.get(context).personalData.jobs[index];
            return _buildJobWidget(context, job);
          },
        ),
      ),
    );
  }
 */