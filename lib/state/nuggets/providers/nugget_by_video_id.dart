import 'package:nugget_berg/state/constants.dart';
import 'package:nugget_berg/state/nuggets/models/nugget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
part 'nugget_by_video_id.g.dart';

@riverpod
FutureOr<Nugget?> nuggetByVideoId(NuggetByVideoIdRef ref, String videoId) async {
  var response = await http
      .get(Uri.parse('${Constants.baseUrl}/summary?videoId=$videoId'));
  if(response.statusCode != 200) return null;
  return Nugget.fromJson(response.body);
}
