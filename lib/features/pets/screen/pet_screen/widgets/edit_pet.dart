import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet/common/widgets/loaders/loaders.dart';
import 'package:pet/utils/popups/full_screen_loader.dart';
import '../../../../../constants/colors.dart';
import '../../../../../constants/images.dart';
import '../../../../../constants/sizes.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controller/pet_controller.dart';
import '../../../model/pet_model.dart';

class EditPetScreen extends StatefulWidget {
  final Pet pet;

  EditPetScreen({super.key, required this.pet});

  @override
  _EditPetScreenState createState() => _EditPetScreenState();
}

class _EditPetScreenState extends State<EditPetScreen> {
  final PetController petController = Get.put(PetController());
  final _formKey = GlobalKey<FormState>();
  String? selectedValue;

  late String _name = widget.pet.name;
  late String _type = widget.pet.type;
  late String _breed = widget.pet.breed;
  late int _age = widget.pet.age;
  late double _weight = widget.pet.weight;
  late String _sex = widget.pet.sex;
  late String _description = widget.pet.description;
  late List<String> _diseases = widget.pet.medicalRecord.diseases;
  late List<String> _vaccinations = widget.pet.medicalRecord.vaccinations;

  Map<String, List<String>> breeds = {
    'Dog': ['German Shepherd', 'Golden Retriever', 'Bulldog', 'Labrador', 'Husky', 'Pointer', 'Siberian Husky', 'Poodle', 'Bernese Mountain Dog', 'Rottweiler', 'Australian Shepherd', 'Pomeranian', 'other'],
    'Cat': ['Siamese', 'Maine Coon', 'Persian', 'Bengal', 'British Shorthair', 'Khao Manee', 'Ragdoll', 'American Shorthair', 'other'],
    'Rabbit': ['other'],
  };

  Map<String, List<String>> diseasesByType = {
    'Dog': ['Parvovirus', 'Distemper', 'Rabies', 'other'],
    'Cat': ['Feline Leukemia', 'Feline AIDS', 'Feline Infectious Peritonitis', 'other'],
    'Rabbit': ['Myxomatosis', 'Rabbit Hemorrhagic Disease', 'other'],
  };

  Map<String, List<String>> vaccinationsByType = {
    'Dog': ['Rabies', 'DHPP', 'Leptospirosis', 'other'],
    'Cat': ['Rabies', 'FVRCP', 'FeLV', 'other'],
    'Rabbit': ['Myxomatosis', 'RHDV', 'other'],
  };

  List<String> availableBreeds = [];
  List<String> availableDiseases = [];
  List<String> availableVaccinations = [];

  @override
  void initState() {
    super.initState();
    availableBreeds = breeds[_type]!;
    availableDiseases = diseasesByType[_type]!;
    availableVaccinations = vaccinationsByType[_type]!;
    // Initialize the selectedValue with the pet's breed if it's already selected
    selectedValue = _breed;
  }

  void _updatePet() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Open loading dialogue before starting the update process
      FullScreenLoader.openLoadingDialogue('Updating Pet...', loader);

      try {
        MedicalRecord updatedMedicalRecord = MedicalRecord(
          diseases: _diseases,
          vaccinations: _vaccinations,
        );

        Pet updatedPet = Pet(
          id: widget.pet.id,
          name: _name,
          type: _type,
          breed: _breed,
          age: _age,
          sex: _sex,
          weight: _weight,
          description: _description,
          imageUrl: widget.pet.imageUrl,
          medicalRecord: updatedMedicalRecord,
        );

        // Simulating an asynchronous API call for updating pet
        await petController.updatePet(widget.pet.id, updatedPet);

        // Once the update is successful, close the loading dialog
        FullScreenLoader.stopLoading();

        Get.back();
        Loaders.successSnackBar(title: "Congratulations!", message: 'Pet information has been updated');

      } catch (e) {
        // Handle any error that occurs during the update process
        FullScreenLoader.stopLoading();
        Loaders.errorSnackBar(title: "Oh Snap!", message: "An error occurred while updating.");
        print("Error updating pet: $e");
      }
    }
  }

  void _handleOtherInput({required String title, required List<String> list}) {
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
    required Function(String) onAdd,
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
                  list.add(customValue);
                  onAdd(customValue);
                });
              } else {
                Navigator.of(context).pop();
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
        title: const Text('Edit Pet', style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextFormField('Pet Name', (value) => _name = value!),
                SizedBox(height: Sizes.defaultPadding),
                DropdownButtonFormField(
                  value: _type.isNotEmpty ? _type : null,
                  decoration: const InputDecoration(labelText: 'Type'),
                  items: ['Dog', 'Cat', 'Rabbit'].map((String type) {
                    return DropdownMenuItem(value: type, child: Text(type, style: TextStyle(color: textColor),));
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
                DropdownButtonFormField<String>(
                  value: selectedValue,  // Display the breed selected value
                  decoration: const InputDecoration(labelText: 'Select Breed'),
                  items: availableBreeds.toSet().map((String breed) {
                    return DropdownMenuItem<String>(
                      value: breed,
                      child: Text(breed, style: TextStyle(color: textColor),),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                      _breed = newValue;  // Update breed based on selection
                    });
                  },
                  dropdownColor: Colors.white,
                ),
                SizedBox(height: Sizes.defaultPadding),
                _buildNumericFormField('Age in months', (value) => _age = int.tryParse(value!) ?? 0),
                SizedBox(height: Sizes.defaultPadding),
                _buildNumericFormField('Weight in kg', (value) => _weight = double.tryParse(value!) ?? 0.0),
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
                _buildTextFormField('Description', (value) => _description = value!, maxLines: 3),
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
                SizedBox(height: Sizes.defaultPadding,),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _updatePet,
                    child: Text('Save Changes'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(String label, FormFieldSetter<String> onSaved, {int? maxLines}) {
    return TextFormField(
      style: TextStyle(color: textColor),
      initialValue: _name, // Update with initial value
      decoration: InputDecoration(labelText: label),
      onSaved: onSaved,
      maxLines: maxLines ?? 1,
      validator: (value) => Valid.validateEmpty(label, value),
    );
  }

  Widget _buildNumericFormField(String label, FormFieldSetter<String> onSaved) {
    return TextFormField(
      style: TextStyle(color: textColor),
      initialValue: _age.toString(),
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      onSaved: onSaved,
      validator: (value) => Valid.validateEmpty(label, value),
    );
  }
}
