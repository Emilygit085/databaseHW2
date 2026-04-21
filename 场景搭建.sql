-- =============================================
-- 电商订单系统 - 完整数据库脚本
-- 包含：DDL (建表) + DML (插入测试数据)
-- 数据库：PostgreSQL
-- =============================================

-- ---------------------------------------------
-- 第一部分：表结构定义 (DDL)
-- ---------------------------------------------

-- 1. 用户表
CREATE TABLE users (
    user_id       SERIAL PRIMARY KEY,
    username      VARCHAR(50) NOT NULL UNIQUE,
    email         VARCHAR(100) UNIQUE,
    phone         CHAR(11),
    register_date DATE DEFAULT CURRENT_DATE,
    vip_level     INT DEFAULT 0
);

-- 2. 商品表
CREATE TABLE products (
    product_id   SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category     VARCHAR(50),
    price        DECIMAL(10, 2) NOT NULL,
    stock        INT DEFAULT 0,
    status       CHAR(1) DEFAULT 'A' CHECK (status IN ('A', 'I'))
);

-- 3. 订单表
CREATE TABLE orders (
    order_id     SERIAL PRIMARY KEY,
    user_id      INT NOT NULL,
    order_date   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2),
    status       VARCHAR(20) DEFAULT '待支付',
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE RESTRICT
);

-- 4. 订单明细表
CREATE TABLE order_items (
    item_id    SERIAL PRIMARY KEY,
    order_id   INT NOT NULL,
    product_id INT NOT NULL,
    quantity   INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE RESTRICT
);

-- ---------------------------------------------
-- 第二部分：测试数据插入 (DML)
-- 注意插入顺序：users / products → orders → order_items
-- ---------------------------------------------

-- 2.1 插入用户数据 (20条)
INSERT INTO users (user_id, username, email, phone, register_date, vip_level) VALUES
(1,  'zhang_wei',      'zhang.wei@mail.com',      '13800138001', '2024-01-15', 1),
(2,  'li_ting',        'li.ting@mail.com',        '13800138002', '2024-02-20', 0),
(3,  'wang_fang',      'wang.fang@mail.com',      '13800138003', '2024-03-10', 2),
(4,  'chen_jie',       'chen.jie@mail.com',       '13800138004', '2024-03-18', 0),
(5,  'zhao_lei',       'zhao.lei@mail.com',       '13800138005', '2024-04-05', 1),
(6,  'sun_li',         'sun.li@mail.com',         '13800138006', '2024-04-22', 0),
(7,  'zhou_tao',       'zhou.tao@mail.com',       '13800138007', '2024-05-08', 0),
(8,  'wu_jing',        'wu.jing@mail.com',        '13800138008', '2024-05-19', 1),
(9,  'zheng_shuang',   'zheng.shuang@mail.com',   '13800138009', '2024-06-02', 0),
(10, 'lin_na',         'lin.na@mail.com',         '13800138010', '2024-06-15', 2),
(11, 'he_jiong',       'he.jiong@mail.com',       '13800138011', '2024-06-28', 0),
(12, 'huang_xiaoming', 'huang.xm@mail.com',       '13800138012', '2024-07-10', 1),
(13, 'liu_yifei',      'liu.yifei@mail.com',      '13800138013', '2024-07-22', 0),
(14, 'yang_mi',        'yang.mi@mail.com',        '13800138014', '2024-08-05', 2),
(15, 'deng_chao',      'deng.chao@mail.com',      '13800138015', '2024-08-18', 0),
(16, 'sun_honglei',    'sun.hl@mail.com',         '13800138016', '2024-09-01', 1),
(17, 'huang_bo',       'huang.bo@mail.com',       '13800138017', '2024-09-14', 0),
(18, 'xu_zheng',       'xu.zheng@mail.com',       '13800138018', '2024-09-27', 0),
(19, 'wang_baoqiang',  'wang.bq@mail.com',        '13800138019', '2024-10-10', 1),
(20, 'shen_teng',      'shen.teng@mail.com',      '13800138020', '2024-10-23', 2);

