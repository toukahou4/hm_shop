class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id, required this.imgUrl});
  // 扩展一个工厂函数，一般用factory来声明 一般用来创建实例对象
  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(
      id: json['id'] ?? '',
      imgUrl: json['imgUrl'] ?? '',
    );
  }

}

// Map<String ,dynamic> 是一个泛型类，它可以存储任意类型的键值对
// 每一个轮播图具体类型
// flutter必须强制转化，没有隐式转化

// 根据json编写class对象和工厂转化函数
class CategoryItem {
  final String id;
  final String name;
  final String picture;
  final List<CategoryItem>? children;
  final List<dynamic>? goods;

  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children,
    this.goods,
  });

  // 工厂方法从json创建CategoryItem对象
  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'],
      name: json['name'],
      picture: json['picture'],
      children: json['children'] != null
          ? (json['children'] as List).map((item) => CategoryItem.fromJson(item)).toList()
          : null,
      goods: json['goods'],
    );
  }
}

class SpecialOffersResult {
  final String id;
  final String title;
  final List<SpecialOfferSubType> subTypes;
  SpecialOffersResult({required this.id, required this.title, required this.subTypes});
  factory SpecialOffersResult.fromJson(Map<String, dynamic> json) {
    return SpecialOffersResult(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subTypes: (json['subTypes'] as List? ?? [])
          .map((e) => SpecialOfferSubType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SpecialOfferSubType {
  final String id;
  final String title;
  final GoodsItems goodsItems;
  SpecialOfferSubType({required this.id, required this.title, required this.goodsItems});
  factory SpecialOfferSubType.fromJson(Map<String, dynamic> json) {
    return SpecialOfferSubType(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      goodsItems: GoodsItems.fromJson(json['goodsItems'] ?? {}),
    );
  }
}

class GoodsItems {
  final int counts;
  final int pageSize;
  final int pages;
  final int page;
  final List<GoodsItem> items;
  GoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });
  factory GoodsItems.fromJson(Map<String, dynamic> json) {
    int parseInt(dynamic v) => v is int ? v : int.tryParse('${v ?? ''}') ?? 0;
    return GoodsItems(
      counts: parseInt(json['counts']),
      pageSize: parseInt(json['pageSize']),
      pages: parseInt(json['pages']),
      page: parseInt(json['page']),
      items: (json['items'] as List? ?? [])
          .map((e) => GoodsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class GoodsItem {
  final String id;
  final String name;
  final String? desc;
  final String price;
  final String picture;
  final int orderNum;
  GoodsItem({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });
  factory GoodsItem.fromJson(Map<String, dynamic> json) {
    int parseInt(dynamic v) => v is int ? v : int.tryParse('${v ?? ''}') ?? 0;
    return GoodsItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      desc: json['desc'],
      price: json['price']?.toString() ?? '',
      picture: json['picture'] ?? '',
      orderNum: parseInt(json['orderNum']),
    );
  }
}

class GoodDetailItem extends GoodsItem {
  int payCount = 0;

  // 商品详情项
  GoodDetailItem({
    required super.id,
    required super.name,
    required super.price,
    required super.picture,
    required super.orderNum,
    required this.payCount,
  }) : super(desc: "");

  // 转化方法
  factory GoodDetailItem.formJSON(Map<String, dynamic> json) {
    return GoodDetailItem(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      price: json["price"]?.toString() ?? "",
      picture: json["picture"]?.toString() ?? "",
      orderNum: int.tryParse(json["orderNum"]?.toString() ?? "0") ?? 0,
      payCount: int.tryParse(json["payCount"]?.toString() ?? "0") ?? 0,
    );
  }
}


class GoodsDetailsItems {
  final int counts;
  final int pageSize;
  final int pages;
  final int page;
  final List<GoodDetailItem> items;
  GoodsDetailsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });
  factory GoodsDetailsItems.fromJson(Map<String, dynamic> json) {
    int parseInt(dynamic v) => v is int ? v : int.tryParse('${v ?? ''}') ?? 0;
    return GoodsDetailsItems(
      counts: parseInt(json['counts']),
      pageSize: parseInt(json['pageSize']),
      pages: parseInt(json['pages']),
      page: parseInt(json['page']),
      items: (json['items'] as List? ?? [])
          .map((e) => GoodDetailItem.formJSON(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
