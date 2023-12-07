use master
go
create database ECOMMERCELIVINGSTON
go
use ECOMMERCELIVINGSTON
go
USE [ECOMMERCELIVINGSTON]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

------------TABLAS------------

CREATE TABLE MARCAS (
	Id INT not null PRIMARY KEY,
	Descripcion varchar(50) not null,
	ImagenUrl VARCHAR(1000)NOT NULL
)

GO

CREATE TABLE CATEGORIAS (
	Id INT not null PRIMARY KEY,
	Descripcion varchar(50) not null,
	ImagenUrl VARCHAR(1000)NOT NULL
)

GO

CREATE TABLE ARTICULOS(
	Id INT PRIMARY KEY NOT NULL,
	Nombre VARCHAR(50) NULL,
	Descripcion VARCHAR(150) NULL,
	IdMarca INT NULL,
	IdCategoria INT NULL,
	ImagenUrl VARCHAR(1000) NULL,
	Precio DECIMAL NULL,
	Estado BIT NOT NULL,
	Stock INT NOT NULL
)

GO

CREATE TABLE IMAGENES(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	IdArticulo INT NULL,
	ImagenUrl VARCHAR(1000)NOT NULL,
)

GO

CREATE TABLE PEDIDOS(
	IdPedido INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	IdUsuarios INT NOT NULL,
	IdArticulos INT NOT NULL,
	Cantidad INT NOT NULL,
	Fecha DATE NOT NULL,
	Estado VARCHAR(20) NOT NULL,
	DireccionEntrega VARCHAR(100) NOT NULL,
	Descuento DECIMAL NULL,
	PrecioTotal DECIMAL NOT NULL
)

GO

CREATE TABLE USUARIOS(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Nombre VARCHAR(30) NOT NULL,
	Apellido VARCHAR(30) NOT NULL,
	DNI INT NOT NULL,
	Mail VARCHAR(30) NOT NULL,
	Clave VARCHAR(30) NOT NULL,
	Direccion VARCHAR(100) NOT NULL,
	Nivel CHAR NOT NULL, -- 0 admin 1 empleado 2 cliente �?
	ImagenUrl VARCHAR (MAX) NOT NULL,
	Activo BIT NOT NULL DEFAULT 1
)

GO

CREATE TABLE PEDIDO_ARTICULO(
	Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	IdPedido INT NOT NULL FOREIGN KEY REFERENCES PEDIDOS (IdPedido),
	IdArticulo INT NOT NULL FOREIGN KEY REFERENCES ARTICULOS (Id),
	Cantidad INT NOT NULL
)

GO

------------FIN TABLAS------------



------------STORE PROCEDURES------------

CREATE PROCEDURE sp_ListarArticulos
AS
BEGIN
	SELECT 
		A.Id AS 'Id', 
		A.Nombre AS 'Nombre', 
		A.Descripcion AS 'Descripcion', 
		A.IdMarca AS 'IdMarca', 
		M.Descripcion AS 'Marca', 
		A.IdCategoria AS 'IdCategoria', 
		C.Descripcion AS 'Categoria', 
		A.Precio AS 'Precio', 
		A.Estado AS 'Estado', 
		A.Stock AS 'Stock', 
		A.ImagenUrl AS 'ImagenUrl' 
	FROM ARTICULOS AS A 
	INNER JOIN MARCAS AS M 
	ON A.IdMarca = M.Id 
	INNER JOIN CATEGORIAS AS C 
	ON A.IdCategoria = C.Id
END 
GO

CREATE PROCEDURE sp_CrearArticulo
@Id int,
@nombre varchar(50),
@descripcion varchar(150),
@idMarca int,
@idCategoria int,
@precio decimal(18,0),
@estado bit,
@stock int,
@imagenUrl varchar(1000)
AS
BEGIN
	INSERT INTO ARTICULOS (
		ID,
		Nombre,
		Descripcion,
		IdMarca,
		IdCategoria,
		Precio,
		Estado,
		Stock,
		ImagenUrl
	) 
	VALUES (
		@Id,
		@nombre,
		@descripcion,
		@idMarca,
		@idCategoria,
		@precio,
		@estado,
		@stock,
		@imagenUrl
	)
END 
GO

CREATE PROCEDURE sp_ModificarArticulo
@id int,
@nombre varchar(50),
@descripcion varchar(150),
@idMarca int,
@idCategoria int,
@precio decimal(18,0),
@estado bit,
@stock int,
@imagenUrl varchar(1000)
AS
BEGIN
	UPDATE ARTICULOS 
	SET 
		Nombre = @nombre, 
		Descripcion = @descripcion, 
		IdMarca = @idMarca, 
		IdCategoria = @idCategoria, 
		Precio = @precio, 
		Estado = @estado, 
		Stock = @stock, 
		ImagenUrl = @imagenUrl 
	WHERE Id = @id
END 
GO

CREATE PROCEDURE sp_EliminarArticulo
@id int
AS 
BEGIN
	DELETE FROM ARTICULOS 
	WHERE Id = @id
END 
GO

CREATE PROCEDURE sp_ListarCategorias
AS
BEGIN
	SELECT 
		Id, 
		Descripcion, 
		ImagenUrl
	FROM CATEGORIAS
END
GO