-- 2.2 插入商品数据 (20条)
INSERT INTO products (product_id, product_name, category, price, stock, status) VALUES
(1,  '智能手机 X10',        '数码', 3999.00, 50,  'A'),
(2,  '轻薄笔记本电脑 Air',  '数码', 6999.00, 30,  'A'),
(3,  '无线降噪耳机',        '数码', 1299.00, 80,  'A'),
(4,  '运动智能手环',        '数码', 299.00,  120, 'A'),
(5,  '纯棉圆领T恤',         '服饰', 89.90,   200, 'A'),
(6,  '休闲牛仔裤',          '服饰', 159.00,  150, 'A'),
(7,  '跑步鞋 Ultra',        '鞋类', 499.00,  60,  'A'),
(8,  '双肩电脑包',          '箱包', 259.00,  90,  'A'),
(9,  '保温杯 500ml',        '家居', 79.00,   180, 'A'),
(10, '充电宝 20000mAh',     '数码', 149.00,  100, 'A'),
(11, '无线鼠标',            '数码', 59.00,   200, 'A'),
(12, '机械键盘',            '数码', 399.00,  70,  'A'),
(13, '移动固态硬盘 1TB',    '数码', 699.00,  40,  'A'),
(14, '经典白衬衫',          '服饰', 129.00,  110, 'A'),
(15, '女士风衣',            '服饰', 599.00,  35,  'A'),
(16, '儿童羽绒服',          '服饰', 899.00,  25,  'A'),
(17, '咖啡豆 500g',         '食品', 88.00,   150, 'A'),
(18, '坚果礼盒',            '食品', 199.00,  80,  'A'),
(19, '智能台灯',            '家居', 229.00,  60,  'A'),
(20, '便携榨汁机',          '家居', 189.00,  45,  'I');

-- 2.3 插入订单数据 (20条)
INSERT INTO orders (order_id, user_id, order_date, total_amount, status) VALUES
(1,  1,  '2024-11-01 09:15:00', 4288.90, '已完成'),
(2,  2,  '2024-11-02 14:30:00', 149.00,  '已完成'),
(3,  3,  '2024-11-03 10:00:00', 7698.00, '已完成'),
(4,  4,  '2024-11-04 16:20:00', 89.90,   '已取消'),
(5,  5,  '2024-11-05 11:45:00', 499.00,  '已支付'),
(6,  6,  '2024-11-06 19:10:00', 648.00,  '已发货'),
(7,  7,  '2024-11-07 13:25:00', 1299.00, '已完成'),
(8,  8,  '2024-11-08 08:50:00', 157.00,  '已完成'),
(9,  9,  '2024-11-09 20:30:00', 3999.00, '已支付'),
(10, 10, '2024-11-10 15:15:00', 287.00,  '已发货'),
(11, 11, '2024-11-11 12:00:00', 6999.00, '待支付'),
(12, 12, '2024-11-12 17:40:00', 528.90,  '已完成'),
(13, 13, '2024-11-13 09:05:00', 159.00,  '已取消'),
(14, 14, '2024-11-14 21:20:00', 1088.00, '已完成'),
(15, 15, '2024-11-15 11:10:00', 299.00,  '已发货'),
(16, 16, '2024-11-16 14:55:00', 899.00,  '已支付'),
(17, 17, '2024-11-17 18:30:00', 288.00,  '已完成'),
(18, 18, '2024-11-18 10:45:00', 259.00,  '已发货'),
(19, 19, '2024-11-19 13:15:00', 699.00,  '已完成'),
(20, 20, '2024-11-20 16:00:00', 189.00,  '已取消');

-- 2.4 插入订单明细数据 (20条)
INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price) VALUES
(1,  1,  1,  1, 3999.00),
(2,  1,  5,  1, 89.90),
(3,  1,  9,  2, 79.00),
(4,  2,  10, 1, 149.00),
(5,  3,  2,  1, 6999.00),
(6,  3,  3,  1, 1299.00),
(7,  4,  5,  1, 89.90),
(8,  5,  7,  1, 499.00),
(9,  6,  8,  1, 259.00),
(10, 6,  12, 1, 399.00),
(11, 7,  3,  1, 1299.00),
(12, 8,  11, 2, 59.00),
(13, 8,  9,  1, 79.00),
(14, 9,  1,  1, 3999.00),
(15, 10, 17, 2, 88.00),
(16, 10, 18, 1, 199.00),
(17, 11, 2,  1, 6999.00),
(18, 12, 5,  2, 89.90),
(19, 12, 14, 2, 129.00),
(20, 12, 11, 1, 59.00);

-- =============================================
-- 脚本结束
-- 你可以执行以下查询验证数据：
-- SELECT * FROM users;
-- SELECT * FROM products;
-- SELECT * FROM orders;
-- SELECT * FROM order_items;
-- =============================================