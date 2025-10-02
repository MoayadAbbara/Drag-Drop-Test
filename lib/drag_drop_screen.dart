import 'package:flutter/material.dart';

class DragDropScreen extends StatefulWidget {
  const DragDropScreen({super.key});

  @override
  State<DragDropScreen> createState() => _DragDropScreenState();
}

class _DragDropScreenState extends State<DragDropScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: const Text('Drag & Drop Demo')),
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Draggable<Color>(
                    data: Colors.blue,
                    feedback: buildCircle(Colors.blue, 80, false),
                    childWhenDragging: buildCircle(Colors.blue, 60, true),
                    child: buildCircle(Colors.blue, 60, false),
                  ),
                  Draggable<Color>(
                    data: Colors.red,
                    feedback: buildCircle(Colors.red, 80, false),
                    childWhenDragging: buildCircle(Colors.red, 60, true),
                    child: buildCircle(Colors.red, 60, false),
                  ),
                  Draggable<Color>(
                    data: Colors.green,
                    feedback: buildCircle(Colors.green, 80, false),
                    childWhenDragging: buildCircle(Colors.green, 60, true),
                    child: buildCircle(Colors.green, 60, false),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Blue drop target
                Expanded(
                  child: DragTarget<Color>(
                    onWillAcceptWithDetails: (details) {
                      return details.data == Colors.blue;
                    },
                    onAcceptWithDetails: (details) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Great! You dropped the blue circle!')));
                    },
                    onLeave: (data) {
                      if (data != Colors.blue) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Try again! Only blue is accepted here.')));
                      }
                    },
                    builder: (context, candidateData, rejectedData) {
                      bool isHovering = candidateData.isNotEmpty;
                      return Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            buildSquare(Colors.blue, 60),
                            if (isHovering) Icon(candidateData.first == Colors.blue ? Icons.check_circle : Icons.cancel, color: Colors.white, size: 30),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Red drop target
                Expanded(
                  child: DragTarget<Color>(
                    onWillAcceptWithDetails: (details) {
                      return details.data == Colors.red;
                    },
                    onAcceptWithDetails: (details) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Great! You dropped the red circle!')));
                    },
                    onLeave: (data) {
                      if (data != Colors.red) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Try again! Only red is accepted here.')));
                      }
                    },
                    builder: (context, candidateData, rejectedData) {
                      bool isHovering = candidateData.isNotEmpty;
                      return Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            buildSquare(Colors.red, 60),
                            if (isHovering) Icon(candidateData.first == Colors.red ? Icons.check_circle : Icons.cancel, color: Colors.white, size: 30),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Green drop target
                Expanded(
                  child: DragTarget<Color>(
                    onWillAcceptWithDetails: (details) {
                      return details.data == Colors.green;
                    },
                    onAcceptWithDetails: (details) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Great! You dropped the green circle!')));
                    },
                    onLeave: (data) {
                      if (data != Colors.green) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Try again! Only green is accepted here.')));
                      }
                    },
                    builder: (context, candidateData, rejectedData) {
                      bool isHovering = candidateData.isNotEmpty;
                      return Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            buildSquare(Colors.green, 60),
                            if (isHovering) Icon(candidateData.first == Colors.green ? Icons.check_circle : Icons.cancel, color: Colors.white, size: 30),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCircle(Color color, double radius, bool isShadowed) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(color: color.withAlpha(isShadowed ? 100 : 255), shape: BoxShape.circle),
    );
  }

  Widget buildSquare(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(8)),
    );
  }
}
