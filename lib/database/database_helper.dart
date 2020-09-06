import 'dart:async';
import 'dart:io';
import 'package:guide_app/models/partner_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "guide.db");
    var db = await openDatabase(path, version: 1,
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
        },
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE IF NOT EXISTS "partner" (id integer primary key autoincrement, name TEXT, image TEXT, location	TEXT, type TEXT)''');
      await db.execute('''INSERT INTO partner(Name, image, Location, type) VALUES
              ("Torgan Hammam", "1.jpeg", "Tétouan تطوان", "Spa-hammam حمام-منتجع صحي"),
              ("Norte de Africa", "2.jpeg", "Ceuta سبتة", "Agence وكالة وكالات"),
              ("L'escapade", "3.jpeg", "Marrakech مراكش", "Cafes مقاهي مقهى Restaurants مطعم مطاعم"),
              ("Tamouda Shop", "4.jpeg", "M'diq مضيق", "Coiffure حلاقة"),
              ("Senator Hotel", "5.jpeg", "Fnideq, Tétouan تطوان الفنيدق", "Hotels فندق فنادق"),
              ("Syrene Bateau Restaurant Promenade en mer ", "6.jpeg", "Port marina smir, marina beach ميناء مارينا سمير", "Loisirs هوايات هواية Restaurants مطعم مطاعم"),
              ("PARAPHARMACIE Bab Sebta", "7.jpeg", "Fnideq الفنيدق", "Parapharmacie صيدلية Sante الصحة"),
              ("Joyeria MARAM", "8.jpeg", "Fnideq الفنيدق", "Bijouterie متجر مجوهرات"),
              ("Institut Prive Amjad Al Andalous", "9.jpeg", "Fnideq الفنيدق", "Ecoles مدرسة مدارس"),
              ("Auto/Moto Janane Khalid", "10.jpeg", "Rsd. Al Amira, Bv. Lyle, Imm Assil étg 1 N 1", "Ecoles مدرسة مدارس"),
              ("Mary Joya", "11.jpeg", "Fnideq الفنيدق", "Spa-hammam حمام-منتجع صحي"),
              ("Panaderia Pasteleria Zahrae", "12.jpeg", "Fnideq الفنيدق", "Patisserie - boulangerie مخبزة - حلويات"),
              ("La Ferma", "13.jpeg", "M'diq مضيق", "Hotels فنادق فندق  Restaurants مطعم مطاعم Loisirs هوايات هواية"),
              ("Chams", "14.jpeg", "Tétouan تطوان", "Hotels فنادق فندق"),
              ("Espace Dar Argana", "15.jpeg", "M'diq مضيق", "Spa-hammam حمام-منتجع صحي"),
              ("Meubles Israa", "16.jpeg", "M'diq مضيق", "Deco تزيين"),
              ("Agence Immobay", "17.jpeg", "M'diq مضيق Tétouan تطوان", "Agence وكالة وكالات"),
              ("Rayhanat Martil", "18.jpeg", "Martil مارتيل", "Hammam-Spa حمام-منتجع صحي"),
              ("Nardina Golden", "19.jpeg", "M'diq مضيق Tétouan تطوان", "Immobilier عقار"),
              ("JENBIDAM", "20.jpeg", "Fnideq الفنيدق", "Deco تزيين"),
              ("Electroménager", "21.jpeg", "Fnideq الفنيدق", "Electromenager الأجهزة المنزلية"),
              ("Studio Bati9a", "22.jpeg", "Fnideq الفنيدق", "Agence وكالة وكالات"),
              ("Centre Lilyan", "23.jpeg", "Fnideq الفنيدق", "ecoles مدارس"),
              ("BEGOS", "24.jpeg", "CasaBlanca الدار البيضاء", "Construction البناء Deco تزيين"),
              ("Centre Ben Omar Hijama et Massage", "25.jpeg", "Fnideq الفنيدق", "Sante الصحة"),
              ("Etablissement AL NOUR", "26.jpeg", "Fnideq الفنيدق", "Ecoles مدرسة مدارس"),
              ("Peluquería y Estética", "27.jpeg", "Fnideq الفنيدق", "Coiffure حلاقة"),
              ("Dadach Yachting", "28.jpeg", "M'diq مضيق", "Loisirs هواية هوايات"),
              ("Etablissement MALAIKAT EL M'DIQ", "29.jpeg", "M'diq مضيق", "ecoles مدارس"),
              ("Para Pharmacie", "30.jpeg", "Agadir أݣادير أكادير أغادير", "Parapharmacie صيدلية Sante الصحة"),
              ("Fine Fish", "31.jpeg", "Agadir أݣادير أكادير أغادير", "Restaurants مطعم مطاعم"),
              ("Abdooart", "32.jpeg", "Béni Mellal بني ملال", "Agence وكالة وكالات Photographie التصوير"),
              ("Ste HMAIDOUT", "33.jpeg", "Agadir أݣادير أكادير أغادير", "Agence وكالة وكالات Location Voiture كراء السيارات"),
              ("Hilal Sport", "34.jpeg", "Agadir أݣادير أكادير أغادير", "Vetements ملابس"),
              ("Allo Dr", "35.jpeg", "Fnideq الفنيدق", "Sante الصحة"),
              ("GALLERIE ATLAS", "36.jpeg", "Agadir أݣادير أكادير أغادير", "Vetements ملابس"),
              ("TIMA IMA", "37.jpeg", "Fnideq الفنيدق", "Deco تزيين Peinture الرسم الصباغة"),
              ("M'DIQ CAR", "38.jpeg", "M'diq مضيق", "Agence وكالة وكالات Location Voiture كراء السيارات"),
              ("RESTAURANT PRINCIPE", "39.jpeg", "Fnideq الفنيدق", "Restaurants مطعم مطاعم Salle des fetes قاعة أفراح"),
              ("RESTAURANT ROTTERDAM", "40.jpeg", "Fnideq الفنيدق", "Restaurants مطعم مطاعم"),
              ("M'DIQ CHANGE", "41.jpeg", "M'diq مضيق", "Agence وكالة وكالات"),
              ("PALACE ALAHRAM", "42.jpeg", "Tétouan تطوان", "Salle des fetes قاعة أفراح"),
              ("NAPOLIE BRUNCH", "43.jpeg", "Agadir أݣادير أكادير أغادير", "Restaurants مطعم مطاعم Cafes مقاهي مقهى"),
              ("LA TUNISERIE", "44.jpeg", "Agadir أݣادير أكادير أغادير", "Cafes مقاهي مقهى Patisserie - boulangerie مخبزة - حلويات"),
              ("Vettore by Sabrine", "45.jpeg", "Fnideq الفنيدق", "Electromenager الأجهزة المنزلية"),
              ("LA HIPICA", "46.jpeg", "Tétouan تطوان", "Restaurants مطعم مطاعم");
''');
    });
    return db;
  }

  Future<Partner> insert(Partner p) async {
    var dbClient = await db;
    p.id = await dbClient.insert("partner", p.toMap());
    return p;
  }

  drop() async {
    var dbClient = await db;
    dbClient.close();
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "guide.db");
    await deleteDatabase(path);
  }
}
