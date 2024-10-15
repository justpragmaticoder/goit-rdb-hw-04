### 1. Визначте, скільки рядків ви отримали (за допомогою оператора COUNT) START ###

SELECT COUNT(*) AS total_rows
    FROM order_details od
        INNER JOIN orders o ON od.order_id = o.id
        INNER JOIN customers c ON o.customer_id = c.id
        INNER JOIN products p ON od.product_id = p.id
        INNER JOIN categories cat ON p.category_id = cat.id
        INNER JOIN employees e ON o.employee_id = e.employee_id
        INNER JOIN shippers s ON o.shipper_id = s.id
        INNER JOIN suppliers sup ON p.supplier_id = sup.id;

### END ###

### 2. Змініть декілька операторів INNER на LEFT чи RIGHT. Визначте, що відбувається з кількістю рядків. Чому? Напишіть відповідь у текстовому файлі. START ###

SELECT
    od.id AS order_detail_id,
    o.id AS order_id,
    c.name AS customer_name,
    p.name AS product_name,
    cat.name AS category_name,
    e.last_name AS employee_last_name,
    s.name AS shipper_name,
    sup.name AS supplier_name,
    od.quantity,
    p.price
    FROM order_details od
        LEFT JOIN orders o ON od.order_id = o.id
        LEFT JOIN customers c ON o.customer_id = c.id
        LEFT JOIN products p ON od.product_id = p.id
        LEFT JOIN categories cat ON p.category_id = cat.id
        LEFT JOIN employees e ON o.employee_id = e.employee_id
        LEFT JOIN shippers s ON o.shipper_id = s.id
        LEFT JOIN suppliers sup ON p.supplier_id = sup.id;

### END ###

### 3. Оберіть тільки ті рядки, де employee_id > 3 та ≤ 10. START ###

SELECT
    od.id AS order_detail_id,
    o.id AS order_id,
    c.name AS customer_name,
    p.name AS product_name,
    cat.name AS category_name,
    e.last_name AS employee_last_name,
    s.name AS shipper_name,
    sup.name AS supplier_name,
    od.quantity,
    p.price
FROM
    order_details od
    INNER JOIN orders o ON od.order_id = o.id
    INNER JOIN customers c ON o.customer_id = c.id
    INNER JOIN products p ON od.product_id = p.id
    INNER JOIN categories cat ON p.category_id = cat.id
    INNER JOIN employees e ON o.employee_id = e.employee_id
    INNER JOIN shippers s ON o.shipper_id = s.id
    INNER JOIN suppliers sup ON p.supplier_id = sup.id
WHERE
    e.employee_id > 3 AND e.employee_id <= 10;

### END ###

### 4. Згрупуйте за іменем категорії, порахуйте кількість рядків у групі, середню кількість товару (кількість товару знаходиться в order_details.quantity) START ###

SELECT
    cat.name AS category_name,
    COUNT(od.id) AS total_orders,
    AVG(od.quantity) AS average_quantity
FROM
    order_details od
    INNER JOIN orders o ON od.order_id = o.id
    INNER JOIN customers c ON o.customer_id = c.id
    INNER JOIN products p ON od.product_id = p.id
    INNER JOIN categories cat ON p.category_id = cat.id
    INNER JOIN employees e ON o.employee_id = e.employee_id
    INNER JOIN shippers s ON o.shipper_id = s.id
    INNER JOIN suppliers sup ON p.supplier_id = sup.id
GROUP BY
    cat.name;

### END ###

### 5. Відфільтруйте рядки, де середня кількість товару більша за 21. START ###

SELECT *
FROM (
    SELECT
        od.id AS order_detail_id,
        o.id AS order_id,
        c.name AS customer_name,
        p.name AS product_name,
        cat.name AS category_name,
        e.last_name AS employee_last_name,
        s.name AS shipper_name,
        sup.name AS supplier_name,
        od.quantity,
        p.price,
        AVG(od.quantity) OVER (PARTITION BY cat.name) AS avg_quantity
    FROM order_details od
        INNER JOIN orders o ON od.order_id = o.id
        INNER JOIN customers c ON o.customer_id = c.id
        INNER JOIN products p ON od.product_id = p.id
        INNER JOIN categories cat ON p.category_id = cat.id
        INNER JOIN employees e ON o.employee_id = e.employee_id
        INNER JOIN shippers s ON o.shipper_id = s.id
        INNER JOIN suppliers sup ON p.supplier_id = sup.id
) AS subquery
WHERE avg_quantity > 21;

### END ###

### 6. Відсортуйте рядки за спаданням кількості рядків. START ###

SELECT
    cat.name AS category_name,
    COUNT(od.id) AS total_orders,
    AVG(od.quantity) AS avg_quantity
    FROM order_details od
        INNER JOIN orders o ON od.order_id = o.id
        INNER JOIN customers c ON o.customer_id = c.id
        INNER JOIN products p ON od.product_id = p.id
        INNER JOIN categories cat ON p.category_id = cat.id
        INNER JOIN employees e ON o.employee_id = e.employee_id
        INNER JOIN shippers s ON o.shipper_id = s.id
        INNER JOIN suppliers sup ON p.supplier_id = sup.id
            GROUP BY
                cat.name
            ORDER BY
                total_orders DESC;

### END ###

### 7. Виведіть на екран (оберіть) чотири рядки з пропущеним першим рядком. START ###

SELECT *
FROM (
    SELECT
        od.id AS order_detail_id,
        o.id AS order_id,
        c.name AS customer_name,
        p.name AS product_name,
        cat.name AS category_name,
        e.last_name AS employee_last_name,
        s.name AS shipper_name,
        sup.name AS supplier_name,
        od.quantity,
        p.price
    FROM order_details od
        INNER JOIN orders o ON od.order_id = o.id
        INNER JOIN customers c ON o.customer_id = c.id
        INNER JOIN products p ON od.product_id = p.id
        INNER JOIN categories cat ON p.category_id = cat.id
        INNER JOIN employees e ON o.employee_id = e.employee_id
        INNER JOIN shippers s ON o.shipper_id = s.id
        INNER JOIN suppliers sup ON p.supplier_id = sup.id
) AS result
LIMIT 4 OFFSET 1;

### END ###