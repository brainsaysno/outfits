import 'dart:developer';

import 'package:outfits/Models/clothing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AddClothing extends StatefulWidget {
  const AddClothing({super.key});

  @override
  State<AddClothing> createState() => _AddClothingState();
}

class _AddClothingState extends State<AddClothing> {
  int _index = 0;
  String _currentName = "";
  ClothingType _currentClothingType = ClothingType.top;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Color _currentColor = const Color(0xFFff0000);
  Color _pickerColor = const Color(0xFFff0000);

  void changeClothingType(cT) {
    if (cT != null) {
      setState(() => _currentClothingType = cT);
    }
  }

  void changeColor(color) {
    if (color != null) {
      setState(() => _currentColor = color);
    }
  }

  void showColorPicker() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
                title: const Text("Pick a color"),
                content: SingleChildScrollView(
                    child: MaterialPicker(
                        pickerColor: _pickerColor,
                        onColorChanged: (color) => _pickerColor = color)),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Confirm'),
                    onPressed: () {
                      changeColor(_pickerColor);
                      Navigator.of(ctx).pop();
                    },
                  )
                ]));
  }

  void continued() {
    if (_index == 1) {
      submitClothing();
    } else if (_index <= 0) {
      setState(() {
        _index += 1;
      });
    }
  }

  void submitClothing() {
    Clothing newClothing =
        Clothing(_currentName, _currentClothingType, _currentColor);
    Clothing.clothingRef.add(newClothing);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add clothing"),
      ),
      body: Stepper(
          currentStep: _index,
          onStepCancel: () {
            if (_index > 0) {
              setState(() {
                _index -= 1;
              });
            }
          },
          onStepContinue: continued,
          steps: <Step>[
            Step(
              title: const Text("Choose Type"),
              content: Center(
                  child: DropdownButton<ClothingType>(
                      value: _currentClothingType,
                      items: ClothingType.values
                          .map<DropdownMenuItem<ClothingType>>(
                              (ClothingType cT) => DropdownMenuItem(
                                  value: cT, child: Text(cT.getName())))
                          .toList(),
                      onChanged: changeClothingType)),
              state: _index >= 1 ? StepState.complete : StepState.disabled,
            ),
            Step(
                title: const Text("Choose name and color"),
                content: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          decoration:
                              const InputDecoration(hintText: "Enter the name"),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name';
                            }
                            return null;
                          },
                          onChanged: (val) =>
                              setState(() => _currentName = val),
                        ),
                        TextButton(
                            onPressed: showColorPicker,
                            style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => _currentColor),
                                foregroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.white)),
                            child: const Text("Pick a color")),
                      ],
                    )),
                state: _index >= 2 ? StepState.complete : StepState.disabled),
          ],
          type: StepperType.horizontal),
    );
  }
}
