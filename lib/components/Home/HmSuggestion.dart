import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmSuggestion extends StatefulWidget {
  final SpecialOffersResult specialOffersResult;
  HmSuggestion({Key? key, required this.specialOffersResult}) : super(key: key);

  @override
  _HmSuggestionState createState() => _HmSuggestionState();
}

class _HmSuggestionState extends State<HmSuggestion> {

  // 取前3条数据
  List<GoodsItem> _getDisplayItems() {
    if(widget.specialOffersResult.subTypes.isEmpty) return [];
    // 取得前三条数据
    return widget.specialOffersResult.subTypes.first.goodsItems.items.take(3).toList();
  }

  Widget _buildHeader () {
    return Row (
      children: [
        Text(
          "特惠推荐", 
          style: TextStyle(
            color: const Color.fromARGB(255, 86, 24, 20),
            fontSize: 18.0 ,
            fontWeight: FontWeight.w700,
          ),
        ), 
        SizedBox(width: 10.0,),
        Text(
          "精选省攻略",
          style: TextStyle(
            fontSize: 12, 
            color: const Color.fromARGB(255, 124, 63, 50),
          ),
        )
      ],
    );
  }

  // 左侧结构
  Widget _buildLeft () {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage("lib/assets/home_cmd_inner.png"),
          fit: BoxFit.cover)
      ),
    );
  }

  List<Widget> _getChildrenList () {
    List<GoodsItem> list = _getDisplayItems();
    return List.generate(list.length, (int index) {
      return Column(
        children: [
          // ClipRRect 可以包裹子元素 裁剪图片设置圆角
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              // 图片构建失败，会走这个回调
              errorBuilder: (context, error, stackTrace){
                // 返回一个新的部件替换原有图片
                return Image.asset(
                  "lib/assets/home_cmd_inner.png",
                  width: 100, 
                  height: 140, 
                  fit: BoxFit.cover);
              },
              list[index].picture, 
              width: 100, 
              height: 140, 
              fit: BoxFit.cover)
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromARGB(255, 240, 96, 12),
            ),
            child: Text("¥${list[index].price}", style: TextStyle(color : Colors.white),),
          )
        ],
      );
    });
  }

  // 完成渲染
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12),
        // height: 300.0,
        decoration: BoxDecoration(
          color: Colors.blue,
          image: DecorationImage(
            image: AssetImage("lib/assets/home_cmd_sm.png"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(15.0)
        ),
        child: Column(
          children: [
            // 顶部内容
            _buildHeader(),
            SizedBox(height: 10,),
            Row(
              children: [
                _buildLeft(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _getChildrenList(),
                  ) 
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}