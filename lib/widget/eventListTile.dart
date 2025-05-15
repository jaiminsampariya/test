import 'package:flutter/material.dart';
import 'package:test/utility/ScalingUtility.dart';

class EventListTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final String date;

  const EventListTile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final scale = ScalingUtility(context: context)..setCurrentDeviceSize();
    return Card(
      color: Colors.white,
      margin: scale.getPadding(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: scale.getPadding(all: 8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: scale.getScaledWidth(120),
                height: scale.getScaledHeight(90),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: scale.getScaledWidth(10)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: scale.getScaledFont(14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: scale.getScaledHeight(4)),
                  Text(
                    location,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: scale.getMargin(vertical: 6),
                    width: scale.fw,
                    height: scale.getScaledHeight(10),
                    color: const Color.fromARGB(255, 246, 244, 244),
                  ),
                  SizedBox(height: scale.getScaledHeight(4)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        date.split(" at")[0],
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: scale.getScaledFont(8.4)),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star_border),
                          SizedBox(width: scale.getScaledWidth(3)),
                          Icon(Icons.ios_share),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
