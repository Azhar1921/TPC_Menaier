CREATE DATABASE MENAIER_DB
GO
USE MENAIER_DB
GO

-- AGREGAR FECHACREACION, IDUSUARIOCREACION, FECHAMODIFICACION, IDUSUARIOMODIFICACION. FECHACREACION PUEDE SER AUTOMATICA, GOOGLEAR.
-- EN LAS ENTIDADES PRINCIPALES (COMPRAS Y VENTAS)

CREATE TABLE MARCAS
(
	IDMARCA INT NOT NULL IDENTITY(40000000,1) PRIMARY KEY,
	DESCRIPCION VARCHAR(60) NOT NULL,
	ACTIVO BIT NOT NULL
)
GO
CREATE TABLE TIPOSPRODUCTO
(
	IDTIPOPRODUCTO INT NOT NULL IDENTITY(50000000,1) PRIMARY KEY,
	DESCRIPCION VARCHAR(60) NOT NULL,
	ACTIVO BIT NOT NULL
)
GO
CREATE TABLE CLIENTES
(
	IDCLIENTE INT NOT NULL IDENTITY(30000000,1) PRIMARY KEY,
	DNICUIT BIGINT,
	EMPRESA VARCHAR(60),
	TIPOCLIENTE VARCHAR(2) NOT NULL,
	ACTIVO BIT NOT NULL
)
GO
CREATE TABLE CONTACTOS
(
	IDCONTACTO INT NOT NULL IDENTITY(60000000,1) PRIMARY KEY,
	NOMBRE VARCHAR(60) NOT NULL,
	APELLIDO VARCHAR(60) NOT NULL,
	DNI INT,
	EMAIL VARCHAR(60) NOT NULL,
	ACTIVO BIT NOT NULL
)
GO
CREATE TABLE PROVEEDORES
(
	IDPROVEEDOR INT NOT NULL IDENTITY(20000000,1) PRIMARY KEY,
	EMPRESA VARCHAR(60) NOT NULL,
	CUIT BIGINT NOT NULL,
	ACTIVO BIT NOT NULL
)
GO
CREATE TABLE EMPLEADOS
(
 	IDEMPLEADO INT NOT NULL IDENTITY(10000000,1) PRIMARY KEY,
	NOMBRE VARCHAR(60) NOT NULL,
	APELLIDO VARCHAR(60) NOT NULL,
	DNI INT NOT NULL,
	FECHANAC DATE,
	USUARIO VARCHAR(60),
	CONTRASENIA VARCHAR(60),
	TIPOPERFIL VARCHAR(2) NOT NULL,
	EMAIL VARCHAR(60) NOT NULL,
	ACTIVO BIT NOT NULL
)
GO
CREATE TABLE PRODUCTOS
(
	IDPRODUCTO INT NOT NULL IDENTITY(70000000,1) PRIMARY KEY,
	IDMARCA INT NOT NULL FOREIGN KEY REFERENCES MARCAS(IDMARCA),
	IDTIPOPRODUCTO INT NOT NULL FOREIGN KEY REFERENCES TIPOSPRODUCTO(IDTIPOPRODUCTO),
	DESCRIPCION VARCHAR(60) NOT NULL,
	STOCKMIN INT NOT NULL,
	GANANCIA FLOAT NOT NULL,
	ACTIVO BIT NOT NULL
)
GO
CREATE TABLE LOTES
(
	IDLOTE BIGINT IDENTITY(140000000,1) NOT NULL PRIMARY KEY,
	IDPRODUCTO INT NOT NULL FOREIGN KEY REFERENCES PRODUCTOS(IDPRODUCTO),
	UNIDADES_PEDIDAS INT NOT NULL,
	UNIDADES_ACTUALES INT NOT NULL,
	COSTOPU FLOAT NOT NULL,
	FECHACOMPRA DATE NOT NULL,
	FECHAVENCIMIENTO DATE,
	ACTIVO BIT NOT NULL
)
GO
CREATE TABLE VENTAS
(
	IDVENTA INT NOT NULL IDENTITY(80000000,1) PRIMARY KEY,
	FECHA DATE NOT NULL,
	IDEMPLEADO INT NOT NULL FOREIGN KEY REFERENCES EMPLEADOS(IDEMPLEADO),
	IDCLIENTE INT NOT NULL FOREIGN KEY REFERENCES CLIENTES(IDCLIENTE),
	ACTIVO BIT NOT NULL
)
GO
CREATE TABLE COMPRAS
(
	IDCOMPRA INT NOT NULL IDENTITY(90000000,1) PRIMARY KEY,
	FECHA DATE NOT NULL,
	IDPROVEEDOR INT NOT NULL FOREIGN KEY REFERENCES PROVEEDORES(IDPROVEEDOR),
	ACTIVO BIT NOT NULL
)
GO
CREATE TABLE TELEFONOS
(
	IDTELEFONO INT NOT NULL IDENTITY(100000000,1) PRIMARY KEY,
	IDRELACION INT NOT NULL,
	NUMERO INT NOT NULL,
	DESCRIPCION VARCHAR(60) NOT NULL
)
GO
CREATE TABLE DOMICILIOS
(
	IDDOMICILIO INT NOT NULL IDENTITY(110000000,1) PRIMARY KEY,
	IDRELACION INT NOT NULL,
	CALLE VARCHAR(60) NOT NULL,
	ALTURA INT NOT NULL,
	DEPARTAMENTO VARCHAR(10),
	BARRIO VARCHAR(60) NOT NULL,
	CIUDAD VARCHAR(60) NOT NULL,
	PAIS VARCHAR(60),
	CP INT NOT NULL
)
GO
CREATE TABLE LOTES_X_COMPRA
(
	IDCOMPRA INT NOT NULL FOREIGN KEY REFERENCES COMPRAS(IDCOMPRA),
	IDLOTE BIGINT NOT NULL FOREIGN KEY REFERENCES LOTES(IDLOTE),
	PRIMARY KEY (IDCOMPRA, IDLOTE)
)
GO
CREATE TABLE CONTACTOS_X_CLIENTE
(
	IDCONTACTO INT NOT NULL FOREIGN KEY REFERENCES CONTACTOS(IDCONTACTO),
	IDCLIENTE INT NOT NULL FOREIGN KEY REFERENCES CLIENTES(IDCLIENTE),
	PRIMARY KEY (IDCONTACTO, IDCLIENTE)
)
GO
CREATE TABLE CONTACTOS_X_PROVEEDOR
(
	IDCONTACTO INT NOT NULL FOREIGN KEY REFERENCES CONTACTOS(IDCONTACTO),
	IDPROVEEDOR INT NOT NULL FOREIGN KEY REFERENCES PROVEEDORES(IDPROVEEDOR),
	PRIMARY KEY (IDCONTACTO, IDPROVEEDOR)
)
GO
CREATE TABLE PRODUCTOS_X_PROVEEDOR
(
	IDPROVEEDOR INT NOT NULL FOREIGN KEY REFERENCES PROVEEDORES(IDPROVEEDOR),
	IDPRODUCTO INT NOT NULL FOREIGN KEY REFERENCES PRODUCTOS(IDPRODUCTO),
	PRIMARY KEY (IDPROVEEDOR, IDPRODUCTO)
)
GO
CREATE TABLE PRODUCTOS_X_VENTA
(
	IDVENTA INT NOT NULL FOREIGN KEY REFERENCES VENTAS(IDVENTA),
	IDPRODUCTO INT NOT NULL FOREIGN KEY REFERENCES PRODUCTOS(IDPRODUCTO),
	PRIMARY KEY (IDVENTA, IDPRODUCTO),
	CANTIDAD INT NOT NULL
)
GO

