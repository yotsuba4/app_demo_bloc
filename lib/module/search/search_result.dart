import 'package:app_demo_bloc/module/search/search_bloc.dart';
import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  final SearchBloc bloc;
  Result({SearchBloc bloc}) : this.bloc = bloc;
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<List<String>>(
        initialData: [],
        stream: widget.bloc.searchController.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                //print(snapshot.data[index]);
                return _buildRow(snapshot.data[index]);
              });
        },
      ),
    );
  }

  Widget _buildRow(String data) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        data,
        style: TextStyle(fontSize: 17, color: Colors.blue),
      ),
    );
  }
}
