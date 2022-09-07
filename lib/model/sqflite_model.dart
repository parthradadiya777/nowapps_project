class Product {
  int? _id;
  String? _name;
  String? _price;
  String? _image;
 // String? _count;


//  Product.withId(this._id, this._name, this._price,this._image);

  Product(this._id, this._name, this._price,this._image);

  // get set in id
  int get id => _id!;

  set id(int value) {
    _id = value;
  }

  // get set in name
  String get name => _name!;

  set name(String value) {
    _name = value;
  }

  String get price => _price!;

  set price(String value) {
    _price = value;
  }

  String get image => _image!;

  set image(String value) {
    _image = value;
  }



  Map<String, dynamic> tomap() {
    // ignore: prefer_collection_literals
    var map = Map<String, dynamic>();

    map['id'] = _id;
    map['name'] = _name;
    map['price'] = _price;
    map['image'] = _image;
  //  map['count'] = _count;

    return map;
  }

  Product.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _name = map['name'];
    _price = map['price'];
    _image = map['image'];
 //   _count = map['count'];
  }
}