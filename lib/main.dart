import 'package:flutter/material.dart';
import 'package:conference_list/list_screen.dart';
import 'package:conference_list/conference.dart';
import 'dart:convert';
import 'dart:io';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FutureBuilder<List<Conference>>(
            future: fetchConferences(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List<Conference> conferences = snapshot.data!;
                  return ConferenceListScreen(conferences);
                } else {
                  return Text('No upcoming Conferences');
                }
              } else {
                return CircularProgressIndicator();
              }
            },
          )
        ),
      ),
    );
  }
}

// Bypass SSL Certification Check
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

// Fetch conference details from API
Future<List<Conference>> fetchConferences() async {
  HttpClient httpClient = HttpClient();
  //httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  List<Conference> conferences = [];

  try {
    String url = 'https://gdscdev.vercel.app/api';
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();

    if (response.statusCode == 200) {
      String responseBody = await response.transform(utf8.decoder).join();
      Map<String, dynamic> data = json.decode(responseBody);
      int count = data['content']['meta']['total'] as int;
      for (var i = 0; i < count; i++) {
        Conference temp = Conference.fromJson(data['content']['data'][i]);
        conferences.add(temp);
      }
    } else {
      debugPrint('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error: $e');
  } finally {
    httpClient.close();
  }
  return conferences;
}

