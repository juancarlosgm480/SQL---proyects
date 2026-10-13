/*========================================================
=            PROYECTO BD - LONJA DE PESCADO (ORACLE)     =
=========================================================*/


/*=========================================================
=            1. CREACIÓN DE USUARIO                      =
=========================================================*/

CREATE USER lonja IDENTIFIED BY lonja123;

GRANT CONNECT, RESOURCE TO lonja;


/*=========================================================
=            2. TABLAS                                   =
=========================================================*/

CREATE TABLE BARCO (
    matricula VARCHAR2(20) PRIMARY KEY,
    nombre VARCHAR2(100),
    clase VARCHAR2(50),
    capitan VARCHAR2(100),
    armador VARCHAR2(100),
    telefono VARCHAR2(15)
);

CREATE TABLE ESPECIE (
    cod_especie NUMBER PRIMARY KEY,
    nombre VARCHAR2(100),
    tipo VARCHAR2(50),
    descripcion VARCHAR2(200)
);

CREATE TABLE CALADERO (
    nombre VARCHAR2(100) PRIMARY KEY,
    extension NUMBER(10,2),
    ubicacion VARCHAR2(150)
);

CREATE TABLE LOTE (
    cod_lote NUMBER PRIMARY KEY,
    num_cajas NUMBER,
    kilos_totales NUMBER(10,2),
    fecha_recepcion DATE,
    precio_salida_kg NUMBER(10,2),
    precio_salida_total NUMBER(10,2),
    matricula VARCHAR2(20),
    cod_especie NUMBER,
    FOREIGN KEY (matricula) REFERENCES BARCO(matricula),
    FOREIGN KEY (cod_especie) REFERENCES ESPECIE(cod_especie)
);

CREATE TABLE CAPTURA (
    matricula VARCHAR2(20),
    nombre_caladero VARCHAR2(100),
    cod_especie NUMBER,
    fecha_inicio DATE,
    fecha_fin DATE,
    kilos NUMBER(10,2),
    PRIMARY KEY (matricula, nombre_caladero, cod_especie, fecha_inicio),
    FOREIGN KEY (matricula) REFERENCES BARCO(matricula),
    FOREIGN KEY (nombre_caladero) REFERENCES CALADERO(nombre),
    FOREIGN KEY (cod_especie) REFERENCES ESPECIE(cod_especie)
);

CREATE TABLE COMPRADOR (
    cod_comprador NUMBER PRIMARY KEY,
    nombre VARCHAR2(100),
    direccion VARCHAR2(150),
    cif VARCHAR2(20),
    cuota_inicial NUMBER(10,2),
    tipo VARCHAR2(10),
    num_cuenta VARCHAR2(34),
    importe_acumulado NUMBER(10,2),
    fecha_vencimiento DATE,
    estado_factura VARCHAR2(20)
);

CREATE TABLE ADJUDICACION (
    cod_lote NUMBER PRIMARY KEY,
    cod_comprador NUMBER,
    precio_compra_kg NUMBER(10,2),
    precio_total NUMBER(10,2),
    FOREIGN KEY (cod_lote) REFERENCES LOTE(cod_lote),
    FOREIGN KEY (cod_comprador) REFERENCES COMPRADOR(cod_comprador)
);

CREATE TABLE FACTURA (
    num_factura NUMBER PRIMARY KEY,
    fecha_emision DATE,
    importe_total NUMBER(10,2)
);

CREATE TABLE FACTURA_COMPRADOR (
    num_factura NUMBER PRIMARY KEY,
    cod_comprador NUMBER,
    FOREIGN KEY (num_factura) REFERENCES FACTURA(num_factura),
    FOREIGN KEY (cod_comprador) REFERENCES COMPRADOR(cod_comprador)
);

CREATE TABLE FACTURA_BARCO (
    num_factura NUMBER PRIMARY KEY,
    matricula VARCHAR2(20),
    FOREIGN KEY (num_factura) REFERENCES FACTURA(num_factura),
    FOREIGN KEY (matricula) REFERENCES BARCO(matricula)
);

CREATE TABLE FACTURA_LOTE (
    num_factura NUMBER,
    cod_lote NUMBER,
    PRIMARY KEY (num_factura, cod_lote),
    FOREIGN KEY (num_factura) REFERENCES FACTURA(num_factura),
    FOREIGN KEY (cod_lote) REFERENCES LOTE(cod_lote)
);


