import 'package:flutter/material.dart';
import '../blocs/blocs.dart';
import '../widgets/widgets.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    bloc.fetchTopIds();
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, int index) {
            bloc.fetchItem(snapshot.data[index]);

            return NewsListTile(
              itemId: snapshot.data[index],
            );
          },
        );
      },
    );
  }
}