SET DATEFORMAT dmy;

INSERT INTO EMPLEADOS([Nombre],[Apellido],[DNI],[FECHANAC],[USUARIO],[CONTRASENIA],[TIPOPERFIL],[EMAIL],[ACTIVO]) VALUES ('Amery','Moss',28865175,'09/11/1978','AMoss','Paesj7541','A','amoss@gmail.com',1),('Colleen','Wright',15631367,'25/12/1978','CWright','Obecm7263','S','cwright@gmail.com',1);
INSERT INTO EMPLEADOS([Nombre],[Apellido],[DNI],[FECHANAC],[USUARIO],[CONTRASENIA],[TIPOPERFIL],[EMAIL],[ACTIVO]) VALUES ('Maggie','Pacheco',18975273,'10/01/1980','MPachecho','Zyycm8013','S','mpacheco@gmail.com',1),('Ray','Humphrey',15473566,'07/06/1981','RHumphrey','Xmgkv9023','V','rhumphrey@gmail.com',1);
INSERT INTO EMPLEADOS([Nombre],[Apellido],[DNI],[FECHANAC],[USUARIO],[CONTRASENIA],[TIPOPERFIL],[EMAIL],[ACTIVO]) VALUES ('Hiram','Brown',33547894,'02/08/1996','HBrown','Gmsvu3029','V','hbrown@gmail.com',1),('Jaime','Keller',29945252,'26/03/1995','JKeller','Cssvj1840','V','jkeller@gmail.com',1);
INSERT INTO EMPLEADOS([Nombre],[Apellido],[DNI],[FECHANAC],[USUARIO],[CONTRASENIA],[TIPOPERFIL],[EMAIL],[ACTIVO]) VALUES ('Raymond','Lindsey',15167996,'17/09/1988','RLindsey','Vwogm3069','V','rlindsey@gmail.com',1),('Maryam','Watson',25354035,'11/11/1989','MWatson','Gdjbz6456','V','mwatson@gmail.com',1);

