SELECT a.id,a.goods_name,a.shop_price,a.addtime,IFNULL(GROUP_CONCAT(b.attr_value),'') attr_value,(SELECT COUNT(c.id) 
FROM php34_comment c WHERE a.id=c.goods_id) pl,(
SELECT IFNULL(SUM(d.goods_number),0) FROM php34_order_goods d 
LEFT JOIN php34_order e ON d.order_id=e.id WHERE e.pay_status=1 AND d.goods_id=a.id) xl 
FROM php34_goods a 
LEFT JOIN php34_goods_attr b ON a.id=b.goods_id WHERE a.is_on_sale=1 AND a.is_delete=0 GROUP BY a.id

# ʵ������ ������Ʒ�ļ۸� �������� ����   ��Ʒ������ ��Ҫ�ڲ�ѯ�������
# ÿ����Ʒ�������� ˼·: ���۱��ȡ��Ʒ������
SELECT a.id,a.goods_name,a.shop_price,a.addtime, IFNULL( GROUP_CONCAT(ga.attr_value),'') as attr_value,
# ��Ʒ��������
(SELECT COUNT(c.id) FROM shop_comment c WHERE a.id=c.goods_id)AS pl, 
# ��Ʒ������Ϊ��Ʒ�Ķ�����Ʒ������ ������һ�µ���
IFNULL((SELECT SUM(og.goods_number) FROM shop_order_goods og LEFT JOIN shop_order o on o.id = og.order_id WHERE o.pay_status = 1 AND og.goods_id = a.id),0) AS XL  
FROM shop_goods a
# ������Ʒ������
LEFT JOIN shop_goods_attr ga on a.id = ga.goods_id where  a.is_on_sale =1 and a.is_delete = 0 GROUP BY a.id;


# ������SQL
SELECT a.id,a.goods_name,a.shop_price,a.addtime, IFNULL( GROUP_CONCAT(ga.attr_value),'') as attr_value,(SELECT COUNT(c.id) FROM shop_comment c WHERE a.id=c.goods_id)AS pl,IFNULL((SELECT SUM(og.goods_number) FROM shop_order_goods og LEFT JOIN shop_order o on o.id = og.order_id WHERE o.pay_status = 1 AND og.goods_id = a.id),0) AS XL FROM shop_goods a LEFT JOIN shop_goods_attr ga on a.id = ga.goods_id where  a.is_on_sale =1 and a.is_delete = 0 GROUP BY a.id;



DROP TABLE IF EXISTS shinx_id;
create table shinx_id (
    `max_id` int unsigned not null default '0' comment '�Ѿ������õ����һ����¼��id'
);


SELECT a.userId,a.userName,b.isAudit,b.isOfficer,b.honor 
FROM t_users a 
LEFT JOIN t_apply_audit b 
ON a.userId=b.userId 
WHERE a.userId=10057 
AND b.communityId=8

SELECT userId,userName,
FROM t_users
where userId = 10057;