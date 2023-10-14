part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchText extends SearchEvent {
  final String text;

  const SearchText({
    required this.text,
  });

  @override
  List<Object?> get props => [];
}
