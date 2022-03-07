import 'Species.dart';

class DropDownData {
  final List<String> countries = ['Nairobi', 'Tanzania', 'Mozambique'];

  final List<String> species = ['giraffa giraffa', 'Giraffa', 'tippelskirchii', 'giraffa angolensis'];

  final List<Species> listSpecies = [
    Species(name: 'Select All', value: 'Select All'),
    Species(name: 'Reticulated giraffe', value: 'reticulata'),
    Species(name: 'Masai giraffe', value: 'tippelskirchii'),
    Species(name: 'Southern giraffe', value: 'giraffa'),
    Species(name: 'South African giraffe', value: 'giraffa_giraffa'),
    Species(name: 'Angolan giraffe', value: 'giraffa_angolensis'),
    Species(name: 'Northern giraffe', value: 'camelopardalis'),
    Species(name: 'Nubian giraffe', value: 'camelopardalis_camelopardalis'),
    Species(name: 'Kordofan giraffe', value: 'camelopardalis_antiquorum'),
    Species(name: 'West African giraffe', value: 'camelopardalis_peralta'),
    Species(name: 'Luangwa giraffe', value: 'tippelschircki_thornicrofti'),
  ];
}
