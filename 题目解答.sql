-- Extracted SQL from databaseHW2.docx
-- Source: C:\Users\24307\Downloads\databaseHW2.docx
-- Generated: 2026-05-06 23:54:23
-- Notes: Word code-block content was extracted; duplicated pasted copies inside the same block were collapsed.

-- ============================================================
-- SQL block 1 (source raw block 1, paragraphs 38-65, statements 1)
-- Context: •【答题人1 SQL语句】：...
-- ============================================================
SELECT
    o.order_id,
    u.username,
    o.order_date,
    o.status AS order_status,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price AS item_subtotal
FROM orders o
INNER JOIN users u ON o.user_id = u.user_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id
ORDER BY o.order_id ASC, oi.item_id ASC;

-- ============================================================
-- SQL block 2 (source raw block 2, paragraphs 71-100, statements 1)
-- Context: •【答题人2 SQL语句】：.
-- ============================================================
SELECT
    o.order_id,
    u.username,
    o.order_date,
    o.status,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price AS total_price
FROM
    orders o
JOIN  users u ON o.user_id = u.user_id
JOIN  order_items oi ON o.order_id = oi.order_id
JOIN  products p ON oi.product_id = p.product_id
ORDER BY o.order_id ASC, oi.item_id ASC;

-- ============================================================
-- SQL block 3 (source raw block 3, paragraphs 116-139, statements 1)
-- Context: •【答题人1 陈慧欣 SQL语句】：
-- ============================================================
SELECT
    p.category,
    SUM(oi.quantity) AS total_quantity,
    SUM(oi.quantity * oi.unit_price) AS total_sales_amount,
    COUNT(DISTINCT o.order_id) AS order_count
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id
WHERE o.status = '已完成'
GROUP BY p.category
HAVING SUM(oi.quantity * oi.unit_price) > 500
ORDER BY total_sales_amount DESC;

-- ============================================================
-- SQL block 4 (source raw block 4, paragraphs 145-170, statements 1)
-- Context: •【答题人2 SQL语句】：
-- ============================================================
SELECT
    p.category,
    SUM(oi.quantity) AS total_quantity,
    SUM(oi.quantity * oi.unit_price) AS total_sales,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM
    products p
JOIN  order_items oi ON p.product_id = oi.product_id
JOIN  orders o ON oi.order_id = o.order_id
WHERE o.status = '已完成'
GROUP BY p.category
HAVING SUM(oi.quantity * oi.unit_price) > 500
ORDER BY total_sales DESC;

-- ============================================================
-- SQL block 5 (source raw block 5, paragraphs 183-208, statements 2)
-- Context: •【答题人1 SQL语句】：...
-- ============================================================
SELECT
    o.order_id,
    u.username,
    o.total_amount,
    o.status,
    o.order_date
FROM orders o
INNER JOIN users u ON o.user_id = u.user_id
WHERE o.total_amount > (;

    SELECT AVG(total_amount)
    FROM orders
)
ORDER BY o.total_amount DESC;

-- ============================================================
-- SQL block 6 (source raw block 6, paragraphs 214-243, statements 2)
-- Context: •【答题人2 SQL语句】：
-- ============================================================
SELECT
    o.order_id,
    u.username,
    o.total_amount,
    o.status,
    o.order_date
FROM
    orders o
JOIN  users u ON o.user_id = u.user_id
JOIN  order_items oi ON o.order_id = oi.order_id
WHERE o.total_amount > (;

    SELECT AVG(total_amount)
    FROM orders
    )
ORDER BY o.total_amount DESC;

-- ============================================================
-- SQL block 7 (source raw block 8, paragraphs 255-282, statements 2)
-- ============================================================
SELECT
    o.order_id,
    u.username,
    o.total_amount,
    o.status,
    o.order_date
FROM
    orders o
JOIN  users u ON o.user_id = u.user_id
WHERE o.total_amount > (;

    SELECT AVG(total_amount)
    FROM orders
    )
ORDER BY o.total_amount DESC;

