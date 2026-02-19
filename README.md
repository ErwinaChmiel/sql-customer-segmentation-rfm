# Analiza Segmentacji Klientów (Model RFM) w SQL

## 📌 O projekcie
Ten projekt przedstawia zaawansowaną analizę bazy danych zamówień przy użyciu modelu **RFM** (Recency, Frequency, Monetary). Celem jest posegmentowanie klientów na grupy (np. Czempioni, Klienci Nielojalni, Nowi Klienci), co pozwala na optymalizację działań marketingowych i zwiększenie retencji.

## 🛠️ Wykorzystane technologie
*   **Język:** SQL (PostgreSQL / Standard SQL)
*   **Techniki:** Common Table Expressions (CTE), Funkcje Okna (NTILE, RANK), Agregacje, Funkcje generowania danych (`generate_series`).

## 📊 Struktura projektu
1. `01_data_definition.sql`: Automatyczny generator danych (1000 rekordów dla 100 klientów), symulujący realne transakcje e-commerce z ostatniego roku.
2. `02_rfm_analysis.sql`: Główny skrypt obliczający punkty RFM i przypisujący segmenty biznesowe.

## 🚀 Jak uruchomić projekt?
1. Skopiuj zawartość pliku `01_data_definition.sql` i uruchom w swoim środowisku SQL (np. pgAdmin, DBeaver lub [DB-Fiddle](https://www.db-fiddle.com)).
2. Uruchom skrypt `02_rfm_analysis.sql`, aby wygenerować raport segmentacji.

## 📈 Przykładowe wnioski biznesowe
Dzięki zastosowaniu funkcji `NTILE(5)`, baza została podzielona na grupy, co pozwala na:
*   **Targetowanie "Czempionów":** Nagradzanie ich programami lojalnościowymi.
*   **Kampanie Reaktywacyjne:** Identyfikacja segmentu "At Risk" (klientów, którzy nie kupowali od dawna).
*   **Personalizację ofert:** Dopasowanie komunikacji do wartości koszyka (Monetary).
