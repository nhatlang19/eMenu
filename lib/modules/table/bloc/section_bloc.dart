import 'package:bloc/bloc.dart';
import 'package:emenu/models/section.dart';
import 'package:emenu/repositories/section_repository.dart';
import 'package:equatable/equatable.dart';

part 'section_event.dart';
part 'section_state.dart';

class SectionBloc extends Bloc<SectionEvent, SectionState> {
  final SectionRepository _sectionRepository;

  SectionBloc(
      {required SectionRepository sectionRepository,
})
      : _sectionRepository = sectionRepository,
        super(const SectionState()) {
    on<FetchSection>(_onFetchSections);
    on<ChangeSection>(_onChangeSection);
  }

  Future<void> _onFetchSections(FetchSection event, Emitter<SectionState> emit) async {
    try {
      if (state.status == SectionStatus.initial) {
        List<Section> sections = await _sectionRepository.getSection();
        emit(state.copyWith(sections: sections, status: SectionStatus.success, section: sections.first.section));
      }
    } catch (_) {
      emit(state.copyWith(status: SectionStatus.failure));
    }
  }

  void _onChangeSection(ChangeSection event, Emitter<SectionState> emit) {
    emit(state.copyWith(section: event.section, status: SectionStatus.changed));
  }
}
