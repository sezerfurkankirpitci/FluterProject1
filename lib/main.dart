import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project1/widgets/cardWidget.dart';

void main() {
  runApp(JobSwire());
}

class JobSwire extends StatelessWidget {
  const JobSwire({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Jobs>> _getJobs() async {
    var data = await http.get(Uri.parse("https://remoteok.io/api"));
    var jsonData = json.decode(data.body);
    List<Jobs> jobs = [];
    for (int i=1;i<jsonData.length;i++) {
      print(i);
      print(jsonData.length);
      print(jsonData[i]["position"]);
      Jobs job = Jobs(
        jsonData[i]["date"],
        jsonData[i]["position"],
        jsonData[i]["tags"],
        jsonData[i]["logo"],
        jsonData[i]["description"],
        jsonData[i]["location"],
      );
      print("Eklendi");
      jobs.add(job);
    }
    print(jobs.length);
    return jobs;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: FutureBuilder(
          future: _getJobs(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text('Loading...'),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardWidget(
                        snapshot.data[index].position,
                        snapshot.data[index].logo,
                        snapshot.data[index].location,
                        snapshot.data[index].tags,
                        snapshot.data[index].date);
                  });
            }
          }),
    ));
  }
}

class Jobs {
  final String date;
  final String position;
  final List tags;
  final String logo;
  final String description;
  final String location;

  Jobs(
      this.date,
      this.position,
      this.tags,
      this.logo,
      this.description,
      this.location,);
}
