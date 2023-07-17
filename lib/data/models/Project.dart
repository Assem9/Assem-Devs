import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_portfolio/data/models/app_screen_details.dart';
import 'package:my_portfolio/data/models/subject_model.dart';

class Project {
  late String iD;
  List<AppScreen> screens = [] ;
  List<Subject> subjects = [];
  late String title;
  late bool verticalScreen ;
  late String description;
  late String gitHubLink;
  late String playStoreLink;
  late String apkLink;
  late DateTime uploadDate ;

  Project({
      required this.iD,
      required this.screens,
      required this.subjects,
      required this.title,
      required this.verticalScreen,
      required this.description,
      required this.gitHubLink,
      required this.playStoreLink,
      required this.apkLink,
    required this.uploadDate,
  });

  Project.fromJson(Map<String, dynamic> json){
    iD = json['iD'];
    json['screens'].forEach((element){
      screens.add(AppScreen.fromJson(element));
    });
    json['subjects'].forEach((element){
      subjects.add(Subject.fromJson(element));
    });
    verticalScreen = json['rotatedScreen'];
    title = json['title'];
    description = json['description'];
    gitHubLink = json['gitHubLink'];
    playStoreLink = json['playStoreLink'];
    apkLink = json['apkLink'];
    Timestamp svgTimestamp = json['uploadDate'] ;
    uploadDate = svgTimestamp.toDate();
  }

  Map<String, dynamic> toMap(){
    return {
      'iD': iD,
      'screens': screens.map((e) => e.toMap()) ,
      'subjects': subjects.map((e) => e.toMap()) ,
      'title': title,
      'description': description,
      'playStoreLink': playStoreLink,
      'gitHubLink': gitHubLink,
      'apkLink': apkLink,
      'rotatedScreen':verticalScreen,
      'uploadDate': Timestamp.fromDate(uploadDate)
    };
  }

}