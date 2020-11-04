class Kat {
  String name;
  String breed;
  String imgUrl;

  //Constructor
  Kat(this.name, this.breed, this.imgUrl);

  //Method we use to take incoming json in the {String: value} format and put
  // the values in the class properties
  Kat.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    breed = json['breed'];
    imgUrl = json['image'];
  }
}
