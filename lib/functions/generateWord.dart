import 'dart:convert';
import 'dart:io';

Future<void> loadJsonFromFile() async {
  String filePath = 'lib/data/Lexique382.json';
  String jsonString = await File(filePath).readAsString();
  final jsonResponse = json.decode(jsonString);
  final test = jsonResponse.map((e) => e['ortho']).toList();
  var unique = Set.from(test).toList();
  print('${unique.length}    ${test.length}');
  //print(jsonResponse.map((e) => ));
}

void main(){
  loadJsonFromFile();
}
