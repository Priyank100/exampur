import 'package:bloc/bloc.dart';
import 'package:exampur_mobile/models/book.dart';
import 'package:exampur_mobile/repositories/book_repository.dart';
import 'book_events.dart';
import 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository repository;

  BookBloc({required this.repository}) : super(BookEmpty());

  @override
  Stream<BookState> mapEventToState(BookEvent event) async* {
    if (event is FetchBook) {
      yield BookLoading();
      try {
        final BookList bookList = await repository.fetcher();
        if (bookList.bookList.isEmpty) {
          yield BookEmpty();
        }
        yield BookLoaded(bookList: bookList);
      } catch (_) {
        yield BookError();
      }
    }
  }
}
