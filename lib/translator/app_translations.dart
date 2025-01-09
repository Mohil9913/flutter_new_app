import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'hello': 'Hello',
          'news app': 'News App',
          'No news available.': '',
        },
        'hi': {
          'hello': 'नमस्कार',
          'news app': 'समाचार ऐप',
          'No news available.': 'कोई समाचार उपलब्ध नहीं है.',
        },
        'gu': {
          'hello': 'હેલો',
          'news app': 'સમાચાર એપ્લિકેશન',
          'No news available.': 'કોઈ સમાચાર ઉપલબ્ધ નથી.',
        },
      };
}
