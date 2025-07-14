import 'dart:convert';

class DeleteMultiProductModel {
  final List<int> ids;

  DeleteMultiProductModel({
    required this.ids,
  });

  Map<String, String> toJson() => <String, String>{
        'ids': json.encode(this.ids),
      };
}
