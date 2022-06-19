import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String? time;
  String flag;
  String url;
  bool? isDayTime;

  WorldTime(
      {required this.location,
      this.time,
      required this.flag,
      required this.url,
      this.isDayTime});

  Future<void> getTime() async {
    try {
      Response responce =
          await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(responce.body);
      // print(data);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      // print(datetime);
      // print(offset);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught error $e');
      time = 'could not get time data';
    }
  }
}
