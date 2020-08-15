import 'dart:convert';
import 'dart:io';
import 'package:loginapp/core/models/course.dart';
import 'package:http/http.dart' as http;

class FirebaseService{
  static FirebaseService  firebaseInstance = FirebaseService._private();
  static const String FIREBASE_URL = "https://fir-uusage.firebaseio.com/";
  int _numberOfCourse ;
  int _lastAddedIndex;
  int get numberOfCourses => _numberOfCourse;
  int get lastAddedIndex => _lastAddedIndex;
  static FirebaseService get prefInstance => firebaseInstance;

  FirebaseService._private();


  Future<List<Course>> getCourses() async {
    final response = await http.get("$FIREBASE_URL/courses.json");
    switch (response.statusCode) {
      case HttpStatus.ok:
        final decodedJson = json.decode(response.body); //becomes firebase returns map list, decodedJson[0]['grade]
        List<Course> courseList = List();
        for(int i = 0;i<decodedJson.length;i++){
          if(decodedJson[i] != null){
            Course course = Course();
            print(decodedJson[i]['grade']);
            course.name = decodedJson[i]['name'];
            course.grade = decodedJson[i]['grade'];
            courseList.add(course);
          }
        }
        _numberOfCourse = courseList.length;
        print(_numberOfCourse);
        //takes all elements in decodedjson one by one creates an course object  and hold them as list
        return courseList;
      default:
        return Future.error(response.statusCode);
    }
  }

  Future<bool> putCourse(Course course) async {
    //int indexToPut = SharedAppData.numberOfCourses;
    Map<String, String> headers = {"Content-type": "application/json"};
    var msg = json.encode(course.toJson());
    final response = await http.put("$FIREBASE_URL/courses/$numberOfCourses.json",headers: headers,body: msg);
    print(response.statusCode);
    switch (response.statusCode) {
      case HttpStatus.ok:
        return true;
      default:
        return false;
    }
  }
  Future<bool> postCourse(Course course) async {
    //int indexToPut = SharedAppData.numberOfCourses;
    Map<String, String> headers = {"Content-type": "application/json"};
    var msg = json.encode(course.toJson());
    final response = await http.post("$FIREBASE_URL/courses/$numberOfCourses.json",headers: headers,body: msg);
    print(response.statusCode);
    switch (response.statusCode) {
      case HttpStatus.ok:
        return true;
      default:
        return false;
    }
  }

  Future<bool> deleteCourse(int index) async {
    //int indexToPut = SharedAppData.numberOfCourses;
    Map<String, String> headers = {"Content-type": "application/json"};
    final response = await http.delete("$FIREBASE_URL/courses/$index.json",headers: headers);
    print(response.statusCode);
    switch (response.statusCode) {
      case HttpStatus.ok:
        return true;
      default:
        return false;
    }
  }
}