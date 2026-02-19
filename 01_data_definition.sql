-- 1. Czyścimy i tworzymy tabelę
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP,
    total_price DECIMAL(10, 2)
);

-- 2. Generator 1000 losowych rekordów
INSERT INTO orders (customer_id, order_date, total_price)
SELECT 
    -- Losowy klient od 1 do 100
    floor(random() * 100 + 1)::int as customer_id,
    -- Losowa data z ostatnich 365 dni
    NOW() - (random() * interval '365 days') as order_date,
    -- Losowa kwota od 10.00 do 1000.00, zaokrąglona do 2 miejsc
    round((random() * 990 + 10)::numeric, 2) as total_price
FROM generate_series(1, 1000);

-- 3. Opcjonalnie: Sprawdzenie ile wierszy wpadło
SELECT COUNT(*) as total_rows, COUNT(DISTINCT customer_id) as unique_customers 
FROM orders;
