import 'package:conference_list/conference.dart';
import 'package:flutter/material.dart';
import 'details_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mime/mime.dart';

// Scrollable lists containing list of conferences
class ConferenceListScreen extends StatelessWidget {
  final List<Conference> conferences;
  ConferenceListScreen(this.conferences);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upcoming Conferences')),
      body: ListView.builder(
        itemCount: conferences.length,
        itemBuilder: (ctx, index) {
          return ConferenceListItem(conference: conferences[index]);
        },
      ),
    );
  }
}

// Widget to display data of each list item
class ConferenceListItem extends StatelessWidget {
  final Conference conference;

  ConferenceListItem({required this.conference});

  // Checking if image format is '.svg'
  Widget getImage() {
    if (conference.organiserIcon.contains('svg')) {
      return SvgPicture.network(
        conference.organiserIcon,
        height: 60,
        width: 60
      );
    }
    else {
      return Image.network(
        conference.organiserIcon,
        height: 60,
        width: 60
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ConferenceDetailScreen(conference)),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Banner Image
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  conference.bannerImage,
                  fit: BoxFit.cover
                ),
              ),
              // Conference Title
              Positioned(
                bottom: 10,
                left: 10,
                child: Text(
                  conference.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Conference Icon
              Positioned(
                  top: 10,
                  left: 10,
                  child: (
                      getImage()
                      /**Image.network(
                      conference.organiserIcon,
                      width:60,
                      height:60
                    )**/
                  )
              )
            ],
          ),
        ),
      );
    }
  }
