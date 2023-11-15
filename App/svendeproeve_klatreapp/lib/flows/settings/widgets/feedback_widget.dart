import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';
import 'package:svendeproeve_klatreapp/services/klatreapp_api_service.dart';

class FeedbackWidget extends StatefulWidget {
  const FeedbackWidget({Key? key}) : super(key: key);

  @override
  State<FeedbackWidget> createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  List<String> items = ['Feedback', 'Bug Report'];
  String? selectedValue = 'Feedback';
  final APIService _apiService = APIService();

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
                controller: titleController,
                keyboardType: TextInputType.name,
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
                  hintText: 'Title',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 10,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(new RegExp(r"\n"))
                ],
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
                  onPressed: () async {
                    await _apiService.createIssue(
                        titleController.text,
                        descriptionController.text,
                        selectedValue == 'Feedback' ? false : true);
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
