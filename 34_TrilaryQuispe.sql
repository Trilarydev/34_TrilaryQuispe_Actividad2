DROP DATABASE IF EXISTS db_SalesClothes;

CREATE DATABASE db_SalesClothes;

USE db_SalesClothes;

-- tables
-- Table: client
CREATE TABLE client (
    id int  NOT NULL,
    type_document char(3)  NOT NULL,
    number_document char(15)  NOT NULL,
    names varchar(60)  NOT NULL,
    last_name varchar(90)  NOT NULL,
    email varchar(80)  NOT NULL,
    cell_phone char(9)  NOT NULL,
    birthdate date  NOT NULL,
    active bit  NOT NULL,
    CONSTRAINT client_pk PRIMARY KEY  (id)
);

/* Ver estructura de tabla client */
EXEC sp_columns @table_name = 'client';

-- Table: clothes
CREATE TABLE clothes (
    id int  NOT NULL,
    description varchar(60)  NOT NULL,
    brand varchar(60)  NOT NULL,
    amount int  NOT NULL,
    size varchar(10)  NOT NULL,
    price decimal(8,2)  NOT NULL,
    active bit  NOT NULL,
    CONSTRAINT clothes_pk PRIMARY KEY  (id)
);

/* Ver estructura de tabla clothes */
EXEC sp_columns @table_name = 'clothes';

-- Table: sale
CREATE TABLE sale (
    id int  NOT NULL,
    date_time datetime  NOT NULL,
    active bit  NOT NULL,
    client_id int  NOT NULL,
    seller_id int  NOT NULL,
    CONSTRAINT sale_pk PRIMARY KEY  (id)
);

/* Ver estructura de tabla sale */
EXEC sp_columns @table_name = 'sale';

-- Table: sale_detail
CREATE TABLE sale_detail (
    id int  NOT NULL,
    amount int  NOT NULL,
    sale_id int  NOT NULL,
    clothes_id int  NOT NULL,
    CONSTRAINT sale_detail_pk PRIMARY KEY  (id)
);

/* Ver estructura de sale_detail */
EXEC sp_columns @table_name = 'sale_detail';

-- Table: seller
CREATE TABLE seller (
    id int  NOT NULL,
    type_document char(3)  NOT NULL,
    number_document char(15)  NOT NULL,
    names varchar(60)  NOT NULL,
    last_name varchar(90)  NOT NULL,
    salary decimal(8,2)  NOT NULL,
    cell_phone char(9)  NOT NULL,
    email varchar(80)  NOT NULL,
    activo bit  NOT NULL,
    CONSTRAINT seller_pk PRIMARY KEY  (id)
);

/* Ver estructura de seller */
EXEC sp_columns @table_name = 'seller';

-- foreign keys
-- Reference: sale_client (table: sale)
ALTER TABLE sale ADD CONSTRAINT sale_client
    FOREIGN KEY (client_id)
    REFERENCES client (id);

-- Reference: sale_detail_clothes (table: sale_detail)
ALTER TABLE sale_detail ADD CONSTRAINT sale_detail_clothes
    FOREIGN KEY (clothes_id)
    REFERENCES clothes (id);

-- Reference: sale_detail_sale (table: sale_detail)
ALTER TABLE sale_detail ADD CONSTRAINT sale_detail_sale
    FOREIGN KEY (sale_id)
    REFERENCES sale (id);

-- Reference: sale_seller (table: sale)
ALTER TABLE sale ADD CONSTRAINT sale_seller
    FOREIGN KEY (seller_id)
    REFERENCES seller (id);

	/* Listar tablas de la base de datos db_SalesClothes */
SELECT * FROM INFORMATION_SCHEMA.TABLES;

	/* Ver relaciones creadas entre las tablas de la base de datos */
SELECT 
    fk.name [Constraint],
    OBJECT_NAME(fk.parent_object_id) [Tabla],
    COL_NAME(fc.parent_object_id,fc.parent_column_id) [Columna FK],
    OBJECT_NAME (fk.referenced_object_id) AS [Tabla base],
    COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS [Columna PK]
FROM 
    sys.foreign_keys fk
    INNER JOIN sys.foreign_key_columns fc ON (fk.OBJECT_ID = fc.constraint_object_id)
GO

-- End of file.
