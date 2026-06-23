1
2-- Write a solution to report the products that were only sold in the first quarter of 2019. That is, between 2019-01-01 and 2019-03-31 inclusive.
3
4-- Return the result table in any order.
5
6-- The result format is in the following example.
7
8 
9
10-- Example 1:
11
12-- Input: 
13-- Product table:
14-- +------------+--------------+------------+
15-- | product_id | product_name | unit_price |
16-- +------------+--------------+------------+
17-- | 1          | S8           | 1000       |
18-- | 2          | G4           | 800        |
19-- | 3          | iPhone       | 1400       |
20-- +------------+--------------+------------+
21-- Sales table:
22-- +-----------+------------+----------+------------+----------+-------+
23-- | seller_id | product_id | buyer_id | sale_date  | quantity | price |
24-- +-----------+------------+----------+------------+----------+-------+
25-- | 1         | 1          | 1        | 2019-01-21 | 2        | 2000  |
26-- | 1         | 2          | 2        | 2019-02-17 | 1        | 800   |
27-- | 2         | 2          | 3        | 2019-06-02 | 1        | 800   |
28-- | 3         | 3          | 4        | 2019-05-13 | 2        | 2800  |
29-- +-----------+------------+----------+------------+----------+-------+
30-- Output: 
31-- +-------------+--------------+
32-- | product_id  | product_name |
33-- +-------------+--------------+
34-- | 1           | S8           |
35-- +-------------+--------------+
36-- Explanation: 
37-- The product with id 1 was only sold in the spring of 2019.
38-- The product with id 2 was sold in the spring of 2019 but was also sold after the spring of 2019.
39-- The product with id 3 was sold after spring 2019.
40-- We return only product 1 as it is the product that was only sold in the spring of 2019.
41
42
43
44-- The question asked ONLY --------ONLY -- so subquery to eliminate the only part 
45select product_id, product_name 
46from Product 
47where product_id not in(
48    select p.product_id
49    from Product p
50    left join Sales s
51    on p.product_id=s.product_id
52    where sale_date<'2019-01-01'
53    or sale_date>'2019-03-31'
54    or s.quantity is null
55)