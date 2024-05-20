import 'package:flutter/material.dart';
import 'package:my_app/controllers/list_controller.dart';

import 'package:my_app/models/new_lists.dart';
import 'package:my_app/screens/create_list/list_create_form.dart';
import 'package:my_app/screens/itens_list/list_transference.dart';
import 'package:my_app/utils_colors/utils_style.dart';

class createdLists extends StatelessWidget {
  final ListController _controller = ListController();
  final String _title = 'Listas de compras';

  @override
  Widget build(BuildContext context) {
    _controller.findAll();
    return Scaffold(
      appBar: appBarCustom(title: _title),
      body: ValueListenableBuilder<List<NewLists>>(
        valueListenable: _controller.listaValores,
        builder: (context, snapshot, _) {
          if (snapshot.isEmpty) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final NewLists lists = snapshot[index];
                return _collectionsLists(
                  lists,
                );
              },
              itemCount: snapshot.length,
            );
          }

          return ListView.builder(
            itemBuilder: (context, index) {
              final NewLists lists = snapshot[index];
              return _collectionsLists(
                lists,
              );
            },
            itemCount: snapshot.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => listCreateForm(_controller),
            ),
          );
        },
        shape: const CircleBorder(),
        backgroundColor: UtilColors.instance.colorRed,
        foregroundColor: UtilColors.instance.colorWhite,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _collectionsLists extends StatelessWidget {
  final NewLists list;

  _collectionsLists(this.list);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return listTransference(list);
            }));
          },
          child: Text(
            list.nameList,
            style: const TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }
}