/*=========================================================
=            3. INSERTS                                  =
=========================================================*/

/*=========================================================
=            3. INSERTS (CORREGIDOS Y AMPLIADOS)          =
=========================================================*/

-- --- INSERTS EN BARCO ---
INSERT INTO BARCO (matricula, nombre, clase, capitan, armador, telefono) 
VALUES ('B001', 'Atlántico', 'Arrastrero', 'Antonio Recio', 'Pesquera Sur', '600111222');

INSERT INTO BARCO (matricula, nombre, clase, capitan, armador, telefono) 
VALUES ('B002', 'Mar Azul', 'Cerquero', 'Luis Gómez', 'Costa Norte', '600222333');

INSERT INTO BARCO (matricula, nombre, clase, capitan, armador, telefono) 
VALUES ('B003', 'Titán del Mar', 'Palangrero', 'María Ordóñez', 'PescaGalicia', '600444555');


-- --- INSERTS EN ESPECIE ---
INSERT INTO ESPECIE (cod_especie, nombre, tipo, descripcion) 
VALUES (1, 'Merluza', 'Pescado', 'Pescado blanco fresco');

INSERT INTO ESPECIE (cod_especie, nombre, tipo, descripcion) 
VALUES (2, 'Pulpo', 'Marisco', 'Molusco cefalópodo gallego');

INSERT INTO ESPECIE (cod_especie, nombre, tipo, descripcion) 
VALUES (3, 'Atún Rojo', 'Pescado', 'Pescado azul de almadraba');


-- --- INSERTS EN CALADERO ---
INSERT INTO CALADERO (nombre, extension, ubicacion) 
VALUES ('Cantábrico', 5000.00, 'Norte de España');

INSERT INTO CALADERO (nombre, extension, ubicacion) 
VALUES ('Atlántico Norte', 8000.00, 'Océano Atlántico');

INSERT INTO CALADERO (nombre, extension, ubicacion) 
VALUES ('Golfo de Cádiz', 3500.00, 'Sur de España');


-- --- INSERTS EN CAPTURA ---
INSERT INTO CAPTURA (matricula, nombre_caladero, cod_especie, fecha_inicio, fecha_fin, kilos) 
VALUES ('B001', 'Cantábrico', 1, TO_DATE('2026-05-01','YYYY-MM-DD'), TO_DATE('2026-05-05','YYYY-MM-DD'), 450.50);

INSERT INTO CAPTURA (matricula, nombre_caladero, cod_especie, fecha_inicio, fecha_fin, kilos) 
VALUES ('B002', 'Atlántico Norte', 2, TO_DATE('2026-05-02','YYYY-MM-DD'), TO_DATE('2026-05-06','YYYY-MM-DD'), 200.00);

INSERT INTO CAPTURA (matricula, nombre_caladero, cod_especie, fecha_inicio, fecha_fin, kilos) 
VALUES ('B003', 'Golfo de Cádiz', 3, TO_DATE('2026-05-10','YYYY-MM-DD'), TO_DATE('2026-05-12','YYYY-MM-DD'), 1200.00);


-- --- INSERTS EN COMPRADOR ---
INSERT INTO COMPRADOR (cod_comprador, nombre, direccion, cif, cuota_inicial, tipo, num_cuenta, importe_acumulado, fecha_vencimiento, estado_factura) 
VALUES (1, 'Mariscos Recio', 'Calle Mayor 10', 'A12345678', 500.00, 'contado', NULL, 0.00, NULL, 'pagado');

INSERT INTO COMPRADOR (cod_comprador, nombre, direccion, cif, cuota_inicial, tipo, num_cuenta, importe_acumulado, fecha_vencimiento, estado_factura) 
VALUES (2, 'Mariscos Ruiz', 'Av. Puerto 5', 'B87654321', 800.00, 'credito', 'ES123456789012345678901234', 2000.00, TO_DATE('2026-12-31','YYYY-MM-DD'), 'pendiente');

INSERT INTO COMPRADOR (cod_comprador, nombre, direccion, cif, cuota_inicial, tipo, num_cuenta, importe_acumulado, fecha_vencimiento, estado_factura) 
VALUES (3, 'Pescadería del Barrio', 'Plaza Central 3', 'C45678912', 300.00, 'contado', NULL, 1500.00, NULL, 'pagado');


