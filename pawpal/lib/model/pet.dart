class Pet {
  String? petId;
  String? userId;
  String? petName;
  String? petType;
  String? category;
  String? petDescription;
  String? imagePaths;
  String? petLatitude;
  String? petLongitude;
  String? petDate;

  Pet({
    this.petId,
    this.userId,
    this.petName,
    this.petType,
    this.category,
    this.petDescription,
    this.imagePaths,
    this.petLatitude,
    this.petLongitude,
    this.petDate,
  });

  Pet.fromJson(Map<String, dynamic> json) {
    petId = json['pet_id'];
    userId = json['user_id'];
    petName = json['pet_name'];
    petType = json['pet_type'];
    category = json['category'];
    petDescription = json['description'];
    imagePaths = json['image_paths'];
    petLatitude = json['lat'];
    petLongitude = json['lng'];
    petDate = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pet_id'] = petId;
    data['user_id'] = userId;
    data['pet_name'] = petName;
    data['pet_type'] = petType;
    data['category'] = category;
    data['description'] = petDescription;
    data['image_paths'] = imagePaths;
    data['lat'] = petLatitude;
    data['lng'] = petLongitude;
    data['created_at'] = petDate;
    return data;
  }
}
