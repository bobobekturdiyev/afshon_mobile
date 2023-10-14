part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class LoadingSearch extends SearchState {
  @override
  List<Object> get props => [];
}

class LoadedSearch extends SearchState {
  final List<Object3Ddto> objects;

  const LoadedSearch({
    required this.objects,
  });

  @override
  List<Object> get props => [];
}

class ErrorSearch extends SearchState {
  final String message;

  const ErrorSearch({required this.message});

  @override
  List<Object?> get props => [message];
}
