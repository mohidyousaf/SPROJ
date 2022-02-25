import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection, ObjectId;
import 'package:petswala/Authentication/userClass.dart';
import 'package:petswala/CasualUser/models/orderInfo.dart';
import 'package:petswala/CasualUser/models/productItem.dart';
import 'package:petswala/CasualUser/models/rescueInfo.dart';
import 'package:petswala/Seller/models/shopProductItem.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CasualUser/models/postInfo.dart';

// This is the code where we are requesting to connect to a mongodb atlas cluster and getting a instance, and requesting updates and changes according to our bloc logics.

class DBConnection {
  static DBConnection _instance;

  final String _getConnectionString =
      "mongodb+srv://ayan:abcd1234@clusterzero.nxzak.mongodb.net/Users?retryWrites=true&w=majority";

  Db _db;

  static getInstance() {
    if (_instance == null) {
      _instance = DBConnection();
    }
    return _instance;
  }

  Future<Db> getConnection() async {
    if (_db == null) {
      try {
        _db = await Db.create(_getConnectionString);
        await _db.open();
      } catch (e) {
        print('hfd');
        print(e);
      }
    }
    return _db;
  }

  Future getAllProducts() async {
    if (_db == null) {
      await getConnection();
    }
    dynamic coll1 = _db.collection('Products');
    final products = await coll1.find().toList();
    List<ProductItem> finalList = [];
    var poignant = products.forEach((element) {
      finalList.add(ProductItem(
          id: element['_id'],
          name: element['productname'],
          category: element['productcategory'],
          price: element['price'],
          rating: element['rating'],
          imageUrl: 'assets/cat.png'));
    });
    // print(finalList[0].category);
    return finalList;
  }
    Future getAllRequests() async {
    if (_db == null) {
      await getConnection();
    }
    dynamic coll1 = _db.collection('Rescue');
    final requests = await coll1.find().toList();
    List<RescueInfo> finalList = [];
    var poignant = requests.forEach((element) {
      finalList.add(RescueInfo(
          contact: element['contactNo'],
          description: element['description'],
          petType: element['petType'],
          pos: LatLng(element['lat'], element['long']),
          name: element['name']));
    });
    // print(finalList[0].category);
    return finalList;
  }

  Future getAllPosts() async {
    if (_db == null) {
      await getConnection();
    }
    dynamic coll1 = _db.collection('Posts');
    final posts = await coll1.find().toList();
    List<PostInfo> finalList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = '';
    if (prefs.containsKey('name')) {
      name = prefs.getString('name');
    }
    var poignant = posts.forEach((element) {
      finalList.add(PostInfo(
          postID: element['_id'],
          posterName: element['posterName'],
          posterType: element['posterType'],
          time: element['time'],
          text : element['text'],
          likes: element['likes'],
          likeList: element['likeList'],
          liked: element['likeList'].contains(name),
      )
      );
    });

    print(finalList[0].text);
    finalList.sort((b,a) => a.time.compareTo(b.time));
    return finalList;
  }
  Future getProduct(id) async {
    if (_db == null) {
      await getConnection();
    }
    dynamic coll1 = _db.collection('Products');
    final products = await coll1.find({"_id":id}).toList();
    ShopProductItem product;
    var poignant = products.forEach((element) {
      product = ShopProductItem(
          quantity: element['quantity'],
          id: element["_id"],
          name: element['productname'],
          category: element['productcategory'],
          price: element['price'],
          rating: element['rating'],
          imageUrl: 'assets/cat.png');
    });
    return product;
  }

