import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => Search(),
    '/results': (context) => Result(),
  },
));

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  String pinController = '110001';
  String dateController = '01-01-2022';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Enter pincode'),
            TextField(
              onChanged: (v) => pinController = v,
            ),
            Text('Enter date (dd-mm-yyyy'),
            TextField(
              onChanged: (v) => dateController = v,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/results');
        },
      ),
    );
  }
}

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {

  final String pincode = $pinControlle;
  final String date = $dateController;

  var hospital;
  var from_time;
  var to_time;
  var capacity;
  var dose1;
  var dose2;
  var fee;
  var min_age;
  var type;

  Future getData() async {
    var url = Uri.parse('https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=$pincode&date=$date');

    http.Response response = await http.get(url);
    var results = json.decode(response.body);
    print(results.toString());

    setState(() {
      hospital = results["sessions"]["name"];
      from_time = results['sessions'][0]['from'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Vaccination Centres'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey[700],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Hospital: '),
                Text(
                  hospital != null ? hospital.toString() : "Loading...",
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Time of Starting: '),
                Text(
                  from_time != null ? from_time.toString() : "Loading...",
                ),
              ],
            )
          ],
        )
    );
  }
}
