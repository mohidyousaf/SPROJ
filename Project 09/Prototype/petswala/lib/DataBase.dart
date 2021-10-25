import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';


class DBprovider {
  DBprovider._();

  static final DBprovider db = DBprovider._();
  static late Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      // delete = true only if database needs to be rebuilt from scratch
      _database = await this.initDB(delete: false);
      print('returned');
      return _database;
    }
  }

  initDB({delete: false}) async {
    print(await getDatabasesPath());
    if (delete) {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.remove('accountCheck');
      // prefs.remove('loggedIn');
      // prefs.remove('onBoarding');
      await deleteDatabase(join(await getDatabasesPath(), 'PetsWala.db'));
    }
    Database dbs = await openDatabase(
        join(await getDatabasesPath(),
            'PetsWala.db'), //join method comes from path package
        onCreate: (db, version) async {
          await db.execute('''
            PRAGMA foreign_keys = ON;
          ''');
          await db.execute('''
          CREATE TABLE IF NOT EXISTS users (
              UserID INTEGER,
              UserType	TEXT,
              ContactNumber	INTEGER,
              Address	TEXT,
              Password	TEXT,
              Description TEXT,
              PRIMARY KEY(UserID)
            );
            ''');

          await db.execute('''CREATE TABLE IF NOT EXISTS commonUsers (
              UserID INTEGER,
              UserName	TEXT,
              EmailID TEXT,
              ContactNumber	INTEGER,
              Address	TEXT,
              Status	TEXT,
              IsPetOwner INTEGER,
              PRIMARY KEY(UserID)
            );
            ''');

          await db.execute('''CREATE TABLE IF NOT EXISTS inventory (
              InventoryID	INTEGER ,
              InventoryType	TEXT,
              MerchandiseID	INTEGER,
              PetStoreID	TEXT,
              ProductPicture	BLOB,
              Quantity	REAL,
              ProductPrice	REAL,
              PRIMARY KEY(InventoryID)
              
            );
            ''');
          await db.execute('''CREATE TABLE IF NOT EXISTS purchases (
              PurchaseID	INTEGER ,
              ProductID	INTEGER,
              PurchasePrice	REAL,
              Quantity	INTEGER,
              FOREIGN KEY(ProductID) REFERENCES inventory(ProductID) ON DELETE CASCADE,
              PRIMARY KEY(PurchaseID)
            );
            ''');



        }, version: 1);
    return dbs;
  }

  login(username, password) async {
    final db = await database;
    String response = 'user not found';
    final List<Map<String, dynamic>> users =
    await db.query('users', where: 'Username = ?;', whereArgs: [username]);
    users.forEach((user) {
      if (user['Password'] == password) {
        response = "correct password";
      } else {
        response = 'incorrect password';
      }
    });
    return response;
  }

  newUser(username, name, emailAddress, password) async {
    final db = await database;
    print(username + " " + password);
    var res = await db.rawInsert('''
    INSERT INTO users(
      Username,Name,EmailAddress,Password
    ) VALUES (?,?,?,?)
    ''', [username, name, emailAddress, password]);

    return res;
  }


}