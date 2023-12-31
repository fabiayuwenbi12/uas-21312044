import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Object?>> GetData() async {
    CollectionReference products = firestore.collection('products');

    return products.get();
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference products = firestore.collection('products');
    return products.snapshots();
  }
}