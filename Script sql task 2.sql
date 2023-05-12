-- Script sql task 2

-- Transaction SQL
START TRANSACTION;

INSERT INTO employees 
VALUES 
(1710,"Pakpahan","Naufal","x3001","naufal@yopmail.com","1",1088,"Sales Rep"),
(1711,"Anggraini","Yulia","x3002","anggri@yopmail.com","2",1088,"Sales Rep"),
(1712,"Santri","Bhimo","x3003","santri@yopmail.com","3",1088,"Sales Rep"),
(1713,"Fitria","Nurul","x3004","nurul@yopmail.com","4",1088,"Sales Rep"),
(1714,"Waliyuddin","Akbar","x3005","akbar@yopmail.com","5",1088,"Sales Rep");

COMMIT;

-- sesi 1
START TRANSACTION;

SELECT * FROM employees;

INSERT INTO employees VALUES (1715,"Permadi","Bayu","x3006","permadi@yopmail.com","6",1088,"Sales Rep"), (1716,"Aditya","Reno","x3007","reno@yopmail.com","7",1088,"Sales Rep");

SAVEPOINT my_savepoint;

INSERT INTO employees VALUES (1717,"Sakti","Bima","x3008","bima@yopmail.com","1",1088,"Sales Rep");

UPDATE employees SET jobTitle = "VP Sales" WHERE employeeNumber = 1717;

DELETE FROM employees WHERE employeeNumber = 1717;

ROLLBACK TO SAVEPOINT my_savepoint;

INSERT INTO employees VALUES (1718,"Anwar","Taufik","x3009","taufik@yopmail.com","2",1088,"Sales Rep");

COMMIT;

-- sesi 2
SELECT * FROM employees WHERE employeeNumber > 1702;


-- 
-- create table from data GoCar
-- use Normalization

CREATE TABLE transactions (
idTransaksi VARCHAR(50) NOT NULL,
tglTransaksi DATE,
idPelanggan VARCHAR(20) NOT NULL,
idPengemudi VARCHAR(10) NOT NULL,
idKendaraan VARCHAR(20) NOT NULL,
idAlamatPenjemputan VARCHAR(20),
idAlamatTujuan VARCHAR (20),
biayaPerjalanan INT,
biayaJasaAplikasi INT,
totalPembayaran INT,
PRIMARY KEY (idTransaksi),
FOREIGN KEY (idPelanggan) REFERENCES pelanggan(id),
FOREIGN KEY (idPengemudi) REFERENCES pengemudi(id),
FOREIGN KEY (idKendaraan) REFERENCES kendaraan(id),
FOREIGN KEY (idAlamatPenjemputan) REFERENCES penjemputan(id),
FOREIGN KEY (idAlamatTujuan) REFERENCES tujuan(id)
);


CREATE TABLE pelanggan (
id VARCHAR(20) NOT NULL,
nama VARCHAR(100),
PRIMARY KEY (id)
);

CREATE TABLE biaya (
id VARCHAR (20),
perjalanan INT,
jasaApp INT,
total INT,
PRIMARY KEY (id)
);

CREATE TABLE pengemudi (
id VARCHAR(10) NOT NULL,
nama VARCHAR(100),
PRIMARY KEY (id)
);

CREATE TABLE kendaraan (
id VARCHAR(20) NOT NULL,
merk VARCHAR(100),
noPlat VARCHAR (20),
PRIMARY KEY (id)
);

CREATE TABLE penjemputan (
id VARCHAR(20),
alamat TEXT,
kecamatan VARCHAR (50),
kabupaten VARCHAR (50),
provinsi VARCHAR (50),
kdPos VARCHAR (10),
negara VARCHAR (20),
PRIMARY KEY (id)
);

CREATE TABLE tujuan (
id VARCHAR(20),
alamat TEXT,
kecamatan VARCHAR (50),
kabupaten VARCHAR (50),
provinsi VARCHAR (50),
kdPos VARCHAR (10),
negara VARCHAR (20),
PRIMARY KEY (id)
);

-- insert data dengan subquery

INSERT INTO pelanggan
SELECT idpelanggan, namaPelanggan FROM transactions;

-- select data dengan subquery

SELECT * FROM kendaraan
WHERE id IN (SELECT idKendaraan FROM transactions);

-- update data dengan subquery

UPDATE pelanggan SET nama = "Balqis Rizki P" WHERE id IN (SELECT idPelanggan FROM transactions);

-- delete data dengan subquery

DELETE FROM pelanggan WHERE id IN (SELECT idPelanggan FROM transactions);

-- Filter dari column dengan agregasi nilai paling besar

SELECT * FROM transactions WHERE biayaPerjalanan = (SELECT MAX(perjalanan) FROM biaya);

-- Query dari Subquery sebagai source data

SELECT * FROM (SELECT idpelanggan FROM transactions WHERE idTransaksi IS NOT NULL) as pelanggans;

-- Combine query UNION 

SELECT nama FROM pelanggan
UNION
SELECT nama FROM pengemudi

-- Combine query INTERSECT

SELECT nama FROM pelanggan
INTERSECT
SELECT nama FROM pengemudi