INSERT INTO MARCAS([DESCRIPCION],[ACTIVO]) VALUES ('Un Rincon Vegano',1);
INSERT INTO MARCAS([DESCRIPCION],[ACTIVO]) VALUES ('Las Vacas Felices',1);
INSERT INTO MARCAS([DESCRIPCION],[ACTIVO]) VALUES ('Vegetalex',1);
INSERT INTO MARCAS([DESCRIPCION],[ACTIVO]) VALUES ('Lucchetti',1);
INSERT INTO MARCAS([DESCRIPCION],[ACTIVO]) VALUES ('Delicias Doradas',1);
INSERT INTO MARCAS([DESCRIPCION],[ACTIVO]) VALUES ('Doritos',1);
INSERT INTO MARCAS([DESCRIPCION],[ACTIVO]) VALUES ('Lays',1);
INSERT INTO MARCAS([DESCRIPCION],[ACTIVO]) VALUES ('Arrocitas',1);
INSERT INTO MARCAS([DESCRIPCION],[ACTIVO]) VALUES ('Mister Veggie',1);
INSERT INTO MARCAS([DESCRIPCION],[ACTIVO]) VALUES ('Matarazzo',1);
INSERT INTO MARCAS([DESCRIPCION],[ACTIVO]) VALUES ('Coca Cola',1);
INSERT INTO MARCAS([DESCRIPCION],[ACTIVO]) VALUES ('Pepsi',1);
INSERT INTO MARCAS([DESCRIPCION],[ACTIVO]) VALUES ('McCain',1);
INSERT INTO MARCAS([DESCRIPCION],[ACTIVO]) VALUES ('Mi Soja',1);
INSERT INTO MARCAS([DESCRIPCION],[ACTIVO]) VALUES ('Pureza',1);
INSERT INTO MARCAS([DESCRIPCION],[ACTIVO]) VALUES ('Chango',1);
INSERT INTO MARCAS([DESCRIPCION],[ACTIVO]) VALUES ('Natura',1);
INSERT INTO MARCAS([DESCRIPCION],[ACTIVO]) VALUES ('Dánica',1);
INSERT INTO MARCAS([DESCRIPCION],[ACTIVO]) VALUES ('Dame Mani',1);
INSERT INTO MARCAS([DESCRIPCION],[ACTIVO]) VALUES ('Águila',1);
INSERT INTO MARCAS([DESCRIPCION],[ACTIVO]) VALUES ('Soyana',1);
INSERT INTO MARCAS([DESCRIPCION],[ACTIVO]) VALUES ('Virgen',1);
INSERT INTO MARCAS([DESCRIPCION],[ACTIVO]) VALUES ('Titan',1);
INSERT INTO MARCAS([DESCRIPCION],[ACTIVO]) VALUES ('Cachafaz',1);
INSERT INTO MARCAS([DESCRIPCION],[ACTIVO]) VALUES ('Granix',1);
INSERT INTO MARCAS([DESCRIPCION],[ACTIVO]) VALUES ('Oreo',1);
INSERT INTO MARCAS([DESCRIPCION],[ACTIVO]) VALUES ('Successo',1);

INSERT INTO TIPOSPRODUCTO([DESCRIPCION],[ACTIVO]) VALUES ('Golosinas',1);
INSERT INTO TIPOSPRODUCTO([DESCRIPCION],[ACTIVO]) VALUES ('Congelados',1);
INSERT INTO TIPOSPRODUCTO([DESCRIPCION],[ACTIVO]) VALUES ('Refrigerados',1);
INSERT INTO TIPOSPRODUCTO([DESCRIPCION],[ACTIVO]) VALUES ('Snacks',1);
INSERT INTO TIPOSPRODUCTO([DESCRIPCION],[ACTIVO]) VALUES ('Bebidas',1);
INSERT INTO TIPOSPRODUCTO([DESCRIPCION],[ACTIVO]) VALUES ('Galletitas',1);
INSERT INTO TIPOSPRODUCTO([DESCRIPCION],[ACTIVO]) VALUES ('Enlatados',1);
INSERT INTO TIPOSPRODUCTO([DESCRIPCION],[ACTIVO]) VALUES ('No perecederos',1);
INSERT INTO TIPOSPRODUCTO([DESCRIPCION],[ACTIVO]) VALUES ('Frutas',1);
INSERT INTO TIPOSPRODUCTO([DESCRIPCION],[ACTIVO]) VALUES ('Verduras',1);
INSERT INTO TIPOSPRODUCTO([DESCRIPCION],[ACTIVO]) VALUES ('Hongos',1);

INSERT INTO PROVEEDORES([EMPRESA],[CUIT],[ACTIVO]) VALUES ('El Hermano',30215281223,1),('Dos Hermanos',34761241223,1),('Tres Hermanos',32465491217,1),('Cuatro Hermanos',307128535237,1)
INSERT INTO PROVEEDORES([EMPRESA],[CUIT],[ACTIVO]) VALUES ('Cinco Hermanos',32765441223,1),('Seis Hermanos',31767454231,1),('Siete Hermanos',30145421258,1),('Los Hermanos',35765443821,1)

INSERT INTO PRODUCTOS([IDMARCA],[IDTIPOPRODUCTO],[DESCRIPCION],[STOCKMIN],[GANANCIA],[ACTIVO]) VALUES (40000000,50000000,'Alfajor Sabor Mani',24,25,1)         

