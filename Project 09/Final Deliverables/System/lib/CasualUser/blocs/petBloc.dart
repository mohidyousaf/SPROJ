import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petswala/CasualUser/events/addPetEvent.dart';
import 'package:petswala/CasualUser/states/addPetState.dart';
import 'package:petswala/Repository/networkHandler.dart';
import 'package:petswala/demo.dart';
import 'package:shared_preferences/shared_preferences.dart';

// It contains bloc logic for listening to the events eg adding pet name, category or age and then respond accordinig to the events and emit changes in the state.

class AddPetBloc extends Bloc<AddPetEvent, AddPetState> {
  AddPetBloc() : super(AddPetState()) {
    on<ChangePathEvent>((event, emit) {
      emit(state..path = event.path);
      print(state..path);
      print('path bloc working');
    });

    on<ChangeCategoryEvent>((event, emit) {
      // TODO: implement event handler
      emit(state..category = event.category);
      print(state..category);
      print("bloc is working");
    });

    on<ChangeAgeEvent>((event, emit) {
      emit(state..age = event.age);
      print(state..age);
      print("age bloc is working");
    });

    on<ChangeNameEvent>((event, emit) => state..name = event.name);

    on<SubmitEvent>((event, emit) async {
      // final db = await DBConnection.getInstance();
      // db.addPet(state.category, state.name, state.age);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String name = prefs.getString('name');
      Map<String, String> data = {
        'ownerName': name,
        'petName': state.name,
        'age': state.age,
        'category': state.category
      };

      NetworkHandler nw = NetworkHandler();
      nw.postPet('pet/addPet', data, state.path);

      print('pet is added');
    });
  }
}
