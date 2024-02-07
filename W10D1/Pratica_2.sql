"Scelgo Database"
USE pratica2;

"Creo tabella"
CREATE TABLE Prodotti (Id_Prodotto INTEGER PRIMARY KEY,
NomeProdotto VARCHAR(100),
Prezzo DECIMAL(10,2));

SELECT * FROM Prodotti;
"DROP TABLE Prodotti;"

"Creo tabella"
CREATE TABLE Clienti (Id_Cliente INTEGER PRIMARY KEY,
Nome VARCHAR(50),
Email VARCHAR(100));

SELECT * FROM Clienti;
"DROP TABLE Clienti;"

"Creo tabella"
CREATE TABLE Ordini (
Id_Ordine INTEGER PRIMARY KEY,
Id_Prodotto INTEGER,
Id_Cliente INTEGER,
Quantità INTEGER,
FOREIGN KEY (Id_Prodotto) REFERENCES Prodotti(Id_Prodotto),
FOREIGN KEY (Id_Cliente) REFERENCES Clienti(Id_Cliente));

SELECT * FROM Ordini;
"DROP TABLE Ordini;"

"Creo tabella"
CREATE TABLE DettaglioOrdini (
Id_Ordine INTEGER,
Id_Prodotto INTEGER,
Id_Cliente INTEGER,
Prezzo_Totale DECIMAL(10,2),
PRIMARY KEY (Id_Ordine, Id_Prodotto, Id_Cliente),
FOREIGN KEY (Id_Ordine) REFERENCES Ordini(Id_Ordine),
FOREIGN KEY (Id_Prodotto) REFERENCES Prodotti(Id_Prodotto),
FOREIGN KEY (Id_Cliente) REFERENCES Clienti(Id_Cliente)
);

SELECT * FROM DettaglioOrdini;
"DROP TABLE DettaglioOrdini;"

"Popolo tabella Prodotti"
INSERT INTO Prodotti VALUES
(1, 'Tablet', 300.00),
(2, 'Mouse', 20.00),
(3, 'Tastiera', 25.00),
(4, 'Monitor', 180.00),
(5, 'HHD', 90.00),
(6, 'SSD', 200.00),
(7, 'RAM', 100.00),
(8, 'Router', 80.00),
(9, 'Webcam', 45.00),
(10, 'GPU', 1250.00),
(11, 'Trackpad', 500.00),
(12, 'Techmagazine', 5.00),
(13, 'Martech', 50.00);

"Popolo tabella Clienti"
INSERT INTO Clienti (Id_Cliente, Nome, Email) VALUES
(1, 'Antonio', NULL),
(2, 'Battista', 'battista@mailmail.it'),
(3, 'Maria', 'maria@posta.it'),
(4, 'Franca', 'franca@lettere.it'),
(5, 'Ettore', NULL),
(6, 'Arianna', 'arianna@posta.it'),
(7, 'Piero', 'piero@lavoro.it');

"Popolo tabella ordini"
INSERT INTO Ordini (Id_Ordine, Id_Prodotto, Id_Cliente, Quantità) VALUES
(1, 2, 1, 10),
(2, 6, 1, 2),
(3, 5, 1, 3),
(4, 1, 1, 1),
(5, 9, 1, 1),
(6, 4, 1, 2),
(7, 11, 1, 6),
(8, 10, 1, 2),
(9, 3, 1, 3),
(10, 3, 1, 1),
(11, 2, 1, 1);


INSERT INTO DettaglioOrdini (Id_Ordine, Id_Prodotto, Id_Cliente, Prezzo_Totale) VALUES
(1, 2, 1, 20.00 * 10),  -- 10 Mouse a 20.00 ciascuno
(2, 6, 2, 200.00 * 2),  -- 2 SSD a 200.00 ciascuno
(3, 5, 3, 90.00 * 3),   -- 3 HHD a 90.00 ciascuno
(4, 1, 4, 300.00 * 1),  -- 1 Tablet a 300.00
(5, 9, 5, 45.00 * 1),   -- 1 Webcam a 45.00
(6, 4, 6, 180.00 * 2),  -- 2 Monitor a 180.00 ciascuno
(7, 11, 7, 500.00 * 6), -- 6 Trackpad a 500.00 ciascuno
(8, 10, 1, 1250.00 * 2),-- 2 GPU a 1250.00 ciascuno
(9, 3, 2, 25.00 * 3),   -- 3 Tastiere a 25.00 ciascuno
(10, 3, 3, 25.00 * 1),  -- 1 Tastiera a 25.00
(11, 2, 4, 20.00 * 1);  -- 1 Mouse a 20.00

"DROP TRIGGER IF EXISTS CalcolaPrezzoTotale;"

SELECT 
    Clienti.Id_Cliente, 
    Clienti.Nome, 
    SUM(DettaglioOrdini.Prezzo_Totale) AS SpesaTotale
FROM 
    Clienti
JOIN 
    Ordini ON Clienti.Id_Cliente = Ordini.Id_Cliente
JOIN 
    DettaglioOrdini ON Ordini.Id_Ordine = DettaglioOrdini.Id_Ordine
GROUP BY 
    Clienti.Id_Cliente, Clienti.Nome;

