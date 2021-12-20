import 'package:equatable/equatable.dart';
import 'package:exampur_mobile/models/book.dart';

class BookState extends Equatable {
  const BookState();

  @override
  List<Object> get props => [];
}

class BookEmpty extends BookState {}

class BookLoading extends BookState {}

class BookLoaded extends BookState {
  final BookList bookList;

  const BookLoaded({required this.bookList});

  @override
  List<Object> get props => [bookList];
}

class BookError extends BookState {}
