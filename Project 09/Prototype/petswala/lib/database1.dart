import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('users');

class Database {
  static String? userUid;

  static Future<void> addUsers({
    required String address,
    required int contactnumber,
    required String password,
    required String usertype,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid);

    Map<String, dynamic> data = <String, dynamic>{
      "address": address,
      "contactnumber": contactnumber,
      "password": password,
      "usertype": usertype,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("User added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> addCommonUsers({
    required String email,
    required bool ispetowner,
    required String profilepicture,
    required String status,
    required String username,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('CommonUsers').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "email": email,
      "ispetowner": ispetowner,
      "profilepicture":profilepicture,
      "status":status,
      "username":username,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Common User added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> addPetStores({
    required String storename,
    required String storelocation,
    required int storecontact,
    required String storeaddress,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('PetStores').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "storename": storename,
      "storelocation": storelocation,
      "storecontact":storecontact,
      "storeaddress":storeaddress,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Pet Store added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> addPMS({
    required String shopname,
    required int shopcontact,
    required String shopaddress,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('PetStores').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "shopname": shopname,
      "shopcontact":shopcontact,
      "shopaddress":shopaddress,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Pet Merchandise Shop added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> addProduct({
    required String usertype,
    required String name,
    required String type,
    required int quantity,
    required double price,
    required String picture,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection(usertype).doc().collection('Products').doc(name);

    Map<String, dynamic> data = <String, dynamic>{
      "type": type,
      "quantity":quantity,
      "price":price,
      "picture":picture,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Product added to the inventory"))
        .catchError((e) => print(e));
  }


  //Update Database

  static Future<void> updateUsers({
    required String address,
    required int contactnumber,
    required String password,
    required String usertype,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid);

    Map<String, dynamic> data = <String, dynamic>{
      "address": address,
      "contactnumber": contactnumber,
      "password": password,
      "usertype": usertype,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("User updated."))
        .catchError((e) => print(e));
  }

  static Future<void> updateCommonUsers({
    required String email,
    required bool ispetowner,
    required String profilepicture,
    required String status,
    required String username,
    required String docID,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('CommonUsers').doc(docID);

    Map<String, dynamic> data = <String, dynamic>{
      "email": email,
      "ispetowner": ispetowner,
      "profilepicture":profilepicture,
      "status":status,
      "username":username,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Common User updated."))
        .catchError((e) => print(e));
  }

  static Future<void> updatePetStores({
    required String storename,
    required String storelocation,
    required int storecontact,
    required String storeaddress,
    required String docID,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('PetStores').doc(docID);

    Map<String, dynamic> data = <String, dynamic>{
      "storename": storename,
      "storelocation": storelocation,
      "storecontact":storecontact,
      "storeaddress":storeaddress,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Pet Store ipdated."))
        .catchError((e) => print(e));
  }

  static Future<void> updatePMS({
    required String shopname,
    required int shopcontact,
    required String shopaddress,
    required String docID,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('PetStores').doc(docID);

    Map<String, dynamic> data = <String, dynamic>{
      "shopname": shopname,
      "shopcontact":shopcontact,
      "shopaddress":shopaddress,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Pet Merchandise Shop updated."))
        .catchError((e) => print(e));
  }

  static Future<void> updateProduct({
    required String usertype,
    required String name,
    required String type,
    required int quantity,
    required double price,
    required String picture,
    required String usertypeID,
    required String productID,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection(usertype).doc(usertypeID).collection('Products').doc(productID);

    Map<String, dynamic> data = <String, dynamic>{
      "type": type,
      "quantity":quantity,
      "price":price,
      "picture":picture,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Product updated in the inventory"))
        .catchError((e) => print(e));
  }


  static Stream<QuerySnapshot> readUsers() {
    CollectionReference userCollection =
        _mainCollection;

    return userCollection.snapshots();
  }

  static Stream<QuerySnapshot> readusertype(String usertype) {
    CollectionReference userCollection =
        _mainCollection.doc(userUid).collection(usertype);

    return userCollection.snapshots();
  }

  static Stream<QuerySnapshot> readproduct(String usertype, String docid) {
    CollectionReference userCollection =
        _mainCollection.doc(userUid).collection(usertype).doc(docid).collection('Products');

    return userCollection.snapshots();
  }

  static Future<void> deleteUser() async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid);

    await documentReferencer
        .delete()
        .whenComplete(() => print('User deleted from the database'))
        .catchError((e) => print(e));
  }

  static Future<void> deleteUsertype({
    required String usertype,
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection(usertype).doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('UserType deleted from the database'))
        .catchError((e) => print(e));
  }

  static Future<void> deleteProduct({
    required String usertype,
    required String docId,
    required String productid,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection(usertype).doc(docId).collection('Products').doc(productid);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Product deleted from the database'))
        .catchError((e) => print(e));
  }
}

