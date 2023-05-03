import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_cubit.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_states.dart';
import 'package:my_portfolio/business_logic/cubits/projects_cubit/projects_cubit.dart';
import 'package:my_portfolio/data/models/Project.dart';
import 'package:my_portfolio/data/models/app_screen_details.dart';
import 'package:my_portfolio/presentation/widgets/listView_with_side_buttons.dart';

import '../../business_logic/cubits/projects_cubit/projects_states.dart';
import '../../constants/my_colors.dart';
import '../../data/models/screen_size.dart';

class ProjectDetailsScreen extends StatefulWidget {
  const ProjectDetailsScreen({Key? key, required this.projectId, this.project}) : super(key: key);
  final String projectId ;
  final Project? project ;

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {


  @override
  void initState(){
    ProjectsCubit.get(context).getProjectData(widget.project,widget.projectId) ;
    super.initState();
  }
  final ScrollController scrollController =  ScrollController();
  final CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioCubit,PortfolioStates>(
        builder: (context,state) {
          return Scaffold(
            backgroundColor: MyColors.dark,
            body: BlocBuilder<ProjectsCubit,ProjectsStates>(
              builder: (context,state) {
                return ProjectsCubit.get(context).pickedPro !=null
                ? SafeArea(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                        horizontal: PortfolioCubit.get(context).screenSize == ScreenSize.isDesktop? 50 : 10,
                        vertical: 15
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          enableFeedback: false,
                          mouseCursor: MouseCursor.defer,
                          onTap: (){},
                          child: Container(
                            color: MyColors.darkBlue,
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                            child: Text(
                              ProjectsCubit.get(context).pickedPro!.title,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          ProjectsCubit.get(context).pickedPro!.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 20,),
                        Text(
                          'You Can Browse All App\' Screens Below',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 20,),
                        SizedBox(
                            height: 600,
                            child:  _buildIAppScreenSlider(context)
                        ),
                      ],
                    ),
                  ),
                )
                : const CircularProgressIndicator();
              }
            ),
          );
        }
    );
  }

  Widget _buildShaderMask(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20)
      ),
      child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return  const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  MyColors.purple3 ,
                  MyColors.white,
                  MyColors.purple,
                ]
            ).createShader(bounds);
          },
          child: Container(
            color: MyColors.darkBlue,
          )
      ),
    ) ;
  }

  Widget _buildIAppScreenSlider(context){
    return Stack(
      children: [
        _buildShaderMask(context),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider.builder(
                  itemCount: ProjectsCubit.get(context).pickedPro!.screens.length,
                  itemBuilder: (context, int index, int realIndex)=>_buildAppScreenWidget(context, ProjectsCubit.get(context).pickedPro!.screens[index]),
                  carouselController: buttonCarouselController,
                  options: CarouselOptions(
                    height: 400,
                    initialPage: 0,
                    viewportFraction: 1.0,// img take full width
                    //enableInfiniteScroll: true,
                    enlargeCenterPage: true,
                    reverse: false,
                    autoPlay: false,
                    // autoPlayInterval: const Duration(seconds: 3),
                    //scrollDirection: Axis.horizontal
                  )
              ),
              const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: buildImagesSmallListView(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppScreenWidget(context,AppScreen appScreen){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: PortfolioCubit.get(context).screenSize == ScreenSize.isDesktop ? 2 : 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appScreen.title,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 5,),
              Expanded(child: buildImage(appScreen.image)),
            ],
          ),
        ),
        PortfolioCubit.get(context).screenSize != ScreenSize.isMobile
            ? Expanded(flex:3,child: _buildProjectDataDialog(context, appScreen))
            : Container()
      ],
    );
  }

  Widget buildImagesSmallListView(){
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: ListViewWithSideButtons(
        scrollController: scrollController,
        listLength: ProjectsCubit.get(context).pickedPro!.screens.length,
        builder: (context,index) => InkWell(
            onTap: ()=> buttonCarouselController.animateToPage(index),
            child: buildImage(ProjectsCubit.get(context).pickedPro!.screens[index].image)
        ),
      ),
    );
  }

  Widget buildImage(url){
    return Image(
      image: NetworkImage(url),
      fit: BoxFit.contain,
      // height: 300,
    );
  }

  Widget _buildProjectDataDialog(context,AppScreen appScreen){
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        appScreen.description,
        //overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

