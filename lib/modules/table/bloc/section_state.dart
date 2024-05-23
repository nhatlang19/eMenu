part of 'section_bloc.dart';

enum SectionStatus { initial, success, failure, changed }

final class SectionState extends Equatable {
  const SectionState({
    this.status = SectionStatus.initial,
    this.sections = const <Section>[],
    this.section = ''
  });

  final SectionStatus status;
  final List<Section> sections;
  final String section;

  SectionState copyWith({
    SectionStatus? status,
    List<Section>? sections,
    String? section
  }) {
    return SectionState(
      status: status ?? this.status,
      sections: sections ?? this.sections,
      section: section ?? this.section,
    );
  }
  @override
  List<Object> get props => [status, sections, section];
}