-- --- INSERTS EN LOTE ---
INSERT INTO LOTE (cod_lote, num_cajas, kilos_totales, fecha_recepcion, precio_salida_kg, precio_salida_total, matricula, cod_especie) 
VALUES (101, 15, 150.00, TO_DATE('2026-05-06','YYYY-MM-DD'), 6.00, 900.00, 'B001', 1);

INSERT INTO LOTE (cod_lote, num_cajas, kilos_totales, fecha_recepcion, precio_salida_kg, precio_salida_total, matricula, cod_especie) 
VALUES (102, 10, 80.00, TO_DATE('2026-05-07','YYYY-MM-DD'), 12.00, 960.00, 'B002', 2);

INSERT INTO LOTE (cod_lote, num_cajas, kilos_totales, fecha_recepcion, precio_salida_kg, precio_salida_total, matricula, cod_especie) 
VALUES (103, 40, 500.00, TO_DATE('2026-05-13','YYYY-MM-DD'), 20.00, 10000.00, 'B003', 3);

INSERT INTO LOTE (cod_lote, num_cajas, kilos_totales, fecha_recepcion, precio_salida_kg, precio_salida_total, matricula, cod_especie) 
VALUES (104, 5, 40.00, TO_DATE('2026-05-14','YYYY-MM-DD'), 5.50, 220.00, 'B001', 1); -- Quedará sin adjudicar


-- --- INSERTS EN ADJUDICACION ---
INSERT INTO ADJUDICACION (cod_lote, cod_comprador, precio_compra_kg, precio_total) 
VALUES (101, 1, 6.50, 975.00);

INSERT INTO ADJUDICACION (cod_lote, cod_comprador, precio_compra_kg, precio_total) 
VALUES (102, 2, 14.00, 1120.00);

INSERT INTO ADJUDICACION (cod_lote, cod_comprador, precio_compra_kg, precio_total) 
VALUES (103, 3, 22.00, 11000.00);


-- --- INSERTS EN FACTURA ---
INSERT INTO FACTURA (num_factura, fecha_emision, importe_total) 
VALUES (1001, TO_DATE('2026-05-07','YYYY-MM-DD'), 975.00);

INSERT INTO FACTURA (num_factura, fecha_emision, importe_total) 
VALUES (1002, TO_DATE('2026-05-08','YYYY-MM-DD'), 1120.00);


-- --- INSERTS EN RELACIONES DE FACTURAS ---
INSERT INTO FACTURA_COMPRADOR (num_factura, cod_comprador) VALUES (1001, 1);
INSERT INTO FACTURA_COMPRADOR (num_factura, cod_comprador) VALUES (1002, 2);

INSERT INTO FACTURA_BARCO (num_factura, matricula) VALUES (1001, 'B001');
INSERT INTO FACTURA_BARCO (num_factura, matricula) VALUES (1002, 'B002');

INSERT INTO FACTURA_LOTE (num_factura, cod_lote) VALUES (1001, 101);
INSERT INTO FACTURA_LOTE (num_factura, cod_lote) VALUES (1002, 102);


commit;


/*=========================================================
=            4. CONSULTAS                                =
=========================================================*/

SELECT * FROM BARCO;

SELECT nombre, tipo FROM ESPECIE;

SELECT * FROM LOTE WHERE kilos_totales > 100;

SELECT c.nombre, a.cod_lote
FROM COMPRADOR c
JOIN ADJUDICACION a ON c.cod_comprador = a.cod_comprador;

SELECT e.nombre, SUM(kilos) AS total_kilos
FROM ESPECIE e
JOIN CAPTURA c ON e.cod_especie = c.cod_especie
GROUP BY e.nombre;

SELECT c.nombre, SUM(a.precio_total) AS total_gastado
FROM COMPRADOR c
JOIN ADJUDICACION a ON c.cod_comprador = a.cod_comprador
GROUP BY c.nombre;


/*=========================================================
=            5. VISTA                                   =
=========================================================*/

CREATE OR REPLACE VIEW vista_lotes AS
SELECT l.cod_lote, c.nombre AS comprador, a.precio_total
FROM LOTE l
JOIN ADJUDICACION a ON l.cod_lote = a.cod_lote
JOIN COMPRADOR c ON c.cod_comprador = a.cod_comprador;

CREATE OR REPLACE VIEW vista_capturas_barco AS
SELECT 
    b.matricula,
    b.nombre AS nombre_barco,
    SUM(c.kilos) AS kilos_totales,
    COUNT(DISTINCT c.cod_especie) AS especies_distintas
