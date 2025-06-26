import 'package:flutter/material.dart';
import 'package:sheet_demi/cupertino_sheet_fork.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Cupertino Sheet Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Cupertino Sheet Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showCupertinoSheet(
              context: context,
              pageBuilder: (BuildContext context) {
                return const CustomSheet();
              },
            );
          },
          child: const Text('Show Cupertino Sheet'),
        ),
      ),
    );
  }
}

class CustomSheet extends StatefulWidget {
  const CustomSheet({super.key});

  @override
  State<CustomSheet> createState() => _CustomSheetState();
}

class _CustomSheetState extends State<CustomSheet> {
  bool listView = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            heroTag: 'toggle view',
            onPressed: () {
              setState(() {
                listView = !listView;
              });
            },
            child: Icon(listView ? Icons.square : Icons.list),
          ),
          FloatingActionButton(
            heroTag: 'run nested sheet',
            onPressed: () {
              showCupertinoSheet(
                context: context,
                pageBuilder: (BuildContext context) {
                  return const CustomSheet();
                },
              );
            },
            child: Icon(Icons.shelves),
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 325),
        switchInCurve: Curves.easeInOutQuad,
        child: listView
            ? ListView.builder(
                physics: BottomSheetScrollPhysics(),
                itemCount: 30,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
              )
            : Center(
                child: Text('non scrollable widget'),
              ),
      ),
    );
  }
}
