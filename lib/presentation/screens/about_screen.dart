import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_cubit.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_states.dart';
import 'package:my_portfolio/data/models/aboutMe.dart';
import 'package:my_portfolio/presentation/widgets/listView_with_side_buttons.dart';
import '../../utils/my_colors.dart';
import '../../data/models/screen_size.dart';
import '../widgets/my_divider.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({super.key});
  final ScrollController _scrollController =  ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioCubit, PortfolioStates>(
        buildWhen: (previous,current)=> current is ScreenSizeChanged,
        builder: (context,state) {
          return Center(
            child: SizedBox(
              height: 950,
              width: MediaQuery.of(context).size.width >1200
                  ? MediaQuery.of(context).size.width * 0.8
                  : MediaQuery.of(context).size.width * 0.95,
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
                  BlocBuilder<PortfolioCubit, PortfolioStates>(
                      buildWhen: (previous,current)=> current is PersonalDataLoaded,
                      builder: (context, state) {
                        return !PortfolioCubit.get(context).dataLoading
                            ?SizedBox(
                          height: PortfolioCubit.get(context).screenSize == ScreenSize.isMobile
                              ? 200
                              : 300,
                          child: ListViewWithSideButtons(
                            scrollController: _scrollController,
                            listLength: PortfolioCubit.get(context).personalData.jobs.length,
                            builder: (context,index){
                              final job = PortfolioCubit.get(context).personalData.jobs[index];
                              return _buildJobWidget(context, job);
                            },
                          ),
                        ): const CircularProgressIndicator();
                      }
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  Widget _buildAboutMeDialog(context){
    var cubit = PortfolioCubit.get(context) ;
    return  BlocBuilder<PortfolioCubit, PortfolioStates>(
        buildWhen: (previous,current)=> current is PersonalDataLoaded || current is ScreenSizeChanged,
        builder: (context, state) {
        return !PortfolioCubit.get(context).dataLoading
        ?Container(
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
                      child: SvgPicture.asset(
                        'assets/images/programer.svg',
                        placeholderBuilder: (context)=> Lottie.asset('assets/images/ballons_loader.gif'),
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
        ): const CircularProgressIndicator();
      }
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
    var screenWidth =MediaQuery.of(context).size.width ;
    return Container(
      width: screenWidth > 600
          ? screenWidth/4
          : 150 ,
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
            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: MyColors.purple),
          ),
          const SizedBox(height: 10,),
          Expanded(
            child: SvgPicture.network(
              job.svg,
              placeholderBuilder: (context)=> Placeholder(
                child: Image.asset('assets/images/ballons_loader.gif'),
              ),
            ),
          ),


        ],
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