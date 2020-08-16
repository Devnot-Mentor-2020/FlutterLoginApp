import 'package:loginapp/core/models/course.dart';
import 'package:loginapp/core/services/firebase_course_service.dart';
import 'file:///C:/Users/Alperen/IdeaProjects/loginapp/lib/view/course_view/course_form_view.dart';
import 'package:flutter/material.dart';

class CourseHomePage extends StatefulWidget {
  final credit = 3;
  @override
  _FireHomeViewState createState() => _FireHomeViewState();
}

class _FireHomeViewState extends State<CourseHomePage> {
  Future<List<Course>> _courseList;
  double average = 0;
  List<Course> courseList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _courseList = FirebaseService.prefInstance.getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _floatingActionButtonRefresh(),
      appBar: AppBar(title: Text("Course App"),),
      body: Column(
        children: <Widget>[
          CourseFormView(),
          Container(
            width: 250,
            child: Text("Average :" +average.toStringAsFixed(2),textScaleFactor: 2,),
          ),
          Expanded(child: _courseFutureBuilder),
        ],
      )
    );
  }

  Widget _floatingActionButtonRefresh (){
    return FloatingActionButton.extended(
      icon: Icon(Icons.refresh),
      label: Text("Refresh"),
      backgroundColor: Colors.green,
      onPressed:() async{
         refreshList();
         courseList = await _courseList;
         setState(() {
           calculateAverage(courseList);
         });

      }
    );
  }

   Future<void> refreshList() async {
    setState(() {
      _courseList = FirebaseService.firebaseInstance.getCourses();

    });

  }

  Widget get _courseFutureBuilder =>FutureBuilder(
      future:_courseList,
      builder: (context, snapshot){
    //whatever returns from this function, will be avaliable inside snapshot paremeter.
    courseList  = snapshot.data;
    switch (snapshot.connectionState) {
      case ConnectionState.waiting:
        {
          return _waitingState();
        }
      case ConnectionState.done:
        if (snapshot.hasData) {
          return _courseListBuilder(courseList);
        }
        return Text("Error occured");

      default:
        return _waitingState();
    }
  });

  Center _waitingState() => Center(child: CircularProgressIndicator(),);

  Widget _courseListBuilder(List<Course> list){
    return ListView.builder(itemCount: list.length,
        itemBuilder: (context, index) {
          return _courseCard(list, index);
        });
  }

  Dismissible _courseCard(List<Course> courseList, int index) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) async {
        await FirebaseService.prefInstance.deleteCourse(courseList.elementAt(index));
        courseList.remove(courseList[index]);
        setState(() {
          calculateAverage(courseList);
        });
      },
      child: Card(
        elevation: 4,
        child: ListTile(
          title: Text(courseList.elementAt(index).name),
          subtitle: Text(courseList.elementAt(index).grade),
        ),
      ),
    );
  }

  void _calculateCourseGrade(Course course){
    switch (course.grade){
      case "AA":
        course.gradeValue = 4.0;
        break;
      case "BA":
        course.gradeValue = 3.5;
        break;
      case "BB":
        course.gradeValue = 3.0;
        break;
      case "CB":
        course.gradeValue = 2.5;
        break;
      case "CC":
        course.gradeValue = 2.0;
        break;
      case "DC":
        course.gradeValue = 1.5;
        break;
      case "DD":
        course.gradeValue = 1.0;
        break;
      case "FD":
        course.gradeValue = 0.5;
        break;
      case "FF":
        course.gradeValue = 0.0;
        break;
      default:
        return null;
    }
  }

  void calculateAverage(List<Course> courseList){
    average = 0;
    for(Course course in courseList){
      _calculateCourseGrade(course);
      average += course.gradeValue*widget.credit;
    }
    average /= widget.credit*courseList.length;

  }
}