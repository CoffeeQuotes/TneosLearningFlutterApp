import 'package:tneos_eduloution/network_utils/api.dart';
import 'package:tneos_eduloution/network_utils/live.dart';

Future<dynamic> fetchPaidLive(userId) async {
  String url = "/paidlive/";
  String _url = url + userId.toString();
  final response = await Network().getData(_url);
  return livesFromJson(response.body);
}

Future<dynamic> fetchCatPaidLive(catId) async {
  String url = "/paidlive/category/";
  String _url = url + catId.toString();
  final response = await Network().getData(_url);
  return livesFromJson(response.body);
}