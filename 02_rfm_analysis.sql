-- 1. Obliczanie bazowych wartości R, F, M dla każdego klienta
WITH raw_rfm AS (
    SELECT 
        customer_id,
        -- Recency: dni od ostatniego zakupu do 'dzisiaj' (tu: symulowana data 2024-01-01)
        DATE_PART('day', '2024-01-01'::timestamp - MAX(order_date)) AS recency,
        -- Frequency: łączna liczba zamówień
        COUNT(order_id) AS frequency,
        -- Monetary: łączna wartość wydanych pieniędzy
        SUM(total_price) AS monetary
    FROM orders
    GROUP BY customer_id
),

-- 2. Przypisywanie punktacji (1-5) przy użyciu kwantyli (funkcja NTILE)
rfm_scores AS (
    SELECT 
        *,
        -- Dla Recency: im mniejsza liczba dni, tym lepszy wynik (5)
        NTILE(5) OVER (ORDER BY recency DESC) AS r_score,
        -- Dla Frequency i Monetary: im wyższa wartość, tym lepszy wynik (5)
        NTILE(5) OVER (ORDER BY frequency ASC) AS f_score,
        NTILE(5) OVER (ORDER BY monetary ASC) AS m_score
    FROM raw_rfm
),

-- 3. Definiowanie segmentów na podstawie uzyskanych wyników
final_segmentation AS (
    SELECT 
        customer_id,
        recency, frequency, monetary,
        r_score, f_score, m_score,
        CASE 
            WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champions'
            WHEN r_score >= 3 AND f_score >= 3 THEN 'Loyal Customers'
            WHEN r_score >= 4 AND f_score = 1 THEN 'New Customers'
            WHEN r_score = 1 THEN 'At Risk / Lost'
            ELSE 'Potential Loyalists'
        END AS customer_segment
    FROM rfm_scores
)

-- 4. Końcowy raport: statystyki dla każdego segmentu
SELECT 
    customer_segment,
    COUNT(customer_id) AS customer_count,
    ROUND(AVG(monetary)::numeric, 2) AS avg_revenue_per_segment,
    ROUND(AVG(recency)::numeric, 0) AS avg_days_since_last_order
FROM final_segmentation
GROUP BY customer_segment
ORDER BY avg_revenue_per_segment DESC;