-- ============================================================
-- SQL block 8 (source raw block 9, paragraphs 294-341, statements 3)
-- Context: •【答题人1 SQL语句】：
-- ============================================================
-- A4 更新前：查询将会被下架的商品
SELECT
    product_id,
    product_name,
    category,
    stock,
    status
FROM products
WHERE stock <= 45
  AND status = 'A';

-- A4 执行更新：库存小于等于45且仍上架的商品批量下架
UPDATE products
SET status = 'I'
WHERE stock <= 45
  AND status = 'A';

-- A4 更新后：检查库存小于等于45的所有商品
SELECT
    product_id,
    product_name,
    category,
    stock,
    status
FROM products
WHERE stock <= 45;

-- ============================================================
-- SQL block 9 (source raw block 10, paragraphs 347-390, statements 3)
-- Context: •【答题人2 SQL语句】：
-- ============================================================
--更新前查询会被影响的商品
SELECT
    product_id,
    product_name,
    stock,
    status
FROM products
WHERE stock <= 45
AND status = 'A';

--执行更新
UPDATE products
SET status = 'I'
WHERE stock <= 45
AND status = 'A';

--检查更新结果
SELECT
    product_id,
    product_name,
    stock,
    status
FROM products
WHERE stock <= 45;

-- ============================================================
-- SQL block 10 (source raw block 11, paragraphs 410-439, statements 1)
-- Context: •【答题人1 SQL语句】：
-- ============================================================
SELECT
    u.user_id,
    u.username,
    u.vip_level,
    COUNT(o.order_id) AS valid_order_count,
    SUM(o.total_amount) AS valid_total_amount,
    MIN(o.order_date) AS first_valid_order_time
FROM users u
INNER JOIN orders o ON u.user_id = o.user_id
WHERE o.status IN ('已完成', '已支付', '已发货')
  AND o.order_date >= '2024-11-01'
  AND o.order_date < '2024-12-01'
GROUP BY u.user_id, u.username, u.vip_level
ORDER BY valid_total_amount DESC
LIMIT 5;

-- ============================================================
-- SQL block 11 (source raw block 14, paragraphs 453-486, statements 1)
-- Context: •【答题人2 SQL语句】：
-- ============================================================
SELECT
    u.user_id,
    u.username,
    u.vip_level,
    COUNT(o.order_id) AS efficient_order_count,
    SUM(o.total_amount) AS total_spent,
    MIN (o.order_date) AS first_order_date
FROM
    users u
    JOIN orders o ON u.user_id = o.user_id
WHERE o.status IN ('已完成', '已支付','已发货');

-- ============================================================
-- SQL block 12 (source raw block 15, paragraphs 497-520, statements 1)
-- ============================================================
SELECT
    o.order_id,
    u.username,
    p.product_name,
    oi.quantity,
    oi.unit_price
FROM orders o
INNER JOIN users u ON o.user_id = u.user_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id
WHERE o.status = '已完成'
ORDER BY o.order_id ASC, oi.item_id ASC;

-- ============================================================
-- SQL block 13 (source raw block 16, paragraphs 524-553, statements 1)
-- Context: •【答题人2 SQL语句】：
-- ============================================================
SELECT
    o.order_id AS order_id,
    u.username AS username,
    p.product_name AS product_name,
    oi.quantity AS quantity,
    oi.unit_price AS unit_price
FROM orders o
JOIN users u
    ON o.user_id = u.user_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
WHERE o.status = '已完成'
ORDER BY o.order_id, oi.item_id;

-- ============================================================
-- SQL block 14 (source raw block 17, paragraphs 561-578, statements 1)
-- ============================================================
SELECT
    u.user_id,
    u.username,
    SUM(o.total_amount) AS history_total_amount
FROM users u
INNER JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.username
HAVING SUM(o.total_amount) > 1000
ORDER BY history_total_amount DESC;

-- ============================================================
-- SQL block 15 (source raw block 18, paragraphs 581-600, statements 1)
-- Context: •【答题人2 SQL语句】：
-- ============================================================
SELECT
    u.user_id,
    u.username,
    SUM(o.total_amount) AS total_order_amount
FROM users u
JOIN orders o
    ON u.user_id = o.user_id
GROUP BY u.user_id, u.username
HAVING SUM(o.total_amount) > 1000
ORDER BY total_order_amount DESC;

