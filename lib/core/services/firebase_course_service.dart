import 'dart:convert';
import 'dart:io';
import 'package:loginapp/core/models/course.dart';
import 'package:http/http.dart' as http;

class FirebaseService{
  static FirebaseService  firebaseInstance = FirebaseService._private();
  static const String FIREBASE_URL = "https://fir-uusage.firebaseio.com/";
  int _numberOfCourse ;
  int get numberOfCourses => _numberOfCourse;
  static FirebaseService get prefInstance => firebaseInstance;

  FirebaseService._private();


  Future<List<Course>> getCourses() async {
    final response = await http.get("$FIREBASE_URL/courses.json");
    switch (response.statusCode) {
      case HttpStatus.ok:
        final decodedJson = json.decode(response.body) as List; //becomes firebase returns map list, decodedJson[0]['grade]
        List<Course> courseList =decodedJson.map((jsonMap) => Course.fromJson(jsonMap)).toList();
        _numberOfCourse = courseList.length;
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
}