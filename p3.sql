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
INNER JOIN
    orders o ON od.order_id = o.id
INNER JOIN
    customers c ON o.customer_id = c.id
INNER JOIN
    products p ON od.product_id = p.id
INNER JOIN
    categories cat ON p.category_id = cat.id
INNER JOIN
    employees e ON o.employee_id = e.employee_id
INNER JOIN
    shippers s ON o.shipper_id = s.id
INNER JOIN
    suppliers sup ON p.supplier_id = sup.id;