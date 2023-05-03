
class Job{
  late String title ;
  late String svg ;

  Job.fromJson(Map<String, dynamic> json){
    title = json['title'];
    svg = json['svg'];

  }

  Map<String, dynamic> toMap(){
    return {
      'svg': svg,
      'title': title,
    };
  }
}