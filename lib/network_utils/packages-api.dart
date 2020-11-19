import 'package:tneos_eduloution/network_utils/api.dart';
import 'package:tneos_eduloution/network_utils/package.dart';

Future<List<Packages>> fetchPackages() async {
  String url = "/packages";
  // final response = await http.get(url,headers: {'connection': 'keep-alive'});
  // return packagesFromJson(response.body);
  final response = await Network().getData(url);
  return packagesFromJson(response.body);
}

