-- Creazione del Database (se necessario)
CREATE DATABASE IF NOT EXISTS ToysGroup;
USE ToysGroup;

-- Creazione delle tabelle
CREATE TABLE ProductCategory (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL
);

CREATE TABLE Product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    category_id INT,
    unit_price DECIMAL(10 , 2 ) NOT NULL,
    FOREIGN KEY (category_id)
        REFERENCES ProductCategory (category_id)
);

CREATE TABLE Region (
    region_id INT AUTO_INCREMENT PRIMARY KEY,
    region_name VARCHAR(255) NOT NULL
);

CREATE TABLE State (
    state_id INT AUTO_INCREMENT PRIMARY KEY,
    state_name VARCHAR(255) NOT NULL,
    region_id INT,
    FOREIGN KEY (region_id)
        REFERENCES Region (region_id)
);

CREATE TABLE Sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    state_id INT,
    sale_date DATE,
    quantity INT,
    sale_amount DECIMAL(10 , 2 ) NOT NULL,
    FOREIGN KEY (product_id)
        REFERENCES Product (product_id),
    FOREIGN KEY (state_id)
        REFERENCES State (state_id)
);

-- Popolamento delle tabelle
INSERT INTO ProductCategory (category_name) VALUES 
('Giocattoli educativi'), 
('Giochi da tavolo'), 
('Peluche'), 
('Giocattoli elettronici'), 
('Costruzioni');

INSERT INTO Product (product_name, category_id, unit_price) VALUES 
('Cubo di Rubik', 1, 20.00), 
('Monopoly', 2, 30.00), 
('Orsacchiotto', 3, 15.00), 
('Drone giocattolo', 4, 60.00), 
('LEGO City', 5, 55.00),
('Puzzle 3D', 1, 25.00), 
('Scacchi', 2, 22.50), 
('Peluche Tigre', 3, 18.00), 
('Macchina telecomandata', 4, 45.00), 
('LEGO Technic', 5, 80.00),
('Puzzle avanzato', 1, 25.00),
('Gioco di magia', 2, 22.50),
('Dinosauro peluche', 3, 18.00),
('Kit di esperimenti scientifici', 1, 30.00),
('Casa delle bambole', 5, 45.00);

INSERT INTO Region (region_name) VALUES 
('Europa'), 
('America del Nord'), 
('Asia'), 
('Sud America'), 
('Africa');

INSERT INTO State (state_name, region_id) VALUES 
('Italia', 1), 
('Germania', 1), 
('Stati Uniti', 2), 
('Canada', 2), 
('Cina', 3), 
('Giappone', 3), 
('Brasile', 4), 
('Argentina', 4), 
('Kenya', 5), 
('Sudafrica', 5);

-- Inserimento delle vendite, includendo anni diversi e alcuni prodotti invenduti
INSERT INTO Sales (product_id, state_id, sale_date, quantity, sale_amount) VALUES 
(1, 1, '2022-03-15', 8, 160.00),
(3, 4, '2022-05-22', 15, 270.00),
(5, 2, '2022-07-30', 5, 275.00),
(2, 3, '2022-09-11', 12, 360.00),
(4, 5, '2022-11-28', 7, 420.00),
(6, 6, '2023-02-14', 10, 250.00),
(8, 8, '2023-04-18', 3, 54.00),
(10, 10, '2023-06-21', 20, 1600.00),
(7, 7, '2023-08-15', 6, 135.00),
(9, 9, '2023-10-05', 11, 198.00),
(2, 1, '2024-01-20', 14, 420.00),
(4, 3, '2024-03-12', 9, 405.00),
(6, 5, '2024-05-19', 13, 325.00),
(8, 7, '2024-07-22', 8, 144.00),
(10, 9, '2024-09-15', 5, 400.00);

-- Verificare che i campi definiti come PK siano univoci --

SELECT 
    product_id, COUNT(*) AS count
FROM
    Product
GROUP BY product_id
HAVING count > 1;

SELECT 
    category_id, COUNT(*) AS count
FROM
    Productcategory
GROUP BY category_id
HAVING count > 1;

SELECT 
    region_id, COUNT(*) AS count
FROM
    region
GROUP BY region_id
HAVING count > 1;

SELECT 
    product_id, COUNT(*) AS count
FROM
    Product
GROUP BY product_id
HAVING count > 1;

SELECT 
    product_id, COUNT(*) AS count
FROM
    Product
GROUP BY product_id
HAVING count > 1;

-- Elenco Prodotti Venduti e Fatturato Totale per Anno --

SELECT 
    p.product_name,
    YEAR(s.sale_date) AS year,
    SUM(p.unit_price * s.quantity) AS total_revenue
FROM
    Sales s
        JOIN
    Product p USING (product_id)
GROUP BY P.product_name , YEAR(S.sale_date);

-- Fatturato Totale per Stato per Anno --

SELECT st.state_name, YEAR(s.sale_date) AS year, SUM(p.unit_price * s.quantity) AS total_revenue
FROM Sales s
JOIN State st USING(state_id)
JOIN Product p USING(product_id)
GROUP BY st.state_name, YEAR(s.sale_date)
ORDER BY YEAR(s.sale_date), total_revenue DESC;

-- Categoria di Articoli Maggiormente Richiesta --

SELECT pc.category_name, SUM(S.quantity) AS total_quantity
FROM Sales s
JOIN Product p USING(product_id)
JOIN ProductCategory pc USING(category_id)
GROUP BY pc.category_name
ORDER BY total_quantity DESC
LIMIT 1;

-- Prodotti Invenduti --

SELECT p.product_name
FROM Product p
WHERE p.product_id NOT IN (SELECT s.product_id FROM Sales s);

SELECT p.product_name
FROM product p 
LEFT JOIN sales s USING(product_id)
WHERE s.sale_id IS NULL;

-- Elenco Prodotti con Ultima Data di Vendita --

SELECT p.product_name, MAX(s.sale_date) AS last_sale_date
FROM Sales s
JOIN Product p ON S.product_id = p.product_id
GROUP BY p.product_name;

-- BONUS --

SELECT
    s.sale_id AS 'Codice Documento',
    s.sale_date AS 'Data',
    p.product_name AS 'Nome Prodotto',
    pc.category_name AS 'Categoria Prodotto',
    st.state_name AS 'Nome Stato',
    r.region_name AS 'Nome Regione',
    CASE 
        WHEN DATEDIFF(CURDATE(), s.sale_date) > 180 THEN 'TRUE'
        ELSE 'FALSE'
    END AS 'Oltre 180 Giorni'
FROM
    Sales s
JOIN
    Product p USING(product_id)
JOIN
    ProductCategory pc USING(category_id)
JOIN
    State st USING(state_id)
JOIN
    Region r USING(region_id)

