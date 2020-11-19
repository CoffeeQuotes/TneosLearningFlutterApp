import 'package:tneos_eduloution/network_utils/api.dart';
import 'profile.dart';

Future<dynamic> fetchProfile(userId) async {
  String url = "/user/profile/";
  String _url = url + userId.toString();
  final response = await Network().getData(_url);
  return profileFromJson(response.body);
}