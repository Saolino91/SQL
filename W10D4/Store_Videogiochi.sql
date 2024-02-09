"Scelta DB"

USE videogame_store_db;

"Crea tabella Store"

CREATE TABLE Store (CodiceStore INTEGER PRIMARY KEY,
IndirizzoFisico VARCHAR(50),
NumeroTelefono VARCHAR(15));

"Crea tabella Impiegato"

CREATE TABLE Impiegato (CodiceFiscale VARCHAR(16) PRIMARY KEY,
Nome VARCHAR(50),
TitoloStudio VARCHAR(50),
Recapito VARCHAR(40));
"Crea tabella Servizio_Impiegato"

CREATE TABLE Servizio_Impiegato (Id_Servizio INTEGER PRIMARY KEY AUTO_INCREMENT,
CodiceFiscale VARCHAR(16),
CodiceStore INTEGER,
DataInizio DATE,
DataFine DATE,
Carica VARCHAR(30),
FOREIGN KEY (CodiceFiscale) REFERENCES Impiegato(CodiceFiscale),
FOREIGN KEY (CodiceStore) REFERENCES Store(CodiceStore));

"Crea tabella Videogioco"

CREATE TABLE Videogioco (Titolo VARCHAR(50) PRIMARY KEY,
Sviluppatore VARCHAR(30),
Anno_Distribuzione YEAR,
Costo_Acquisto REAL,
Genere VARCHAR(30),
RemakeDi VARCHAR(30));
DROP TABLE Videogioco; 

"Popolo tabella Store"

INSERT INTO Store (CodiceStore, IndirizzoFisico, NumeroTelefono) VALUES
(1, 'Via Roma 123, Milano', '+39 02 1234567'),
(2, 'Corso Italia 456, Roma', '+39 06 7654321'),
(3, 'Piazza San Marco 789, Venezia', '+39 041 9876543'),
(4, 'Viale degli Ulivi 234, Napoli', '+39 081 3456789'),
(5, 'Via Torino 567, Torino', '+39 011 8765432'),
(6, 'Corso Vittorio Emanuele 890, Firenze', '+39 055 2345678'),
(7, 'Piazza del Duomo 123, Bologna', '+39 051 8765432'),
(8, 'Via Garibaldi 456, Genova', '+39 010 2345678'),
(9, 'Lungarno Mediceo 789, Pisa', '+39 050 8765432'),
(10, 'Corso Cavour 101, Palermo', '+39 091 2345678');

"Popolo tabella Impiegato"

INSERT INTO Impiegato VALUES
('ABC12345XYZ67890', 'Mario Rossi', 'Laurea in Economia', 'mario.rossi@email.com'),
('DEF67890XYZ12345', 'Anna Verdi', 'Diploma di Ragioneria', 'anna.verdi@email.com'),
('GHI12345XYZ67890', 'Luigi Bianchi', 'Laurea in Informatica', 'luigi.bianchi@email.com'),
('JKL67890XYZ12345', 'Laura Neri', 'Laurea in Lingue', 'laura.neri@email.com'),
('MNO12345XYZ67890', 'Andrea Moretti', 'Diploma di Geometra', 'andrea.moretti@email.com'),
('PQR67890XYZ12345', 'Giulia Ferrara', 'Laurea in Psicologia', 'giulia.ferrara@email.com'),
('STU12345XYZ67890', 'Marco Esposito', 'Diploma di Elettronica', 'marco.esposito@email.com'),
('VWX67890XYZ12345', 'Sara Romano', 'Laurea in Giurisprudenza', 'sara.romano@email.com'),
('YZA12345XYZ67890', 'Roberto De Luca', 'Diploma di Informatica', 'roberto.deluca@email.com'),
('BCD67890XYZ12345', 'Elena Santoro', 'Laurea in Lettere', 'elena.santoro@email.com');

"Popolo tabella Servizio_Impiegato"

INSERT INTO Servizio_Impiegato (CodiceFiscale, CodiceStore, DataInizio, DataFine, Carica) VALUES
('ABC12345XYZ67890', 1, '2023-01-01', '2023-12-31', 'Cassiere'),
('DEF67890XYZ12345', 2, '2023-02-01', '2023-11-30', 'Commesso'),
('GHI12345XYZ67890', 3, '2023-03-01', '2023-10-31', 'Magazziniere'),
('JKL67890XYZ12345', 4, '2023-04-01', '2023-09-30', 'Addetto alle vendite'),
('MNO12345XYZ67890', 5, '2023-05-01', '2023-08-31', 'Addetto alle pulizie'),
('PQR67890XYZ12345', 6, '2023-06-01', '2023-07-31', 'Commesso'),
('STU12345XYZ67890', 7, '2023-07-01', '2023-06-30', 'Commesso'),
('VWX67890XYZ12345', 8, '2023-08-01', '2023-05-31', 'Cassiere'),
('YZA12345XYZ67890', 9, '2023-09-01', '2023-04-30', 'Cassiere'),
('BCD67890XYZ12345', 10, '2023-10-01', '2023-03-31', 'Cassiere');

"Popolo tabella Videogioco"

