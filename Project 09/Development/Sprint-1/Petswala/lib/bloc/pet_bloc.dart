import 'package:petswala/demo.dart';
import 'package:rxdart/rxdart.dart';

// It contains stream controllers for adding pets that listen all the changes from the textfield and update the information in databse.

class PetBLoc {
  final _category = BehaviorSubject<String>();
  final _name = BehaviorSubject<String>();
  final _age = BehaviorSubject<String>();

// getters

  Stream<String> get category => _category.stream;
  Stream<String> get name => _name.stream;
  Stream<String> get age => _age.stream;

  //setters

  Function(String) get changeCategory => _category.sink.add;
  Function(String) get changeName => _name.sink.add;
  Function(String) get changeAge => _age.sink.add;

  // logic

  void submit() async {
    print(_category.value);
    print(_name.value);
    print(_age.value);
    final db = await DBConnection.getInstance();
    db.addPet(_category.value, _name.value, _age.value);
    print("pet added");
  }

  void dispose() {
    _category.close();
    _name.close();
    _age.close();
  }
}
