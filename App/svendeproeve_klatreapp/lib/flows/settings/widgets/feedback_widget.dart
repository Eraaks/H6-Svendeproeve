import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/app_side_bar.dart';
import 'package:svendeproeve_klatreapp/flows/app_top_bar/app_top_bar.dart';
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
      appBar: reusableAppBar(),
      drawer: const Sidebar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: mainBackgroundColor,
                padding: const EdgeInsets.only(top: 5, left: 15),
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 26,
                    color: topBackgroundColor,
                  ),
                ),
              ),
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
                width: 200, // Set the desired width
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: topBackgroundColor),
                  child: Text('Submit'),
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
