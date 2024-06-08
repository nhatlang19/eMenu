part of 'section_bloc.dart';

sealed class SectionEvent extends Equatable {
  const SectionEvent();

  @override
  List<Object> get props => [];
}

class FetchSection extends SectionEvent {

  const FetchSection();
}

class ChangeSection extends SectionEvent {
  final String section;

  const ChangeSection({required this.section});
}