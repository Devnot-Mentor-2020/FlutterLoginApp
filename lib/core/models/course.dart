class Course {
  String key;
  String grade;
  String name;

  Course({this.key, this.grade, this.name});

  Course.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    grade = json['grade'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['grade'] = this.grade;
    data['name'] = this.name;
    return data;
  }
}
