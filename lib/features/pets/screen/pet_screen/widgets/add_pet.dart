  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:pet/utils/popups/full_screen_loader.dart';
  import '../../../../../constants/colors.dart';
  import '../../../../../constants/images.dart';
  import '../../../../../constants/sizes.dart';
  import '../../../../../utils/validators/validation.dart';
  import '../../../controller/pet_controller.dart';
  import '../../../model/pet_model.dart';

  class AddPetScreen extends StatefulWidget {
    final String userId;

    AddPetScreen({Key? key, required this.userId}) : super(key: key);

    @override
    State<AddPetScreen> createState() => _AddPetScreenState();
  }

  class _AddPetScreenState extends State<AddPetScreen> {
    final PetController petController = Get.put(PetController());
    final _formKey = GlobalKey<FormState>();

    String _name = '';
    String _type = '';
    String _breed = '';
    int _age = 0;
    double _weight = 0;
    String _sex = '';
    String _description = '';
    List<String> _diseases = [];
    List<String> _vaccinations = [];

    Map<String, List<String>> breeds = {
      'Dog': ['German Shepherd', 'Golden Retriever', 'Bulldog', 'Labrador', 'Husky', 'Pointer', 'Siberian Husky', 'Poodle', 'Bernese Mountain Dog', 'Rottweiler', 'Australian Shepherd', 'Pomeranian', 'other'],
      'Cat': ['Siamese', 'Maine Coon', 'Persian', 'Bengal', 'British Shorthair', 'Khao Manee', 'Ragdoll', 'American Shorthair', 'other'],
      'Rabbit': ['other']
    };

    Map<String, List<String>> diseasesByType = {
      'Dog': ['Parvovirus', 'Distemper', 'Rabies', 'other'],
      'Cat': ['Feline Leukemia', 'Feline AIDS', 'Feline Infectious Peritonitis', 'other'],
      'Rabbit': ['Myxomatosis', 'Rabbit Hemorrhagic Disease', 'other']
    };

    Map<String, List<String>> vaccinationsByType = {
      'Dog': ['Rabies', 'DHPP', 'Leptospirosis', 'other'],
      'Cat': ['Rabies', 'FVRCP', 'FeLV', 'other'],
      'Rabbit': ['Myxomatosis', 'RHDV', 'other']
    };

    List<String> availableBreeds = [];
    List<String> availableDiseases = [];
    List<String> availableVaccinations = [];

    void _addPet() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        FullScreenLoader.openLoadingDialogue('Adding Pet', loader);
        MedicalRecord medicalRecord = MedicalRecord(
          diseases: _diseases,
          vaccinations: _vaccinations,
        );

        Pet newPet = Pet(
          id: '',
          name: _name,
          type: _type,
          breed: _breed,
          age: _age,
          weight: _weight,
          sex: _sex,
          description: _description,
          imageUrl: '',
          medicalRecord: medicalRecord,
        );

        petController.addPet(widget.userId, newPet);

        FullScreenLoader.stopLoading();
        Get.back();
      }
    }

    void _handleOtherInput({required String title, required List<String> list}){
      TextEditingController customController = TextEditingController();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Enter $title'),
          content: TextFormField(
            autofocus: true,
            controller: customController,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  if (customController.text.isNotEmpty) {
                    list.add(customController.text);
                  }
                });
              },
              child: const Text('Save'),
            )
          ],
        ),
      );
    }
    void _handleOtherListInput({
      required String title,
      required List<String> list,
      required Function(String) onAdd, // A callback to update the specific state
    }) {
      TextEditingController customController = TextEditingController();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Enter $title'),
          content: TextFormField(
            autofocus: true,
            controller: customController,
          ),
          actions: [
            TextButton(
              onPressed: () {
                String customValue = customController.text.trim();
                if (customValue.isNotEmpty) {
                  Navigator.of(context).pop();
                  setState(() {
                    list.add(customValue); // Add to the available list
                    onAdd(customValue); // Set the custom value as the selected value
                  });
                } else {
                  Navigator.of(context).pop(); // Close the dialog without any action
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      );
    }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Add Pet', style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Sizes.defaultPadding),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Pet Name'),
                    onSaved: (value) => _name = value!,
                    validator: (value) => Valid.validateEmpty('Name', value),
                  ),
                  SizedBox(height: Sizes.defaultPadding),
                  DropdownButtonFormField(
                    value: _type.isNotEmpty ? _type : null,
                    decoration: const InputDecoration(labelText: 'Type'),
                    items: ['Dog', 'Cat', 'Rabbit'].map((String type) {
                      return DropdownMenuItem(value: type, child: Text(type, style: TextStyle(color: textColor),),);
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _type = newValue!;
                        _breed = '';
                        availableBreeds = breeds[_type]!;
                        availableDiseases = diseasesByType[_type]!;
                        availableVaccinations = vaccinationsByType[_type]!;
                      });
                    },
                    validator: (value) => Valid.validateEmpty('Type', value),
                    dropdownColor: Colors.white,
                  ),
                  SizedBox(height: Sizes.defaultPadding),
                  DropdownButtonFormField(
                    value: _breed.isNotEmpty ? _breed : null,
                    decoration: const InputDecoration(labelText: 'Breed', fillColor: Colors.white, filled: true),
                    items: availableBreeds.map((String breed) {
                      return DropdownMenuItem(value: breed, child: Text(breed, style: TextStyle(color: textColor),));
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue == 'other') {
                        _handleOtherInput(title: 'Breed', list: availableBreeds);
                      } else {
                        setState(() => _breed = newValue!);
                      }
                    },
                    validator: (value) => Valid.validateEmpty('Breed', value),
                    dropdownColor: Colors.white,
                  ),
                  SizedBox(height: Sizes.defaultPadding),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Age in months'),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _age = int.tryParse(value!) ?? 0,
                    validator: (value) => Valid.validateEmpty('Age', value),
                  ),
                  SizedBox(height: Sizes.defaultPadding),
                  DropdownButtonFormField(
                    value: _sex.isNotEmpty ? _sex : null,
                    decoration: const InputDecoration(labelText: 'Sex'),
                    items: ['Male', 'Female'].map((String sex) {
                      return DropdownMenuItem(value: sex, child: Text(sex, style: TextStyle(color: textColor),));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() => _sex = newValue!);
                    },
                    validator: (value) => Valid.validateEmpty('Sex', value),
                    dropdownColor: Colors.white,
                  ),
                  SizedBox(height: Sizes.defaultPadding),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Weight'),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _weight = double.tryParse(value!) ?? 0,
                    validator: (value) => Valid.validateEmpty('Weight', value),
                  ),
                  SizedBox(height: Sizes.defaultPadding),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Description'),
                    onSaved: (value) => _description = value!,
                    validator: (value) => Valid.validateEmpty('Description', value),
                    maxLines: 3,
                  ),
                  SizedBox(height: Sizes.defaultPadding),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Diseases'),
                    value: null, // Reset the dropdown value after selection
                    items: availableDiseases.map((String disease) {
                      return DropdownMenuItem<String>(
                        value: disease,
                        child: Text(
                          disease,
                          style: const TextStyle(color: textColor),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue == 'other') {
                        _handleOtherListInput(
                          title: 'Disease',
                          list: availableDiseases,
                          onAdd: (customValue) {
                            setState(() {
                              _diseases.add(customValue); // Add to the Diseases state
                            });
                          },
                        );
                      } else if (newValue != null) {
                        setState(() {
                          if (!_diseases.contains(newValue)) {
                            _diseases.add(newValue);
                          }
                        });
                      }
                    },
                    validator: (value) {
                      if (_diseases.isEmpty) {
                        return 'Please select at least one disease';
                      }
                      return null;
                    },
                    dropdownColor: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Wrap(
                      spacing: 8,
                      children: _diseases.map((disease) {
                        return Chip(
                          side: BorderSide(color: textColor),
                          label: Text(disease, style: TextStyle(color: textColor),),
                          backgroundColor: Colors.white,
                          deleteIcon: Icon(Icons.close),
                          onDeleted: () {
                            setState(() {
                              _diseases.remove(disease); // Remove disease from the list
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Vaccinations'),
                    value: null, // Reset the dropdown value after selection
                    items: availableVaccinations.map((String vaccination) {
                      return DropdownMenuItem<String>(
                        value: vaccination,
                        child: Text(
                          vaccination,
                          style: const TextStyle(color: textColor),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue == 'other') {
                        _handleOtherListInput(
                          title: 'Vaccination',
                          list: availableVaccinations,
                          onAdd: (customValue) {
                            setState(() {
                              _vaccinations.add(customValue); // Add to the Vaccinations state
                            });
                          },
                        );
                      } else if (newValue != null) {
                        setState(() {
                          if (!_vaccinations.contains(newValue)) {
                            _vaccinations.add(newValue);
                          }
                        });
                      }
                    },
                    dropdownColor: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Wrap(
                      spacing: 8,
                      children: _vaccinations.map((vaccination) {
                        return Chip(
                          side: BorderSide(color: textColor),
                          backgroundColor: Colors.white,
                          label: Text(vaccination, style: TextStyle(color: textColor),),
                          deleteIcon: Icon(Icons.close),
                          onDeleted: () {
                            setState(() {
                              _vaccinations.remove(vaccination); // Remove vaccination from the list
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: Sizes.defaultPadding),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _addPet,
                      child: const Text('Add Pet'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }