import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_cubit.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_states.dart';
import 'package:my_portfolio/business_logic/cubits/projects_cubit/projects_cubit.dart';
import 'package:my_portfolio/data/models/Project.dart';
import 'package:my_portfolio/data/models/app_screen_details.dart';
import 'package:my_portfolio/presentation/widgets/listView_with_side_buttons.dart';
import 'package:my_portfolio/presentation/widgets/mobile_mockup.dart';
import '../../business_logic/cubits/projects_cubit/projects_states.dart';
import '../../constants/my_colors.dart';
import '../../data/models/screen_size.dart';
import '../../data/models/subject_model.dart';

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

  double getSliderWidgetHeight(context){
    bool verticalMockup= ProjectsCubit.get(context).pickedPro!.verticalScreen ;
    bool isNotMobile = PortfolioCubit.get(context).screenSize != ScreenSize.isMobile;
    if(verticalMockup){
      if(isNotMobile){
        return 700;
      }else{
        return 410;//410
      }
    }else{
      if(isNotMobile){
        return 600;
      }else{
        return 320;// 300
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioCubit,PortfolioStates>(
        builder: (context,state) {
          return Scaffold(
            backgroundColor: MyColors.darkBlack,
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
                      children: <Widget>[
                        InkWell(
                          enableFeedback: false,
                          mouseCursor: MouseCursor.defer,
                          onTap: (){},
                          child: Container(
                            color: MyColors.purple,
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
                        Stack(
                          children: [
                            _buildShaderMask(context),
                            SizedBox(
                                height: getSliderWidgetHeight(context),
                                width: 1000,
                                child:  _buildIAppScreenSlider(context)
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),

                      ]+_buildSubjectsList(ProjectsCubit.get(context).pickedPro!.subjects),
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

  Widget _buildIAppScreenSlider(context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider.builder(
              itemCount: ProjectsCubit.get(context).pickedPro!.screens.length,
              itemBuilder: (context, int index, int realIndex)
              => _buildAppScreenWidget(context, ProjectsCubit.get(context).pickedPro!.screens[index]),
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                height: getSliderWidgetHeight(context) - 120,
                initialPage: 0,
                viewportFraction: 1.0,
                enlargeCenterPage: true,
                reverse: false,
                autoPlay: false,
                // autoPlayInterval: const Duration(seconds: 3),
              )
          ),
          const SizedBox(height: 15,),
          buildImagesSmallListView(),
        ],
      ),
    );
  }

  Widget _buildShaderMask(context){
    return ShaderMask(
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
          height: getSliderWidgetHeight(context),
          width: 1000,
          decoration: BoxDecoration(
              color: MyColors.purple,
              borderRadius: BorderRadius.circular(20)
          ),
        )
    ) ;
  }

  Widget _buildAppScreenWidget(context,AppScreen appScreen){
    return SingleChildScrollView(
      child: Flex(
        direction: ProjectsCubit.get(context).pickedPro!.verticalScreen
            ? Axis.horizontal
            : Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: PortfolioCubit.get(context).screenSize != ScreenSize.isMobile ? null : 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  appScreen.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.white),
                ),
                PortfolioCubit.get(context).screenSize == ScreenSize.isDesktop
                    ? _buildProjectDataDialog(context, appScreen)
                    : Container()
              ],
            ),
          ),
          const SizedBox(width: 20,),
          const SizedBox(height: 10,),
          Flexible(child: buildImage(appScreen.image)),

        ],
      ),
    );
  }

  Widget buildImagesSmallListView(){
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: PortfolioCubit.get(context).screenSize != ScreenSize.isMobile? 80.0 :10,
        vertical: 2
      ),
      decoration: BoxDecoration(
          color: MyColors.purple3,
        borderRadius: BorderRadius.circular(10)
      ),
      height: PortfolioCubit.get(context).screenSize != ScreenSize.isMobile? 85 : 45,
      width: double.infinity,
      child: ListViewWithSideButtons(
        sideWidth: 40,
        scrollController: scrollController,
        listLength: ProjectsCubit.get(context).pickedPro!.screens.length,
        builder: (context,index) => InkWell(
            onTap: ()=> buttonCarouselController.animateToPage(index),
            child: Image(
                image: NetworkImage(ProjectsCubit.get(context).pickedPro!.screens[index].image)
            ) 
        ),
      ),
    );
  }

  Widget buildImage(url){
    bool rotate =ProjectsCubit.get(context).pickedPro!.verticalScreen ;
    double h =  PortfolioCubit.get(context).screenSize != ScreenSize.isMobile ?580 :580/2 ;
    double w =  PortfolioCubit.get(context).screenSize != ScreenSize.isMobile ?250 :250/2 ;
    return MobileMockupWidget(
      width: w,
      height: h,
      image: url,
      rotate: rotate,
    );
  }

  Widget _buildProjectDataDialog(context,AppScreen appScreen){
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        appScreen.description,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  List<Widget> _buildSubjectsList(List<Subject> subjects){
    return subjects.map((subject) => _buildSubjectWidget(subject)).toList();
  }

  Widget _buildSubjectWidget(Subject subject){
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      decoration: const BoxDecoration(
        color: MyColors.darkBlack,
        boxShadow: [
          BoxShadow(
            color: MyColors.purple,
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(2, -2),
          ),
          BoxShadow(
            color: MyColors.purple,
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(2, -2.5),
          ),
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: MyColors.purple,
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
            child: Text(
              subject.title,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(color: MyColors.white),
            ),
          ),

          const SizedBox(height: 10,),
          Text(
            subject.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ] + _buildSubjectPointsList(subject.points),
      ),
    );
  }

  List<Widget> _buildSubjectPointsList(List<String> points){
    return points.map((point) => Text(
      '* $point',
      style: Theme.of(context).textTheme.bodyMedium,
    )).toList();
  }

}

