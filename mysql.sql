SELECT a.id,a.goods_name,a.shop_price,a.addtime,IFNULL(GROUP_CONCAT(b.attr_value),'') attr_value,(SELECT COUNT(c.id) 
FROM php34_comment c WHERE a.id=c.goods_id) pl,(
SELECT IFNULL(SUM(d.goods_number),0) FROM php34_order_goods d 
LEFT JOIN php34_order e ON d.order_id=e.id WHERE e.pay_status=1 AND d.goods_id=a.id) xl 
FROM php34_goods a 
LEFT JOIN php34_goods_attr b ON a.id=b.goods_id WHERE a.is_on_sale=1 AND a.is_delete=0 GROUP BY a.id

# 实际需求 考虑商品的价格 评论数量 销量   商品的属性 都要在查询的语句内
# 每个商品的评论数 思路: 评论表获取商品的数据
SELECT a.id,a.goods_name,a.shop_price,a.addtime, IFNULL( GROUP_CONCAT(ga.attr_value),'') as attr_value,
# 商品的评论数
(SELECT COUNT(c.id) FROM shop_comment c WHERE a.id=c.goods_id)AS pl, 
# 商品的销量为商品的订单商品的数量 必须是一下单的
IFNULL((SELECT SUM(og.goods_number) FROM shop_order_goods og LEFT JOIN shop_order o on o.id = og.order_id WHERE o.pay_status = 1 AND og.goods_id = a.id),0) AS XL  
FROM shop_goods a
# 关联商品的属性
LEFT JOIN shop_goods_attr ga on a.id = ga.goods_id where  a.is_on_sale =1 and a.is_delete = 0 GROUP BY a.id;


# 整理后的SQL
SELECT a.id,a.goods_name,a.shop_price,a.addtime, IFNULL( GROUP_CONCAT(ga.attr_value),'') as attr_value,(SELECT COUNT(c.id) FROM shop_comment c WHERE a.id=c.goods_id)AS pl,IFNULL((SELECT SUM(og.goods_number) FROM shop_order_goods og LEFT JOIN shop_order o on o.id = og.order_id WHERE o.pay_status = 1 AND og.goods_id = a.id),0) AS XL FROM shop_goods a LEFT JOIN shop_goods_attr ga on a.id = ga.goods_id where  a.is_on_sale =1 and a.is_delete = 0 GROUP BY a.id;



DROP TABLE IF EXISTS shinx_id;
create table shinx_id (
    `max_id` int unsigned not null default '0' comment '已经创建好的最后一条记录的id'
);