import 'package:my_portfolio/data/models/subject_model.dart';

class Subject{
  late String title;
  late String description;
  late SubjectType type ;
  List<String> points = [];

  Subject({
    required this.title,
    required this.description,
    this.type = SubjectType.costume,
    required this.points});

  Subject.fromJson(Map<String, dynamic> json){
    title = json['title'];
    description = json['description'];
    type = SubjectTypeX.fromDbCode(json['type']) ;
    json['points'].forEach((element){
      points.add(element);
    });
  }

  Map<String, dynamic> toMap(){
    return {
      'title': title,
      'description': description,
      'points':points,
      'type' : type.toJson()
    };
  }
}

enum SubjectType{
  costume,
  appFeatures,
  developmentInfo,
  libraries,
}

extension SubjectTypeX on SubjectType {

  String toJson() {
    switch(this){
      case SubjectType.costume:
        return 'Costume' ;
      case SubjectType.appFeatures :
        return 'Features' ;
      case SubjectType.developmentInfo :
        return 'Development Info' ;
      case SubjectType.libraries :
        return 'Libraries' ;
    }
  }

  static SubjectType fromDbCode(String json){
    switch(json){
      case 'Costume':
        return SubjectType.costume ;
      case 'Features':
        return SubjectType.appFeatures ;
      case 'Development Info' :
        return SubjectType.developmentInfo  ;
      case 'Libraries' :
        return SubjectType.libraries ;
      default:
        return SubjectType.costume;

    }
  }
}