-- ============================================================
-- SQL block 16 (source raw block 19, paragraphs 608-637, statements 4)
-- ============================================================
SELECT DISTINCT u.username,u.email
FROM users u
WHERE u.user_id IN (;

    SELECT o.user_id
    FROM orders o
    WHERE o.order_id IN (;

        SELECT oi.order_id
        FROM order_items oi
        WHERE oi.product_id IN (;

            SELECT p.product_id
            FROM products p
            WHERE p.category = '数码'
        )
    )
);

-- ============================================================
-- SQL block 17 (source raw block 20, paragraphs 641-662, statements 1)
-- ============================================================
SELECT DISTINCT
    u.username,
    u.email
FROM users u
JOIN orders o
    ON u.user_id = o.user_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
WHERE p.category = '数码';

-- ============================================================
-- SQL block 18 (source raw block 21, paragraphs 669-680, statements 2)
-- ============================================================
UPDATE products
SET status = 'I'
WHERE stock < 50;

UPDATE products
SET status = 'A'
WHERE stock >= 50;

-- ============================================================
-- SQL block 19 (source raw block 22, paragraphs 684-693, statements 1)
-- ============================================================
UPDATE products
SET status = CASE
    WHEN stock < 50 THEN 'I'
    ELSE 'A'
END;

-- ============================================================
-- SQL block 20 (source raw block 23, paragraphs 700-747, statements 8)
-- ============================================================
-- B5 创建2024年11月商品销售视图
DROP VIEW IF EXISTS sales_nov_2024;

CREATE VIEW sales_nov_2024 AS;

SELECT
    p.category,
    p.product_name,
    oi.quantity AS sales_quantity,
    oi.unit_price AS sales_unit_price
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id
WHERE o.order_date >= '2024-11-01'
  AND o.order_date < '2024-12-01'
  AND o.status IN ('已完成', '已支付', '已发货');

-- B5 基于视图查询每类商品销售总数量前三名
SELECT
    category,
    SUM(sales_quantity) AS total_sales_quantity
FROM sales_nov_2024
GROUP BY category
ORDER BY total_sales_quantity DESC
LIMIT 3;

-- B5 创建2024年11月商品销售视图
DROP VIEW IF EXISTS sales_nov_2024;

CREATE VIEW sales_nov_2024 AS;

SELECT
    p.category,
    p.product_name,
    oi.quantity AS sales_quantity,
    oi.unit_price AS sales_unit_price
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id
WHERE o.order_date >= '2024-11-01'
  AND o.order_date < '2024-12-01'
  AND o.status IN ('已完成', '已支付', '已发货');

-- B5 基于视图查询每类商品销售总数量前三名
SELECT
    category,
    SUM(sales_quantity) AS total_sales_quantity
FROM sales_nov_2024
GROUP BY category
ORDER BY total_sales_quantity DESC
LIMIT 3;

-- ============================================================
-- SQL block 21 (source raw block 24, paragraphs 751-776, statements 2)
-- ============================================================
CREATE OR REPLACE VIEW sales_nov_2024 AS;

SELECT
    p.category AS category,
    p.product_name AS product_name,
    oi.quantity AS sales_quantity,
    oi.unit_price AS sales_unit_price
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
WHERE o.order_date >= '2024-11-01'
  AND o.order_date < '2024-12-01';

-- ============================================================
-- SQL block 22 (source raw block 25, paragraphs 779-793, statements 2)
-- ============================================================
SELECT
    category,
    SUM(sales_quantity) AS total_sales_quantity
FROM sales_nov_2024
GROUP BY category
ORDER BY total_sales_quantity DESC
LIMIT 3;

SELECT
    category,
    SUM(sales_quantity) AS total_sales_quantity
FROM sales_nov_2024
GROUP BY category
ORDER BY total_sales_quantity DESC
LIMIT 3;

-- ============================================================
-- SQL block 23 (source raw block 26, paragraphs 802-817, statements 1)
-- ============================================================
SELECT
    u.user_id,
    u.username,
    COALESCE(SUM(o.total_amount), 0) AS total_order_amount
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.username
ORDER BY u.user_id;

