import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:odev_flutter/model/urun.dart';
import 'package:odev_flutter/urun2.dart';
import 'model/kategori.dart';

class UrunEkleme extends StatefulWidget {
  @override
  UrunEklemeState createState() => UrunEklemeState();
}

class UrunEklemeState extends State<UrunEkleme> {
  int urunSayisi;

  @override
  void initState() {
    kategoriler = Kategori.kategoriler;
    print(kategoriler.length);
    super.initState();
  }

  List<Kategori> kategoriler;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Ekle"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: kategoriler.length,
          itemBuilder: (context, int index) {
            Kategori kategori = kategoriler[index];
            return ListTile(
                title: Text(kategori.isim),
                leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                    maxWidth: 64,
                    maxHeight: 64,
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(kategori.link),
                  ),
                ),
                onTap: () {
                  UrunEkle(kategori.isim,kategori.link, kategori.sicaklik);
                  kategoriler.removeAt(index);
                });
          }),
    );
  }

  void UrunEkle(String text,String link, double sicaklik) {
    Urun.urunler.add(Urun(isim: text,link: link ,sicaklik: sicaklik));
    Navigator.pop(context);
  }

  Future navigateToSubPage(context) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => Urun2()));
}
