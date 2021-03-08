import 'package:app_demo_bloc/module/search/search_bloc.dart';
import 'package:flutter/material.dart';

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
