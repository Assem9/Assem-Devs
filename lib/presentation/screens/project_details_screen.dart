import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_cubit.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_states.dart';
import 'package:my_portfolio/business_logic/cubits/projects_cubit/projects_cubit.dart';
import 'package:my_portfolio/data/firestore_services/admin_data_services.dart';
import 'package:my_portfolio/data/models/Project.dart';
import 'package:my_portfolio/data/models/app_screen_details.dart';
import 'package:my_portfolio/data/repositories/admin_repository.dart';
import 'package:my_portfolio/presentation/widgets/listView_with_side_buttons.dart';
import 'package:my_portfolio/presentation/widgets/mobile_mockup.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../business_logic/cubits/projects_cubit/projects_states.dart';
import '../../utils/my_colors.dart';
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
      buildWhen: (previous,current)=> current is ScreenSizeChanged,
        builder: (context,state) {
          return Scaffold(
            body: BlocBuilder<ProjectsCubit,ProjectsStates>(
              builder: (context,state) {
               // print('project builder');
                return ProjectsCubit.get(context).pickedPro !=null
                ? SafeArea(
                  child: Center(
                    child: SizedBox(
                      width: PortfolioCubit.get(context).screenSize == ScreenSize.isDesktop
                          ? MediaQuery.of(context).size.width * 0.8
                          : double.infinity,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
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
                              onTap: ()async{
                                /*
                                /// just in testing
                                print(ProjectsCubit.get(context).pickedPro!.title);
                             //   print(widget.project!.title);
                                AdminRepository(AdminDataServices()).updateProjectData(
                                  ProjectsCubit.get(context).pickedPro!
                                ).then((value) => debugPrint('updated')) ;*/
                              },
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
                                //_buildShaderMask(context),
                                ColorFiltered(
                                  colorFilter: const ColorFilter.mode(MyColors.purple, BlendMode.modulate),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: MyColors.purple1,
                                        borderRadius: BorderRadius.circular(20),
                                        image: const DecorationImage(
                                            image: AssetImage('assets/images/code_background.jpg'),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                    height: getSliderWidgetHeight(context),
                                    width: 1000,
                                  ),
                                ),
                                SizedBox(
                                    height: getSliderWidgetHeight(context),
                                    width: 1000,
                                    child:  _buildIAppScreenSlider(context)
                                ),
                              ],
                            ),
                            const SizedBox(height: 20,),
                            _buildProjectLinksLauncher(context, ProjectsCubit.get(context).pickedPro!),
                            const SizedBox(height: 20,),
                          ]+_buildSubjectsList(ProjectsCubit.get(context).pickedPro!.subjects),
                        ),
                      ),
                    ),
                  ),
                )
                :   Center(child: Image.asset(
                    'assets/images/dots_loader.gif',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/2,
                ));
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
              => _buildProjectImage(ProjectsCubit.get(context).pickedPro!.screens[index]),
                //  _buildAppScreenWidget(context, ProjectsCubit.get(context).pickedPro!.screens[index]),
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

  Widget _buildProjectImage(AppScreen screen){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 2,color: MyColors.purple),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image(image: NetworkImage(screen.image) ,
          fit: BoxFit.contain),
      ),
    );
  }

  Widget _buildProjectLinksLauncher(context,Project project){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('You Can Find The App in :',style: Theme.of(context).textTheme.titleMedium,),
          const SizedBox(height: 10),
          Container(
            height: 95,
            padding: const EdgeInsets.all(10),
            // color: MyColors.purple3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                project.playStoreLink.isNotEmpty ?
                InkWell(
                    onTap: ()async{
                      var url = Uri.parse(project.playStoreLink);
                      await launchUrl(url,mode: LaunchMode.externalApplication);
                    },
                    child: _buildIconWidget(context: context, title: 'Playstore', icon: MdiIcons.googlePlay)
                ) : Container(),
                const SizedBox(width:8,),
                project.gitHubLink.isNotEmpty ?
                InkWell(
                  onTap: ()async{
                    var url = Uri.parse(project.gitHubLink);
                    await launchUrl(url,mode: LaunchMode.externalApplication);
                  },
                  child: _buildIconWidget(context: context, title: 'GitHub', icon: MdiIcons.github)
                ) : Container(),
                const SizedBox(width:8,),
                project.apkLink.isNotEmpty ?
                InkWell(
                  onTap: ()async{
                    var url = Uri.parse(project.apkLink);
                    await launchUrl(url,mode: LaunchMode.externalApplication);
                  },
                  child:_buildIconWidget(context: context, title: 'Website', icon: MdiIcons.web)

                ) : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconWidget({required context,required String title, required IconData icon}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Icon(
            icon,
            size: PortfolioCubit.get(context).screenSize != ScreenSize.isMobile
                ? MediaQuery.of(context).size.width/30
                : MediaQuery.of(context).size.width/12,
          ),
          const SizedBox(height: 4,),
          Text(title,style: Theme.of(context).textTheme.titleSmall,)
        ],
      ),
    );
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
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/image_loader.gif',
              image: ProjectsCubit.get(context).pickedPro!.screens[index].image,
              fit: BoxFit.contain,
                placeholderFit:BoxFit.cover,
            ),

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
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: const [
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
      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                getSubjectSvg(subject),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/3,
                placeholderBuilder: (context)=> Image.asset('assets/images/ballons_loader.gif'),
              ),
            ),
          ),
          Container(
            width: PortfolioCubit.get(context).screenSize == ScreenSize.isDesktop
              ? MediaQuery.of(context).size.width /2
              :  MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10)
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
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSubjectPointsList(List<String> points){
    return points.map((point) => Row(
     // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.circle, size: 10,),
        const SizedBox(width: 10,),
        Expanded(
          child: Text(
            point,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    )).toList();
  }

  String getSubjectSvg(Subject subject){
    switch(subject.type){
      case SubjectType.costume:
        return 'assets/images/info_tab.svg';
      case SubjectType.appFeatures:
        return 'assets/images/app_features.svg';
      case SubjectType.developmentInfo:
        return 'assets/images/coder.svg';
      case SubjectType.libraries:
        return 'assets/images/code_typeing.svg';

    }
  }

}