INSERT INTO Videogioco VALUES
('Fifa 2023', 'EA Sports', 2023, '49.99', 'Calcio', NULL),
('Assassin''s Creed: Valhalla', 'Ubisoft', 2020, '59.99', 'Action', NULL),
('Super Mario Odyssey', 'Nintendo', 2017, '39.99', 'Platform', NULL),
('The Last of Us Part II', 'Naughty Dog', 2020, '69.99', 'Action', NULL),
('Cyberpunk 2077', 'CD Projekt Red', 2020, '49.99', 'RPG', NULL),
('Animal Crossing: New Horizons', 'Nintendo', 2020, '54.99', 'Simulation', NULL),
('Call of Duty: Warzone', 'Infinity Ward', 2020, '0.00', 'FPS', NULL),
('The Legend of Zelda: Breath of the Wild', 'Nintendo', 2017, '59.99', 'Action-Adventure', NULL),
('Fortnite', 'Epic Games', 2017, '0.00', 'Battle Royale', NULL),
('Red Dead Redemption 2', 'Rockstar Games', 2018, '39.99', 'Action-Adventure', NULL);

"Crea tabella associativa Collocazione"

CREATE TABLE Collocazione (Id_Collocazione INTEGER PRIMARY KEY AUTO_INCREMENT,
Titolo VARCHAR(50),
CodiceStore INTEGER,
N_Copie INTEGER,
FOREIGN KEY (Titolo) REFERENCES Videogioco(Titolo),
FOREIGN KEY (CodiceStore) REFERENCES Store(CodiceStore));

-- DROP TABLE collocazione --

INSERT INTO Collocazione (Titolo, CodiceStore, N_Copie) VALUES
('Fifa 2023', 1, 10),
('Assassin''s Creed: Valhalla', 2, 23),
('Super Mario Odyssey', 3, 25),
('The Last of Us Part II', 4, 9),
('Cyberpunk 2077', 5, 22),
('Animal Crossing: New Horizons', 6, 24),
('Call of Duty: Warzone', 7, 11),
('The Legend of Zelda: Breath of the Wild', 8, 15),
('Fortnite', 9, 20),
('Red Dead Redemption 2', 10, 4);

SELECT 
    v.Titolo, s.IndirizzoFisico
FROM
    Collocazione AS c
        JOIN
    Videogioco AS v ON c.Titolo = v.Titolo
        JOIN
    Store AS s ON c.CodiceStore = s.CodiceStore
WHERE
    v.Titolo = 'Fifa 2023';

-- Seleziona tutti gli impiegati con laurea in economia --    
    
SELECT * FROM impiegato
where TitoloStudio="Laurea in Economia"

-- Seleziona gli impiegati che lavorano come Cassiere o che hanno un Diploma di Informatica -- 

SELECT 
    *
FROM
    impiegato
        LEFT JOIN
    servizio_impiegato ON impiegato.CodiceFiscale = servizio_impiegato.CodiceFiscale
WHERE
    servizio_impiegato.carica = 'Cassiere'
        OR impiegato.titolostudio = 'Diploma in Informatica';

SELECT 
    *
FROM
    impiegato
        LEFT JOIN
    servizio_impiegato ON impiegato.CodiceFiscale = servizio_impiegato.CodiceFiscale
WHERE
    servizio_impiegato.Carica IN ('Cassiere');

-- Seleziona i nomi e i titoli degli impiegati che hanno iniziato a lavorare dopo il 1 gennaio 2023 -- 

SELECT 
    Nome, TitoloStudio
FROM
    impiegato
        LEFT JOIN
    servizio_impiegato ON impiegato.CodiceFiscale = servizio_impiegato.CodiceFiscale
WHERE
    servizio_impiegato.DataInizio > '2023-01-01';

-- Seleziona i titoli di studio distinti tra gli impiegati -- 

SELECT DISTINCT
    TitoloStudio
FROM
    Impiegato;

-- Seleziona gli impiegati con un titolo di studio diverso da "Laurea in Economia". Seleziona gli impiegati che hanno iniziato a lavorare prima del 1 luglio 2023 e sono Commessi --

SELECT 
    nome, titolostudio
FROM
    impiegato
WHERE
    TitoloStudio <> 'Laurea in Economia';

-- Seleziona gli impiegati che hanno iniziato a lavorare prima del 1 luglio 2023 e sono Commessi --

SELECT 
    nome
FROM
    impiegato
        LEFT JOIN
    servizio_impiegato ON impiegato.CodiceFiscale = servizio_impiegato.CodiceFiscale
WHERE
    servizio_impiegato.DataInizio < '2023-07-01'
        AND servizio_impiegato.Carica = 'Commesso';

-- Seleziona i titoli e gli sviluppatori dei videogiochi distribuiti nel 2020 --

SELECT 
    titolo, sviluppatore
FROM
    videogioco
WHERE
    Anno_Distribuzione = 2020;

-- Seleziona i titoli dei videogiochi disponibili nei settori 1 o 3 del negozio 5 --

SELECT 
    *
FROM
    videogioco
        LEFT JOIN
    collocazione ON videogioco.Titolo = collocazione.Titolo
WHERE
    (Id_Collocazione = 1
        OR Id_Collocazione = 3)
        OR CodiceStore = 5;

-- Seleziona i negozi con più di 20 copie disponibili di almeno un videogioco. --

SELECT 
    CodiceStore
FROM
    videogioco
        LEFT JOIN
    collocazione ON videogioco.Titolo = collocazione.Titolo
WHERE
    N_Copie > 20
