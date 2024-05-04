import 'package:get/get.dart';

class Message extends Translations {
  
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': _english,
        'km_KH': _khmer,
      };

  final Map<String, String> _english = {
    'hello': 'Hello',
  };

  final Map<String, String> _khmer = {
    'hello': 'សួស្តី',
  };
}
