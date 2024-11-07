import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ParentWidget(),
    );
  }
}

class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nested Stateful Widgets'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Parent Counter: $counter'),
          ChildWidget(onIncrement: incrementCounter), // Pass function to child
        ],
      ),
    );
  }
}

class ChildWidget extends StatefulWidget {
  final VoidCallback onIncrement; // Function to be called from child

  ChildWidget({required this.onIncrement});

  @override
  _ChildWidgetState createState() => _ChildWidgetState();
}

class _ChildWidgetState extends State<ChildWidget> {
  int childCounter = 0;

  void incrementChildCounter() {
    setState(() {
      childCounter++;
    });
    widget.onIncrement(); // Call parent function
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Child Counter: $childCounter'),
        ElevatedButton(
          onPressed: incrementChildCounter,
          child: Text('Increment Child Counter'),
        ),
      ],
    );
  }
}