FROM BARCO b
LEFT JOIN CAPTURA c ON b.matricula = c.matricula
GROUP BY b.matricula, b.nombre;

select * from vista_capturas_barco;

--Vista de facturas completas (factura + comprador + barco + lotes)
CREATE OR REPLACE VIEW vista_facturas_detalle AS
SELECT 
    f.num_factura,
    f.fecha_emision,
    f.importe_total,
    c.nombre AS comprador,
    b.nombre AS barco,
    fl.cod_lote
FROM FACTURA f
LEFT JOIN FACTURA_COMPRADOR fc ON f.num_factura = fc.num_factura
LEFT JOIN COMPRADOR c ON fc.cod_comprador = c.cod_comprador
LEFT JOIN FACTURA_BARCO fb ON f.num_factura = fb.num_factura
LEFT JOIN BARCO b ON fb.matricula = b.matricula
LEFT JOIN FACTURA_LOTE fl ON f.num_factura = fl.num_factura;
-- Vista de lotes sin adjudicar
CREATE OR REPLACE VIEW vista_lotes_sin_adjudicar AS
SELECT 
    l.cod_lote,
    l.kilos_totales,
    l.fecha_recepcion,
    l.matricula,
    l.cod_especie
FROM LOTE l
LEFT JOIN ADJUDICACION a ON l.cod_lote = a.cod_lote
WHERE a.cod_lote IS NULL;

-- Vista de compradores con deuda
CREATE OR REPLACE VIEW vista_compradores_deuda AS
SELECT 
    cod_comprador,
    nombre,
    importe_acumulado,
    fecha_vencimiento,
    estado_factura
FROM COMPRADOR
WHERE estado_factura <> 'pagado'
   OR NVL(importe_acumulado,0) > 0;


-- Vista de barcos con sus lotes entregados
CREATE OR REPLACE VIEW vista_barcos_lotes AS
SELECT 
    b.matricula,
    b.nombre AS barco,
    l.cod_lote,
    l.kilos_totales,
    l.fecha_recepcion
FROM BARCO b
LEFT JOIN LOTE l ON b.matricula = l.matricula;

--Select con subconsultas--
-- Compradores que han gastado más que la media
SELECT nombre, importe_acumulado
FROM COMPRADOR
WHERE importe_acumulado >
      (SELECT AVG(importe_acumulado) FROM COMPRADOR);
/*=========================================================
=            6. TRIGGER                                 =
=========================================================*/

CREATE OR REPLACE TRIGGER trg_precio_lote
BEFORE INSERT ON ADJUDICACION
FOR EACH ROW
BEGIN
    IF :NEW.precio_total <= 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El precio debe ser mayor que 0');
    END IF;
END;
/

INSERT INTO ADJUDICACION (cod_lote, cod_comprador, precio_compra_kg, precio_total) 
VALUES (104, 1, 5.50, 0);



/*=========================================================
=            7. CURSOR + PROCEDIMIENTO                  =
=========================================================*/

CREATE OR REPLACE PROCEDURE listar_barcos IS
    CURSOR cur IS SELECT nombre FROM BARCO;
    v_nombre BARCO.nombre%TYPE;
BEGIN
    OPEN cur;
    LOOP
        FETCH cur INTO v_nombre;
        EXIT WHEN cur%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(v_nombre);
    END LOOP;
    CLOSE cur;
END;
/

SET SERVEROUTPUT ON;
EXEC listar_barcos;

/*=========================================================
=            8. PROCEDIMIENTO SIMPLE                     =
=========================================================*/

CREATE OR REPLACE PROCEDURE total_facturado IS
    total NUMBER;
BEGIN
    SELECT NVL(SUM(importe_total),0)
    INTO total
    FROM FACTURA;

    DBMS_OUTPUT.PUT_LINE('Total facturado: ' || total);
END;
/

SET SERVEROUTPUT ON;
EXEC total_facturado;

/*=========================================================
=            9. BORRADO FINAL                            =
=========================================================*/

DROP VIEW vista_lotes;

DROP TABLE FACTURA_LOTE;
DROP TABLE FACTURA_BARCO;
DROP TABLE FACTURA_COMPRADOR;
DROP TABLE FACTURA;
DROP TABLE ADJUDICACION;
DROP TABLE CAPTURA;
DROP TABLE LOTE;
DROP TABLE COMPRADOR;
DROP TABLE CALADERO;
DROP TABLE ESPECIE;
DROP TABLE BARCO;

DROP USER lonja CASCADE;