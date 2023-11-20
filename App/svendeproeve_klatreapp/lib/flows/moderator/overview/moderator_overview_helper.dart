import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';

Widget areaDialog() {
  return StatefulBuilder(
    builder: (context, setState) {
      return AlertDialog(
        title: const Text('Please fill out the data:'),
        content: TextFormField(
          decoration: InputDecoration(
            labelText: 'Area',
            labelStyle: const TextStyle(color: Colors.grey),
            prefixIcon: const Icon(Icons.sync_problem, color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(width: 2, color: topBackgroundColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: topBackgroundColor),
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Implement logic when Confirm is pressed
              print('Confirmed editing');
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            child: const Text('Confirm'),
          ),
          TextButton(
            onPressed: () {
              print('Cancel editing');
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}

Widget routeDialog(selectedValue) {
  return StatefulBuilder(
    builder: (context, setState) {
      return AlertDialog(
        title: const Text('Please fill out the data:'),
        content: Container(
          height: 200,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Grade',
                  labelStyle: const TextStyle(color: Colors.grey),
                  prefixIcon:
                      const Icon(Icons.sync_problem, color: Colors.grey),
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
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButton<String>(
                value: selectedValue,
                onChanged: (String? value) {
                  setState(() {
                    selectedValue = value!;
                  });
                },
                items: colorMap.keys.map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Container(
                        color: colorMap[value],
                        child: Center(
                            child: Text(
                          value,
                          style: TextStyle(
                            color: colorMap[value] == Colors.black
                                ? Colors.white
                                : null,
                          ),
                        )),
                      ),
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Implement logic when Confirm is pressed
              print('Confirmed editing');
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            child: const Text('Confirm'),
          ),
          TextButton(
            onPressed: () {
              // Implement logic when Cancel is pressed
              print('Cancel editing');
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}

Widget deleteDialog() {
  return StatefulBuilder(
    builder: (context, setState) {
      return AlertDialog(
        title: const Text('Confirm deleting Route: ProblemID:'),
        actions: [
          TextButton(
            onPressed: () {
              print('Confirmed deleting');
              Navigator.pop(context); // Close the AlertDialog
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            child: const Text('Confirm'),
          ),
          TextButton(
            onPressed: () {
              print('Cancel deleting');
              Navigator.pop(context);
              // Close the AlertDialog
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}