CREATE PROCEDURE sp_CrearCategoria
@Id int, 
@descripcion varchar(50), 
@ImagenUrl varchar(1000)
AS
BEGIN
	INSERT INTO CATEGORIAS (
		Id, 
		Descripcion, 
		ImagenUrl
	) 
	VALUES (
		@Id, 
		@descripcion, 
		@ImagenUrl
	)
END
GO

CREATE PROCEDURE sp_ModificarCategoria
@id int, 
@descripcion varchar(50), 
@ImagenUrl varchar(1000)
AS
BEGIN
	UPDATE CATEGORIAS 
	SET 
		Descripcion = @descripcion, 
		ImagenUrl = @ImagenUrl 
	WHERE Id = @id
END
GO

CREATE PROCEDURE sp_EliminarCategoria
@id int
AS
BEGIN
	DELETE FROM CATEGORIAS 
	WHERE Id = @id
END
GO

CREATE PROCEDURE sp_ListarMarcas
AS
BEGIN
	SELECT 
		Id, 
		Descripcion, 
		ImagenUrl
	FROM MARCAS
END
GO

CREATE PROCEDURE sp_CrearMarca
@Id int, 
@descripcion varchar(50), 
@ImagenUrl varchar(1000)
AS
BEGIN
	INSERT INTO MARCAS (
		Id, 
		Descripcion, 
		ImagenUrl
	) 
	VALUES (
		@Id, 
		@descripcion, 
		@ImagenUrl
	)
END
GO

CREATE PROCEDURE sp_ModificarMarca
@id int, 
@descripcion varchar(50), 
@ImagenUrl varchar(1000)
AS
BEGIN
	UPDATE MARCAS 
	SET 
		Descripcion = @descripcion, 
		ImagenUrl = @ImagenUrl 
	WHERE Id = @id
END
GO

CREATE PROCEDURE sp_EliminarMarca
@id int
AS
BEGIN
	DELETE FROM MARCAS 
	WHERE Id = @id
END
GO

CREATE PROCEDURE sp_ListarPedidos
AS BEGIN
	SELECT  
		P.IdPedido as 'IDPedido',
		P.IdUsuarios as 'IDUsuario', 
		U.Nombre+' '+U.Apellido as 'Usuario',
		P.Cantidad as 'CantidadArticulos', 
		P.Fecha as 'Fecha',
		P.Estado as 'Estado', 
		P.DireccionEntrega as 'Direccion', 
		P.Descuento as 'Descuento', 
		P.PrecioTotal as 'PrecioTotal'
	FROM PEDIDOS P 
	INNER JOIN USUARIOS U 
	ON P.IdUsuarios = U.Id
END


CREATE PROCEDURE sp_ListarPedidosPorID
@id int
AS BEGIN
	SELECT 
		IdPedido, 
		IdUsuarios,
		U.Nombre+' '+U.Apellido as 'Usuario', 
		Cantidad, 
		Fecha, 
		Estado, 
		DireccionEntrega, 
		Descuento, 
		PrecioTotal 
	FROM PEDIDOS 
	INNER JOIN USUARIOS U 
	ON IdUsuarios = U.Id 
	WHERE IdPedido = @id
END


CREATE PROCEDURE sp_ListarPedidosPorFiltro
@filtro varchar(20)
AS BEGIN
	SELECT 
		IdPedido, 
		IdUsuarios,
		U.Nombre+' '+U.Apellido as 'Usuario', 
		Cantidad, 
		Fecha, 
		Estado, 
		DireccionEntrega, 
		Descuento, 
		PrecioTotal 
	FROM PEDIDOS 
	INNER JOIN USUARIOS U 
	ON IdUsuarios = U.Id 
	WHERE Estado = @filtro
END

CREATE PROCEDURE sp_CrearPedido 
@IdUsuario int,
@Cantidad int,
@Estado varchar(20),
@DireccionEntrega varchar(20),
@Descuento decimal,
@PrecioTotal decimal
AS
BEGIN
	INSERT INTO PEDIDOS (
		IdUsuarios, 
		Cantidad, 
		Fecha, 
		Estado, 
		DireccionEntrega, 
		Descuento, 
		PrecioTotal
		)
	OUTPUT inserted.IdPedido
	VALUES (
		@IdUsuario, 
		@Cantidad, 
		GETDATE(), 
		@Estado, 
		@DireccionEntrega, 
		@Descuento, 
		@PrecioTotal
		)
END
GO


CREATE PROCEDURE sp_ModificarPedido 
@IdPedido int,
@IdUsuario int,
@Cantidad int,
@Fecha date,
@Estado varchar(20),
@DireccionEntrega varchar(20),
@Descuento decimal,
@PrecioTotal decimal
AS
BEGIN
	UPDATE PEDIDOS 
	SET 
		IdUsuarios = @IdUsuario, 
		Cantidad = @Cantidad, 
		Fecha = @Fecha, 
		Estado = @Estado, 
		DireccionEntrega = @DireccionEntrega, 
		Descuento = @Descuento, 
		PrecioTotal = @PrecioTotal 
	WHERE IdPedido = @IdPedido
END
GO

CREATE PROCEDURE sp_EliminarPedido
@id int
AS
BEGIN
	DELETE FROM PEDIDOS 
	WHERE IdPedido = @id
END
GO

CREATE PROCEDURE sp_ModificarEstado
@id int,
@Estado varchar(20)
AS
BEGIN
	UPDATE PEDIDOS 
	SET Estado = @estado 
	WHERE IdPedido = @id
END
GO




------------FIN STORE PROCEDURES------------