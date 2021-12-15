import 'package:exampur_mobile/logic/bloc/user_bloc.dart';
import 'package:exampur_mobile/logic/bloc/user_events.dart';
import 'package:exampur_mobile/logic/bloc/user_state.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
import 'package:exampur_mobile/shared/books_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BooksScreen extends StatefulWidget {
  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  Future<void> refresh() async {
    BlocProvider.of<UserBloc>(context).add(FetchUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserEmpty) {
            BlocProvider.of<UserBloc>(context).add(FetchUser());
          }
          if (state is UserError) {
            return RefreshIndicator(
              onRefresh: refresh,
              color: Theme.of(context).primaryColor,
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, i) {
                    return Text("bjb");
                  }),
            );
          }
          if (state is UserLoaded) {
            if (state.userList.userList.length == 0)
              return RefreshIndicator(
                onRefresh: refresh,
                color: Theme.of(context).primaryColor,
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, i) {
                      return Text("null");
                    }),
              );
            return RefreshIndicator(
              color: Theme.of(context).primaryColor,
              onRefresh: refresh,
              child: ListView.builder(
                  itemCount: state.userList.userList.length,
                  itemBuilder: (context, i) {
                    return Text("habi");
                  }),
            );
          }
          return LoadingIndicator(context);
        },
      ),
    );
  }
}
