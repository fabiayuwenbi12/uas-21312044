import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  late TextEditingController cNama;
  late TextEditingController cHarga;
  //TODO: Implement AddProductController

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addProduct(String nama, String harga) async{
    CollectionReference product = firestore.collection("Product");

    try {
      await product.add({
        "name": nama,
        "price": harga,
      });
      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil menyimpan data product",
        onConfirm: () {
          cNama.clear();
          cHarga.clear();
          Get.back();
          Get.back();
          textConfirm:
          "Ok";
        });
    } catch (e) {
      
    }
  }

  @override
  void onInit() {
    cNama = TextEditingController();
    cHarga = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    cNama.dispose();
    cHarga.dispose();
    super.onClose();
  }
}
