import 'package:conference_list/conference.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Widget to display details of conference
class ConferenceDetailScreen extends StatelessWidget {
  final Conference conference;

  ConferenceDetailScreen(this.conference);

  @override
  Widget build(BuildContext context) {
    // Extracting date and time
    final DateTime parsedDateTime = DateTime.parse(conference.dateTime);
    final formattedDateTime = DateFormat.yMMMMd('en_US').add_jm().format(parsedDateTime);

    return Scaffold(
      appBar: AppBar(
        title: Text('Conference Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              conference.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Organized by: ${conference.organiserName}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Image.network(
              conference.bannerImage
            ),
            SizedBox(height: 10),
            Text(
              conference.description,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Date & Time: ${formattedDateTime}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Venue: ${conference.venueName}, ${conference.venueCity}, ${conference.venueCountry}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}