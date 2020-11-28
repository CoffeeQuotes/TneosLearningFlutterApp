import 'package:tneos_eduloution/network_utils/api.dart';
import 'package:tneos_eduloution/network_utils/live.dart';
import 'package:tneos_eduloution/network_utils/subscription.dart';

Future<List<Lives>> fetchLives() async {
  String url = "/showlive";
  // final response = await http.get(url,headers: {'connection': 'keep-alive'});
  // return livesFromJson(response.body);
  final response = await Network().getData(url);
  return livesFromJson(response.body);
}

Future<List<Lives>> fetchBoardLives($board) async {
  String _url = "/showlive/board/";
  String url = _url + $board;
  final response = await Network().getData(url);
  return livesFromJson(response.body);
}

Future<List<Subscriptions>> fetchSubscription($userId) async {
  String _url = "/subscription/list/";
  String url = _url + $userId.toString();
  final response = await Network().getData(url);
  return subscriptionsFromJson(response.body);
}
