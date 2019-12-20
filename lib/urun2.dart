import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:odev_flutter/firebase.dart';
import 'package:odev_flutter/model/kategori.dart';
import 'package:odev_flutter/model/urun.dart';
import 'package:odev_flutter/urun_ekleme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Urun2 extends StatefulWidget {
  @override
  _Urun2 createState() => _Urun2();
}

class _Urun2 extends State<Urun2> {
  List<Urun> urunler;
  FirebaseService service;
  FirebaseDatabase database = new FirebaseDatabase();
  String ab;
  int sa =new DateTime(2019).day;
  double urunSicakligi;
  String odaSicakligi = "0";
  int urunSayisi;
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  _Urun2(){
    database.reference().onChildChanged.listen(degistir);
  }
  void degistir(Event event){
      
    setState(() {
      odaSicakligi = event.snapshot.value;
    });
  }
  void yenile() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
  void bekle() async {
    await Future.delayed(Duration(milliseconds: 100));
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    urunler = Urun.urunler;
    database = FirebaseDatabase();
    service = FirebaseService();
    odaSicakligi = service.getSicaklik().toString();
    print(urunSayisi);
    print(sa);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar,
      floatingActionButton: ekleButton,
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("Yuklemek icin asagi cek.");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Yukleme Basarisiz! Tekrar deneyin!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("Daha fazla yüklemek için bırakın.");
            } else {
              body = Text("Daha fazla data yok.");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onLoading: bekle,
        onRefresh: yenile,
        child: listeYazdir,
      ),
    );
  }

  Widget ekranYazdir() {
    return FutureBuilder(
      future: service.getSicaklik(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasData) {
              odaSicakligi = snapshot.data;
              return sicaklikGoster(snapshot.data);
            } else
              return bulunamadiWidget;
            break;
          default:
            return bekleWidget;
        }
      },
    );
  }

  Widget get listeYazdir => ListView.builder(
      itemCount: urunler.length,
      itemBuilder: (BuildContext context, int index) {
        Urun urun = urunler[index];
        
        urunSicakligi = urunler[index].sicaklik;
        return Dismissible(
          key: new Key(urunler[index].toString()),
          onDismissed: (direction) {
            List<Kategori> kategoriler = Kategori.kategoriler;
            kategoriler.add(new Kategori(
            isim: urunler[index].isim,
            link: urunler[index].link,
            sicaklik: urunler[index].sicaklik));
            urunler.removeAt(index);
            final LocalStorage storage = new LocalStorage('yemeklerim');
            storage.setItem("yemek", Urun.urunler);
            Scaffold.of(context).showSnackBar(new SnackBar(
              content: new Text("Urun silindi"),
              
            ));
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: sicaklikKontrol(urun.sicaklik, double.parse(odaSicakligi)),
                //color: Colors.red,
              ),
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          urun.link,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(urun.isim, style: TextStyle(fontSize: 20)),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              urun.sicaklik.toString(),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Divider(
                      height: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });

  Widget sicaklikGoster(String list) {
    return Container(
      child: Text(list),
    );
  }

  Widget get bulunamadiWidget => Center(
        child: Text("Bulunamadı"),
      );

  Widget get bekleWidget => Center(child: CircularProgressIndicator());

  Widget get ekleButton => FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => UrunEkleme()));
        },
        child: Icon(Icons.add),
      );
  Widget get _appbar => AppBar(
        centerTitle: true,
        title: Text("Güvenli Kilerim"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: Center(child: ekranYazdir()),
          )
        ],
      );

  Color sicaklikKontrol(double urunSicakligi, double odaSicakligi) {
    if (odaSicakligi < urunSicakligi) {
      return Colors.green.withOpacity(0.4);
    } else
      return Colors.red;
  }
  
}
