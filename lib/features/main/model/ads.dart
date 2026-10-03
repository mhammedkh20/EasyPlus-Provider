class Ads {
  int? id;
  String? image;
  String? categoryId;
  String? status;
  String? createdAt;
  String? updatedAt;

  Ads({
    this.id,
    this.image,
    this.categoryId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Ads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    categoryId = json['category_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
