import 'package:flutter/material.dart';

Future<TextDialog?> showTextDialog<TextDialog>(
  BuildContext context, {
  required String title,
  required String value,
}) =>
    showDialog<TextDialog>(
      context: context,
      builder: (context) => DialogWidget(
        title: title,
        value: value,
      ),
    );

class DialogWidget extends StatefulWidget {
  final String title;
  final String value;

  const DialogWidget({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  _DialogWidgetState createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(widget.title),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(border: OutlineInputBorder()),
        ),
        actions: [
          ElevatedButton(
              child: Text('Save'),
              onPressed: () => Navigator.of(context).pop(controller.text))
        ],
      );
}