  Future getShopProducts() async {
    if (_db == null) {
      await getConnection();
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = '';
    if (prefs.containsKey('name')) {
      name = prefs.getString('name');
      var type = prefs.getString('type');
      print(name);
      print(type);
    }
    dynamic coll1 = _db.collection('Products');
    List products = await coll1.find({"storename": name}).toList();
    List<ShopProductItem> finalList = [];
    var poignant = products.forEach((element) {
      finalList.add(ShopProductItem(
          quantity: element['quantity'],
          id: element["_id"],
          name: element['productname'],
          category: element['productcategory'],
          price: element['price'],
          rating: element['rating'],
          imageUrl: 'assets/cat.png'));
    });
    return finalList;
  }

  addProduct(ShopProductItem product) async {
    if (_db == null) {
      await getConnection();
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = '';
    if (prefs.containsKey('name')) {
      name = prefs.getString('name');
      print(name);
    }
    await _db.collection('Products').insertOne({
      "productname": product.name,
      'productcategory': product.category,
      "storename": name,
      'price': product.price,
      'quantity': product.quantity,
      'rating':0.0,
    }); //add storename and fix address capslock
  }

  addPost(postText) async {
    if (_db == null) {
      await getConnection();
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = '';
    String type = '';
    if (prefs.containsKey('name')) {
      name = prefs.getString('name');
      type = prefs.getString('type');
      print(name);
      print(type);
    }
    await _db.collection('Posts').insertOne({
      "posterName": name,
      "posterType": type,
      'text': postText,
      'time': DateTime.now(),
      'likes': 0,
      'likeList':[]
    });
  }

  addLike(postId, likes) async {
    if (_db == null) {
      await getConnection();
    }
    print(postId);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = '';
    String type = '';
    if (prefs.containsKey('name')) {
      name = prefs.getString('name');
      type = prefs.getString('type');
      print(name);
      print(type);
    }
    await _db.collection('Posts').findAndModify(
      query:{'_id':postId},
      update: {'\$set':{'likes':likes},
               '\$push':{'likeList':name}}
      );
  }

  addUser(name, email, password) async {
    if (_db == null) {
      await getConnection();
    }

    await _db
        .collection('Users')
        .insertOne({"name": name, "email": email, 'password': password});
  }

  Future getUsers() async {
    if (_db == null) {
      await getConnection();
    }

    dynamic coll1 = _db.collection('Users');
    List products = await coll1.find().toList();
    List<User> finalList = [];
    var poignant = products.forEach((element) {
      finalList.add(User(
          name: element['name'],
          email: element['email'],
          password: element['password']));
    });
    print("final list:");
    return finalList;
  }

  addPet(category, name, age) async {
    if (_db == null) {
      await getConnection();
    }

    await _db
        .collection('Pets')
        .insertOne({"name": name, "category": category, 'age': age});
  }
  addRescueRequest(RescueInfo request) async{
    if (_db == null) {
      await getConnection();
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = '';
    if (prefs.containsKey('name')) {
      name = prefs.getString('name');
    } 
    await _db.collection('Rescue').insertOne(
      {"name": name,
        "contactNo":request.contact,
        "lat": request.pos.latitude, 
        "long": request.pos.longitude,
        "petType":request.petType,
        "description":request.description,
        "time":DateTime.now()
    });

  }
  addOrder(OrderItem order) async{
    if (_db == null) {
      await getConnection();
    }
    print(order.name);
    List<ObjectId> ids = [];
    order.cartItems.forEach((element) {
      ids.add(element.id);
    });
    await _db.collection('Orders').insertOne({"userID": order.userID,
        "userName":order.name,
        "orderTime": order.time, 
        "orderStatus":order.status,
        "address":order.address,
        "city":order.city,
        "country":order.country,
        "orderItems": ids,
    });

  }

  changeUsername(curentName, newName) async {
    if (_db == null) {
      await getConnection();
    }

    dynamic coll = _db.collection('Users');

    var u = await coll.findOne({"name": curentName});
    u["name"] = newName;
    await coll.save(u);

    print('user name updated');
  }

  changePassword(curentName, newPassword) async {
    if (_db == null) {
      await getConnection();
    }

    dynamic coll = _db.collection('Users');

    var u = await coll.findOne({"name": curentName});
    u["password"] = newPassword;
    await coll.save(u);

    print('password updated');
  }

  changeEmail(currentName, newEmail) async {
    if (_db == null) {
      await getConnection();
    }

    dynamic coll = _db.collection('Users');

    var u = await coll.findOne({"name": currentName});
    u["email"] = newEmail;
    await coll.save(u);
    print('email updated');
  }

  removeLike(postId, likes) async {
    if (_db == null) {
      await getConnection();
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = '';
    String type = '';
    if (prefs.containsKey('name')) {
      name = prefs.getString('name');
      type = prefs.getString('type');
      print(name);
      print(type);
    }
    print(postId);
    await _db.collection('Posts').findAndModify(
      query:{'_id':postId},
      update: {'\$set':{'likes':likes},
              '\$pull':{'likeList':name}}
      );
  }
  editProduct(ObjectId id, ShopProductItem product) async {
    if (_db == null) {
      await getConnection();
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = '';
    String type = '';
    if (prefs.containsKey('name')) {
      name = prefs.getString('name');
      type = prefs.getString('type');
      print(name);
      print(type);
    }
    await _db.collection('Products').findAndModify(
      query:{'_id':id},
      update: {'\$set':
      {
        "productname": product.name,
        'productcategory': product.category,
        "storename": name,
        'price': product.price,
        'quantity': product.quantity,
      },
      }
      );
  }
  deleteShopProduct(ObjectId productID) async{
    if (_db == null) {
      await getConnection();
    }
    await _db.collection('Products').remove({'_id':productID});
  }
  closeConnection() {
    _db.close();
  }
}