-- ============================================================
-- SQL block 24 (source raw block 27, paragraphs 820-835, statements 1)
-- ============================================================
SELECT
    u.user_id,
    u.username,
    COALESCE(SUM(o.total_amount), 0) AS total_order_amount
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.username
ORDER BY u.user_id;

-- ============================================================
-- SQL block 25 (source raw block 28, paragraphs 839-856, statements 1)
-- ============================================================
SELECT
    u.user_id,
    u.username,
    COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM
    users u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.username
ORDER BY total_spent DESC;

-- ============================================================
-- SQL block 26 (source raw block 29, paragraphs 862-875, statements 1)
-- ============================================================
SELECT
    p.category,
    COUNT(DISTINCT p.product_id) AS purchased_product_count
FROM products p
INNER JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category
HAVING COUNT(DISTINCT p.product_id) > 2;

-- ============================================================
-- SQL block 27 (source raw block 30, paragraphs 878-893, statements 1)
-- ============================================================
SELECT
    p.category,
    COUNT(DISTINCT p.product_id) AS purchased_product_count
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.category
HAVING COUNT(DISTINCT p.product_id) > 2;

-- ============================================================
-- SQL block 28 (source raw block 31, paragraphs 897-912, statements 1)
-- ============================================================
SELECT
    p.category,
    COUNT(DISTINCT p.product_id) AS purchased_product_count
FROM
    products p
    JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category
HAVING COUNT(DISTINCT p.product_id) > 2;

-- ============================================================
-- SQL block 29 (source raw block 32, paragraphs 918-943, statements 3)
-- Context: 点评：结果正确。SQL 结构清晰，能够按商品分类统计被购买过的不同商品数量，并正确使用 HAVING COUNT(DISTINCT p.product_id) > 2 进行分组后筛选，符合题目要求。
-- ============================================================
SELECT DISTINCT
    o.user_id
FROM orders o
WHERE o.order_id IN (;

    SELECT oi.order_id
    FROM order_items oi
    WHERE oi.product_id IN (;

        SELECT p.product_id
        FROM products p
        WHERE p.price > 500
    )
)
ORDER BY o.user_id;

-- ============================================================
-- SQL block 30 (source raw block 33, paragraphs 946-965, statements 1)
-- ============================================================
SELECT DISTINCT
    u.user_id
FROM users u
JOIN orders o
    ON u.user_id = o.user_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
WHERE p.price > 500;

-- ============================================================
-- SQL block 31 (source raw block 34, paragraphs 968-983, statements 2)
-- ============================================================
SELECT DISTINCT user_id
FROM orders o
WHERE o.order_id IN (;

    SELECT order_id
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    WHERE p.price > 500
);

-- ============================================================
-- SQL block 32 (source raw block 36, paragraphs 990-997, statements 1)
-- ============================================================
UPDATE products
SET price = price * 0.8
WHERE stock < 50
  AND stock >0;

-- ============================================================
-- SQL block 33 (source raw block 37, paragraphs 1001-1008, statements 1)
-- ============================================================
UPDATE products
SET price = price * 0.8
WHERE stock < 50
AND stock > 0;

-- ============================================================
-- SQL block 34 (source raw block 38, paragraphs 1015-1040, statements 1)
-- ============================================================
SELECT
    o.order_id,
    u.username,
    o.order_date,
    o.total_amount
FROM orders o
JOIN users u
    ON o.user_id = u.user_id
WHERE o.order_date >= '2024-11-01'
  AND o.order_date < '2024-12-01'
ORDER BY o.total_amount DESC
OFFSET 5
LIMIT 5;

-- ============================================================
-- SQL block 35 (source raw block 39, paragraphs 1043-1066, statements 1)
-- ============================================================
SELECT
    o.order_id,
    u.username,
    o.order_date,
    o.total_amount
FROM
    orders o
JOIN  users u ON o.user_id = u.user_id
WHERE o.order_date >= '2024-11-01 00:00:00'
AND o.order_date < '2024-12-01 00:00:00'
ORDER BY o.total_amount DESC
LIMIT 5 OFFSET 5;
