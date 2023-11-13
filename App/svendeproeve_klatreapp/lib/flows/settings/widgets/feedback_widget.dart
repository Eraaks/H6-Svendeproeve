import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';

class FeedbackWidget extends StatefulWidget {
  const FeedbackWidget({Key? key}) : super(key: key);

  @override
  State<FeedbackWidget> createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  final controller = TextEditingController();
  List<String> items = ['Select Report Type', 'Feedback', 'Bug Report'];
  String? selectedValue = 'Select Report Type';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: const Text('Climbing App'),
        backgroundColor: topBackgroundColor,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 26,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(),
              const SizedBox(height: 20),
              SizedBox(
                width: 240,
                child: DropdownButtonFormField<String>(
                  dropdownColor: mainBackgroundColor,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          const BorderSide(width: 2, color: topBackgroundColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: topBackgroundColor),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  hint: const Text('Select'),
                  value: selectedValue,
                  items: items
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
                  onChanged: (item) => setState(() => selectedValue = item),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 10,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide:
                        const BorderSide(width: 2, color: topBackgroundColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 2, color: topBackgroundColor),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: 'Description',
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: topBackgroundColor),
                  child: const Text('Submit'),
                  //TODO: Implement API call for feedback IF have time.
                  onPressed: () {
                    print('Submit');
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
