import 'package:get/get.dart';
import 'package:final_project/generated/locales.g.dart' as g;

class LocalizationService extends Translations {
  @override
  Map<String, Map<String, String>> get keys =>
      {'fa': g.Locales.fa_IR, 'en': g.Locales.en_US};
}
