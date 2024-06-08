import 'dart:async';

import 'package:emenu/models/section.dart';
import 'package:emenu/providers/section_provider.dart';


class SectionRepository {
  Future<List<Section>> getSection() async {
    final provider = SectionProvider();

    var json = await provider.getSection();
    final List<Section> result = [];
    json.forEach((json) {
      result.add(Section.fromJson(json['Table'] as Map<String, dynamic>));
    });
     
    return result;
  }
}
