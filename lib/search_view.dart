import 'package:app_demo_bloc/search_bloc.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  final SearchBloc searchBloc = SearchBloc();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          SearchBox(
            bloc: searchBloc,
          ),
          Expanded(
            child: Result(
              bloc: searchBloc,
            ),
          )
        ],
      ),
    );
  }
}

class SearchBox extends StatefulWidget {
  final SearchBloc bloc;
  SearchBox({SearchBloc bloc}) : this.bloc = bloc;
  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final seachController = TextEditingController();
  @override
  void initState() {
    super.initState();
    seachController.addListener(() {
      widget.bloc.search(seachController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: seachController,
        decoration: InputDecoration(
            suffixIcon: Icon(Icons.search),
            hintText: 'Seach...',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(40))),
      ),
    );
  }
}

class Result extends StatefulWidget {
  final SearchBloc bloc;
  Result({SearchBloc bloc}) : this.bloc = bloc;
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  void initState() {
    super.initState();
    widget.bloc.searchController.stream.listen((event) {
      print(event);
    });
  }

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
                print(snapshot.data[index]);
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
