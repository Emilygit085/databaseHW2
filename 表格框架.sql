-- =============================================
-- 电商订单系统 - 表结构定义 (DDL)
-- 数据库：PostgreSQL
-- =============================================

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
    -- A: 在售 (Active), I: 下架 (Inactive)
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

-- =============================================
-- 说明：
-- 1. SERIAL 是 PostgreSQL 的自增整数类型。
-- 2. ON DELETE RESTRICT：当被引用记录存在时，禁止删除父表记录。
--    ON DELETE CASCADE：删除订单时，自动级联删除订单明细。
-- 3. 可根据需要调整字段长度或约束。
-- =============================================