

import 'package:guide_app/database/database_helper.dart';

class Partner {
  int id;
  String name;
  String tele;
  String fb;
  String insta;
  String location;
  String type;
  String image;

//  Partner(this.id, this.name);

  Partner(
      this.id,
      this.name,
      this.tele,
      this.fb,
      this.insta,
      this.location,
      this.type,
      this.image); // Convert a Partner into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'tele': tele,
      'fb': fb,
      'insta': insta,
      'location': location,
      'type': type,
      'image': image,
    };
  }

  factory Partner.fromMap(Map<String, dynamic> data) {
    return Partner(
      data['id'],
      data['name'],
      data['tele'],
      data['fb'],
      data['insta'],
      data['location'],
      data['type'],
      data['image'],
    );
  }

  static Future getPartnerByID(int id) async{
    DatabaseHelper dh = DatabaseHelper();
    var db = await dh.db;
    var result = await db.query("partner", where: "id = ?", whereArgs: [id]);
    return result.isNotEmpty ? Partner.fromMap(result.first) : Null;
  }

  static Future<List<Partner>> getAllPartners() async {
    DatabaseHelper dh = DatabaseHelper();
    var db = await dh.db;
    List<Map> results = await db.query(
        "partner", orderBy: "id ASC"
    );
    List<Partner> partners = new List();
    results.forEach((result) {
      Partner partner = Partner.fromMap(result);
      partners.add(partner);
    });
    return partners;
  }

  static Future<List<Partner>> getAllPartnersByType(String type) async {
    DatabaseHelper dh = DatabaseHelper();
    var db = await dh.db;
    String sqlQuery = "SELECT * from partner where type like '%$type%'";
    List<Map> results = await db.rawQuery(sqlQuery);
    List<Partner> partners = new List();
    results.forEach((result) {
      Partner partner = Partner.fromMap(result);
      partners.add(partner);
    });
    return partners;
  }

  //searching by a term
  static Future<List<Partner>> getAllPartnersByParam(String type, String term) async {
    DatabaseHelper dh = DatabaseHelper();
    var db = await dh.db;
//    List<Map> results = await db.query(
//        "partner", orderBy: "id ASC", where: "name = ? or location = ? or type = ?", whereArgs: [term, term, type]
//    )
    String sqlQuery;
    if(type == "") {
      sqlQuery = "SELECT * from partner where name Like '%$term%' or location like '%$term%' or type like '%$term%'";
    } else {
      sqlQuery = "SELECT * from partner where (name Like '%$term%' or location like '%$term%' or type like '%$term%') and type like '%$type%'";
    }
    List<Map> results = await db.rawQuery(sqlQuery);
    List<Partner> partners = new List();
    results.forEach((result) {
      Partner partner = Partner.fromMap(result);
      partners.add(partner);
    });
    return partners;
  }
}