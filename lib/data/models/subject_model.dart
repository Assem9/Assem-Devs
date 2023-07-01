class Subject{
  late String title;
  late String description;
  List<String> points = [];

  Subject.fromJson(Map<String, dynamic> json){
    title = json['title'];
    description = json['description'];
    json['points'].forEach((element){
      points.add(element);
    });
  }

  Map<String, dynamic> toMap(){
    return {
      'title': title,
      'description': description,
      'points':points,
    };
  }
}