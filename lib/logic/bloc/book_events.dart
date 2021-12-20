import 'package:equatable/equatable.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();
}

class FetchBook extends BookEvent {
  const FetchBook();

  @override
  List<Object> get props => [];
}