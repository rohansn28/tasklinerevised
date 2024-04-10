import 'dart:convert';
import 'package:games/model/applink.dart';
import 'package:games/variables/local_variables.dart';
import 'package:games/variables/modal_variable.dart';
import 'package:http/http.dart' as http;

Future<List<Applink>> fetchclicklinks(String endpoint) async {
  var url = Uri.parse("$baseUrl$basePostFix$endpoint");

  var response = await http.get(url);

  List<Applink> applinks = applinkFromJson(response.body);

  return applinks;
}

Future<String> fetchButtonLinks(String endpoint) async {
  var url = Uri.parse("$baseUrl$basePostFix$endpoint");

  var response = await http.get(url);

  if (response.statusCode == 200) {
    otherLinksModel = OtherLinksModel.fromJson(jsonDecode(
        response.body.toString())); //otherLinksModel.otherlinks![0].link
    if (otherLinksModel.otherlinks![0].link.trim() == '1') {
      objLive = true;
    }
    return response.body;
  } else {
    return "0";
    //check connection
  }
}

Future<void> sendDeviceIdToBackend(String deviceID, String coins) async {
  const url = 'https://loungecard.website/public/api/register';

  // final headers = {
  //   'Content-Type': 'application/json',
  //   // Add any additional headers if required
  // };
  // final body = json.encode({
  //   'name': deviceID,
  //   'coins': '20',
  //   // You can include additional data if needed
  // });

  try {
    final response = await http.post(
      Uri.parse(url),
      // headers: headers,
      body: {
        'name': deviceID,
        'coins': coins,
      },
    );

    if (response.statusCode == 200) {
      // Registration successful
      print('Device ID sent successfully!');
    } else {
      // Registration failed
      print('Failed to send device ID. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error sending device ID: $e');
  }
}

Future<void> updateCoins(String deviceID, String coins) async {
  const url = 'https://loungecard.website/public/api/update-coins';

  try {
    final response = await http.post(
      Uri.parse(url),
      // headers: headers,
      body: {
        'name': deviceID,
        'coins': coins,
      },
    );

    if (response.statusCode == 200) {
      print('Device ID sent successfully!');
    } else {
      print('Failed to send device ID. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error sending device ID: $e');
  }
}
