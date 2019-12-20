class Kategori {
  String isim;
  String link;
  double sicaklik;
  static List<Kategori> kategoriler = [
    Kategori(
        isim: "Kırmızı Et",
        link: "https://images.unsplash.com/photo-1560781290-7dc94c0f8f4f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=375&q=80",
        sicaklik: -4),
    Kategori(
        isim: "Soğan",
        link: "https://images.unsplash.com/photo-1507633698035-8e4bd1573e09?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=667&q=80",
        sicaklik: 10),
    Kategori(
        isim: "Corba",
        link: "https://images.unsplash.com/photo-1549716678-0effb16786e5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=390&q=80",
        sicaklik: 60),
        Kategori(
        isim: "Limon",
        link: "https://images.unsplash.com/photo-1562599938-e6fe2a67574b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=335&q=80",
        sicaklik: 15),
        Kategori(
        isim: "Süt",
        link: "https://images.unsplash.com/photo-1550583724-b2692b85b150?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80",
        sicaklik: 4),
        Kategori(
        isim: "Balık",
        link: "https://images.unsplash.com/photo-1510130387422-82bed34b37e9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=375&q=80",
        sicaklik: -5),
        Kategori(
        isim: "Marul",
        link: "https://images.unsplash.com/photo-1506073881649-4e23be3e9ed0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=667&q=80",
        sicaklik: 4),
        Kategori(
        isim: "Maydanoz",
        link: "https://images.unsplash.com/photo-1528796940112-4979b4a98424?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=751&q=80",
        sicaklik: 40),
        Kategori(
        isim: "Ispanak",
        link: "https://images.unsplash.com/photo-1573381353478-4f9ad238ade5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=80",
        sicaklik: 28),
  ];
  Kategori({this.isim, this.link, this.sicaklik});
}
