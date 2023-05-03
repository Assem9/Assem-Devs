import 'package:my_portfolio/data/models/aboutMe.dart';

class PersonalData {
  late String portfolioTitle ;
  late String facebook ;
  late String gmail ;
  late String whatsApp ;
  late String instagram ;
  late String aboutMeParagraph ;
  List<Job> jobs = [];


  PersonalData({
    required this.portfolioTitle,
    required this.facebook,
    required this.whatsApp,
    required this.instagram,
    required this.gmail,
}) ;
  PersonalData.fromJson(Map<String, dynamic> json){
    portfolioTitle = json['portfolio_title'];
    facebook = json['facebook'];
    whatsApp = json['whatsapp'];
    instagram = json['instagram'];
    gmail = json['gmail'];
    aboutMeParagraph = json['about'];
    json['jobs'].forEach((element){
      jobs.add(Job.fromJson(element));
    });
  }

  Map<String, dynamic> toMap(){
    return {
      'portfolio_title': portfolioTitle,
      'gmail': gmail,
      'whatsapp': whatsApp,
      'instagram': instagram,
      'facebook': facebook,
      'about': aboutMeParagraph,
      'jobs': jobs.map((x) => x.toMap()).toList(),
    };
  }


}