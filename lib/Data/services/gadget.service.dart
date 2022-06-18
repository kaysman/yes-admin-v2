import 'package:admin_v2/Data/models/response.dart';
import 'package:admin_v2/Data/services/api_client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

class GadgetService {
  static Future<ApiResponse> createHomeGadget(
    List<FilePickerResult> files,
    Map<String, String> fields,
  ) async {
    var uri = Uri.parse(baseUrl + '/gadgets/create/home');
    try {
      print(fields);
      var res = await ApiClient.instance.multiPartRequest(
        uri,
        files
            .map((e) => MultipartFile.fromBytes(
                  'files',
                  e.files.first.bytes!.toList(),
                  filename: e.names.first,
                  // contentType: MediaType("image", "xlsx"),
                ))
            .toList(),
        fields: fields,
      );
      return res;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
