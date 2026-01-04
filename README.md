# Retail Sales SQL Analytics Project

## Описание проекта
Данный проект представляет собой аналитическое исследование данных о продажах в розничной торговле с использованием SQL.  
Цель проекта — продемонстрировать навыки работы с реляционными базами данных, включая очистку данных, исследовательский анализ, агрегации и решение типовых бизнес-задач.

В рамках проекта анализируются данные по транзакциям, покупателям, категориям товаров, времени продаж и другим ключевым метрикам.

## Источник данных
Таблица `retail_sales` содержит следующие колонки:
- `transactions_id` – уникальный идентификатор транзакции  
- `sale_date` – дата продажи  
- `sale_time` – время продажи  
- `customer_id` – идентификатор покупателя  
- `gender` – пол покупателя  
- `age` – возраст покупателя  
- `category` – категория товара  
- `quantity` – количество проданных единиц  
- `price_per_unit` – цена за единицу  
- `cogs` – себестоимость товара  
- `total_sale` – общая стоимость продажи  

## Этапы проекта

### 1. Первичный осмотр данных
- Просмотр всех данных: `SELECT * FROM retail_sales;`
- Подсчет общего числа записей: `SELECT COUNT(*) FROM retail_sales;`

### 2. Очистка данных
- Поиск пустых значений во всех колонках
- Удаление строк с пропущенными данными:
```sql
DELETE FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```
###  3. Исследовательский анализ (EDA)
#### Общее количество продаж:
```sql
SELECT COUNT(*) AS total_sales FROM retail_sales;
```
#### Количество уникальных клиентов:
```sql
SELECT COUNT(DISTINCT customer_id) AS total_customer FROM retail_sales;
```
#### Список уникальных категорий товаров:
```sql
SELECT DISTINCT category FROM retail_sales;
```
### 4. SQL-аналитика и бизнес-задачи
#### 1. Продажи в конкретную дату:
```sql
SELECT * FROM retail_sales WHERE sale_date='2022-11-05';
```
#### 2. Транзакции одежды с количеством >10 за ноябрь 2022:
```sql
SELECT * 
FROM retail_sales
WHERE category='Clothing'
  AND TO_CHAR(sale_date,'YYYY-MM')='2022-11'
  AND quantity>10;
```
#### 3. Суммарные продажи по категориям:
```sql
SELECT category, SUM(total_sale) AS tot_sale, COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
```
#### 4. Средний возраст покупателей категории Beauty:
```sql
SELECT ROUND(AVG(age),2) AS avg_age
FROM retail_sales
WHERE category='Beauty';
```
#### 5. Продажи выше 1000:
```sql
SELECT * FROM retail_sales WHERE total_sale>1000;
```
#### 6. Количество транзакций по полу и категории:
```sql
SELECT category, gender, COUNT(*) AS total_count
FROM retail_sales
GROUP BY category, gender
ORDER BY category;
```
#### 7. Средняя продажа по месяцам и лучший месяц в году:
```sql
SELECT EXTRACT(YEAR FROM sale_date) AS year,
       EXTRACT(MONTH FROM sale_date) AS month,
       AVG(total_sale) AS avg_sale
FROM retail_sales
GROUP BY year, month
ORDER BY year, month DESC;
```
#### 8. Топ-5 клиентов по сумме продаж:
```sql
SELECT customer_id, SUM(total_sale) AS sum_total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY sum_total_sales DESC
LIMIT 5;
```
#### 9. Количество уникальных покупателей по категориям:
```sql
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;
```
#### 10. Распределение транзакций по сменам:
```sql
SELECT CASE 
         WHEN EXTRACT(HOUR FROM sale_time)<=12 THEN 'Morning'
         WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
         ELSE 'Evening'
       END AS shift,
       COUNT(*) AS transaction_number
FROM retail_sales
GROUP BY shift
ORDER BY transaction_number DESC;

```

### Выводы

-`Были очищены данные от пропусков, что позволило получить точные результаты анализа.`

-`Проанализированы продажи по категориям, клиентам, времени и полу покупателей.`

-`Выявлены топ-клиенты и категории с наибольшей выручкой.`

-`Определены наиболее активные смены для оптимизации работы магазина.`


### Навыки, продемонстрированные в проекте

-`SQL: SELECT, WHERE, GROUP BY, HAVING, JOIN, агрегатные функции (SUM, AVG, COUNT, DISTINCT)`

-`Работа с датами и временем`

-`Очистка данных`

-`Анализ бизнес-задач`

