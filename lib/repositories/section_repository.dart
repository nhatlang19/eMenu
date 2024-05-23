import 'dart:async';

import 'package:emenu/models/section.dart';
import 'package:emenu/providers/section_provider.dart';


enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class SectionRepository {
  Future<List<Section>> getSection({
    required String section
  }) async {
    final provider = SectionProvider();

    var json = await provider.getSection(section);
    final List<Section> result = [];
    json.forEach((json) {
      result.add(Section.fromJson(json['Table'] as Map<String, dynamic>));
    });
     
    return result;
  }
}
