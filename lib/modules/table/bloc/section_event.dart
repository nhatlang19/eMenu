part of 'section_bloc.dart';

sealed class SectionEvent extends Equatable {
  const SectionEvent();

  @override
  List<Object> get props => [];
}

class FetchSection extends SectionEvent {
  final String section;

  const FetchSection({required this.section});
}

class ChangeSection extends SectionEvent {
  final String section;

  const ChangeSection({required this.section});
}