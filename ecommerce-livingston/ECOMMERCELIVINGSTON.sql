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

CREATE PROCEDURE sp_ListarArticulosPorID
@Id int
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
	WHERE A.Id = @id
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

	DELETE FROM PEDIDO_ARTICULO 
	WHERE IdPedido = @Id
END
GO

CREATE PROCEDURE sp_ModificarEstadoPedido
@id int,
@Estado varchar(20)
AS
BEGIN
	UPDATE PEDIDOS 
	SET Estado = @estado 
	WHERE IdPedido = @id
END
GO

CREATE PROCEDURE sp_ListarImgArt
@id int
AS
BEGIN
	SELECT ImagenUrl 
	FROM IMAGENES 
	WHERE IdArticulo = @id
END
GO

CREATE PROCEDURE sp_ListarUsuarios
AS
BEGIN
	SELECT 
		Id, 
		Nombre, 
		Apellido, 
		DNI, 
		Mail, 
		Clave, 
		Direccion, 
		Nivel, 
		ImagenUrl, 
		Activo 
	FROM USUARIOS
END
GO

CREATE PROCEDURE sp_ListarUsuariosPorID
@id int
AS
BEGIN
	SELECT 
		Id, 
		Nombre, 
		Apellido, 
		DNI, 
		Mail, 
		Clave, 
		Direccion, 
		Nivel, 
		ImagenUrl, 
		Activo 
	FROM USUARIOS
	WHERE Id = @id
END
GO

CREATE PROCEDURE sp_ListarUsuariosLogin
@Mail varchar(30)
AS
BEGIN
	SELECT 
		Id, 
		Nombre, 
		Apellido, 
		DNI, 
		Mail, 
		Clave, 
		Direccion, 
		Nivel, 
		ImagenUrl, 
		Activo 
	FROM USUARIOS
	WHERE Mail = @Mail 
END
GO

CREATE PROCEDURE sp_CrearUsuario
@Nombre varchar(30), 
@Apellido varchar(30), 
@DNI int, 
@Mail varchar(30), 
@Clave varchar(30), 
@Direccion varchar(100), 
@Nivel char(1), 
@UrlImagen  varchar(max), 
@Activo bit
AS
BEGIN
	INSERT INTO USUARIOS (
		Nombre, 
		Apellido, 
		DNI, 
		Mail, 
		Clave, 
		Direccion, 
		Nivel, 
		ImagenUrl, 
		Activo
	) 
	VALUES (
		@Nombre, 
		@Apellido, 
		@DNI, 
		@Mail, 
		@Clave, 
		@Direccion, 
		@Nivel, 
		@UrlImagen, 
		@Activo
	)
END
GO

CREATE PROCEDURE sp_ModificarUsuario
@Id int,
@Nombre varchar(30), 
@Apellido varchar(30), 
@DNI int, 
@Mail varchar(30), 
@Clave varchar(30), 
@Direccion varchar(100), 
@Nivel char(1), 
@UrlImagen  varchar(max), 
@Activo bit
AS
BEGIN
	UPDATE USUARIOS 
	SET 
		Nombre = @Nombre, 
		Apellido = @Apellido, 
		DNI = @DNI, 
		Mail = @Mail, 
		Clave = @Clave, 
		Direccion = @Direccion, 
		Nivel = @Nivel, 
		ImagenUrl = @UrlImagen, 
		Activo = @Activo 
	WHERE Id = @Id
END
GO

CREATE PROCEDURE sp_EliminarUsuario
@Id int
AS
BEGIN
	DELETE FROM USUARIOS 
	WHERE Id = @id
END
GO

CREATE PROCEDURE sp_AltaUsuario
@Id int
AS
BEGIN
	UPDATE USUARIOS 
	SET Activo = 1 
	WHERE Id = @id
END
GO

CREATE PROCEDURE sp_BajaUsuario
@Id int
AS
BEGIN
	UPDATE USUARIOS 
	SET Activo = 0 
	WHERE Id = @id
END
GO

CREATE PROCEDURE sp_ComprobarIdUsuario
@id int
AS
BEGIN
	SELECT COUNT(*) 
	FROM USUARIOS 
	WHERE Id = @id
END
GO

CREATE PROCEDURE sp_ListarArticulosPedido
AS
BEGIN
	SELECT 
		IdPedido, 
		IdArticulo, 
		Cantidad 
	FROM PEDIDO_ARTICULO
END
GO

CREATE PROCEDURE sp_ListarArticulosPedidoPorID
@id int
AS
BEGIN
	SELECT 
		IdPedido, 
		IdArticulo, 
		Cantidad 
	FROM PEDIDO_ARTICULO
	WHERE IdPedido = @id
END
GO

CREATE PROCEDURE sp_AgregarArticuloPedido
@IdPedido int,
@IDArticulo int,
@Cantidad int
AS
BEGIN
	INSERT INTO PEDIDO_ARTICULO 
	VALUES (
		@IdPedido, 
		@IdArticulo, 
		@Cantidad
	)
END
GO

CREATE PROCEDURE sp_EditarArticuloPedido
@IdPedido int,
@IDArticulo int,
@Cantidad int
AS
BEGIN
	UPDATE PEDIDO_ARTICULO 
	SET 
		IdArticulo = @IdArticulo, 
		Cantidad = @Cantidad 
	WHERE IdPedido = @IdPedido
END
GO

CREATE PROCEDURE sp_EliminarArticuloPedido
@IdPedido int
AS
BEGIN
	DELETE FROM PEDIDO_ARTICULO 
	WHERE IdPedido = @IdPedido
END
GO

CREATE PROCEDURE sp_CantidadPedidos
AS
BEGIN
	SELECT COUNT(*) AS 'Cantidad'
	FROM PEDIDOS 
	WHERE 
		ESTADO='FINALIZADO' 
		OR ESTADO='INICIADO'
END
GO

CREATE PROCEDURE sp_CantidadPedidosMesAnterior
AS
BEGIN
	SELECT COUNT(*) AS 'Cantidad'
	FROM PEDIDOS 
	WHERE 
		ESTADO='FINALIZADO' 
		OR ESTADO='INICIADO'
		AND MONTH(Fecha)=MONTH(GETDATE())-1
END
GO

CREATE PROCEDURE sp_RecaudacionTotal
AS
BEGIN
	SELECT SUM(PrecioTotal) AS 'Recaudacion'
	FROM PEDIDOS
END
GO

CREATE PROCEDURE sp_RecaudacionPromedio
AS
BEGIN
	SELECT AVG(PrecioTotal) AS 'Recaudacion'
	FROM PEDIDOS
END
GO

CREATE PROCEDURE sp_PedidosCompletados
AS
BEGIN
	select count(*) AS 'Completados'
	from PEDIDOS 
	where Estado ='FINALIZADO'
END
GO

CREATE PROCEDURE sp_PedidosPendientes
AS
BEGIN
	select count(*) AS 'Pendientes'
	from pedidos 
	where Estado='INICIADO'
END
GO

CREATE PROCEDURE sp_CantidadUsuarios
AS
BEGIN
	select count(*) AS 'Usuarios' 
	from USUARIOS 
	where Activo=1
END
GO

CREATE PROCEDURE sp_CantidadArticulos
AS
BEGIN
	select count(*) AS 'Articulos' 
	from ARTICULOS 
	where ESTADO=1
END
GO

CREATE PROCEDURE sp_CantidadMarcas
AS
BEGIN
	select count(*) AS 'Marcas' 
	from MARCAS
END
GO

CREATE PROCEDURE sp_CambiarEstadoArticulo
@id int,
@estado bit
AS
BEGIN
	UPDATE ARTICULOS 
	SET Estado = @estado 
	WHERE Id = @id
END
GO

CREATE PROCEDURE sp_ExisteCategoria
@descripcion varchar(50)
AS
BEGIN
	SELECT Id 
	FROM CATEGORIAS 
	WHERE Descripcion = @descripcion
END
GO





------------FIN STORE PROCEDURES------------



------------DUMMY DATA------------



INSERT INTO [dbo].[CATEGORIAS] ([Id],[Descripcion],[ImagenUrl]) VALUES (0,'SUN','https://www.masvision.com.ar/cdn/shop/files/VULKGENIEMBLKGREENEMERALD_800x_5a25ed4d-aacd-488e-b6b0-c432016884b6_800x503.jpg?v=1699153586')
INSERT INTO [dbo].[CATEGORIAS] ([Id],[Descripcion],[ImagenUrl]) VALUES (1,'OPTICS','https://www.masvision.com.ar/cdn/shop/products/PCDA_Hazel_col01_RX_Frente_870x574.jpg?v=1674487566')
INSERT INTO [dbo].[CATEGORIAS] ([Id],[Descripcion],[ImagenUrl]) VALUES (2,'CONTACTS','https://www.masvision.com.ar/cdn/shop/products/Air-Optix-Plus-Hydraglyde-multifocal-550x440_550x440.jpg?v=1701444968')
INSERT INTO [dbo].[CATEGORIAS] ([Id],[Descripcion],[ImagenUrl]) VALUES (3,'GOGGLES','https://acdn.mitiendanube.com/stores/600/169/products/ziro-c2-vista-2_final1-7bc2b67baf1b98968d16527473812183-480-0.webp')

INSERT INTO [dbo].[MARCAS] ([Id],[Descripcion],[ImagenUrl]) VALUES (0,'Ray-Ban','https://www.masvision.com.ar/cdn/shop/files/marca_Ray-Ban_small.png?v=1697029603')
INSERT INTO [dbo].[MARCAS] ([Id],[Descripcion],[ImagenUrl]) VALUES (1,'Vulk','https://www.masvision.com.ar/cdn/shop/files/marca_Vulk_small.png?v=1697029603')
INSERT INTO [dbo].[MARCAS] ([Id],[Descripcion],[ImagenUrl]) VALUES (2,'Vogue','https://www.masvision.com.ar/cdn/shop/files/marca_Vogue_small.png?v=1697029603')
INSERT INTO [dbo].[MARCAS] ([Id],[Descripcion],[ImagenUrl]) VALUES (3,'Oakley','https://www.masvision.com.ar/cdn/shop/files/marca_Oakley_small.png?v=1697029603')
INSERT INTO [dbo].[MARCAS] ([Id],[Descripcion],[ImagenUrl]) VALUES (4,'Rusty','https://www.masvision.com.ar/cdn/shop/files/marca_Rusty_small.png?v=1697029603')

INSERT INTO [dbo].[USUARIOS] ([Nombre],[Apellido],[DNI],[Mail],[Clave],[Direccion],[Nivel],[ImagenUrl],[Activo]) VALUES ('Pepe','Pepa',11111111,'pepe.pepa@gmail.com','password1','donde vive pepe 123','N','https://dthezntil550i.cloudfront.net/f4/latest/f41908291942413280009640715/1280_960/1b2d9510-d66d-43a2-971a-cfcbb600e7fe.png',1)
INSERT INTO [dbo].[USUARIOS] ([Nombre],[Apellido],[DNI],[Mail],[Clave],[Direccion],[Nivel],[ImagenUrl],[Activo]) VALUES ('Pepito','Admin',11111111,'pepito.admin@gmail.com','password2','donde vive pepito 456','A','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwD5S3sw60LDdyNbWwv0Od9IBWQ1vYaAMLEmwizhyb-8HkWJsB5tU2F7ljmaRyfzArkq4&usqp=CAU',1)

INSERT INTO [dbo].[ARTICULOS] ([Id],[Nombre],[Descripcion],[IdMarca],[IdCategoria],[ImagenUrl],[Precio],[Estado],[Stock]) 
VALUES (0,'Anteojos de Sol Rusty Bruk Sblk Polarizado S10','Género: Unisex
Color del Armazón: Negro brillante
Color y Tipo del Lente: negro uniforme polarizado
Material: Acetato
Estilo: Cuadrado',4,0,'https://www.masvision.com.ar/cdn/shop/files/BRUKSBLK-POLS10FRENTE_869x576.jpg?v=1683294063',50000,1,500)
INSERT INTO [dbo].[ARTICULOS] ([Id],[Nombre],[Descripcion],[IdMarca],[IdCategoria],[ImagenUrl],[Precio],[Estado],[Stock]) 
VALUES (1,'Anteojos de Sol Vulk Arvin Mdblu Revo Blue','Género: Hombre
Color del Armazón: Azul marino
Color y Tipo del Lente: Celeste espejado
Material: Acetato 
Estilo: Cuadrado',1,0,'https://www.masvision.com.ar/cdn/shop/files/ArvinMDBLUREVOBLUEF_870x580.jpg?v=1683207183',52000,1,500)
INSERT INTO [dbo].[ARTICULOS] ([Id],[Nombre],[Descripcion],[IdMarca],[IdCategoria],[ImagenUrl],[Precio],[Estado],[Stock]) 
VALUES (2,'Anteojos de Sol Vulk Boston Mblk Revo Red','Género: Unisex
Color del Armazón: Negro mate
Color y Tipo del Lente: Rojo Degrade
Material: Acetato
Estilo: Cuadrado',1,0,'https://www.masvision.com.ar/cdn/shop/files/BOSTON-MBLK-REVO-RED---FRENTE--PRINCIPAL-WEB_869x427.jpg?v=1683208233',55000,1,300)
INSERT INTO [dbo].[ARTICULOS] ([Id],[Nombre],[Descripcion],[IdMarca],[IdCategoria],[ImagenUrl],[Precio],[Estado],[Stock]) 
VALUES (3,'Anteojos de Sol Rusty Ant Ul C3 Revo Blue','Género: Unisex
Color del Armazón: Negro
Color y Tipo del Lente: Azul Espejado
Material: Metal y Acetato
Estilo: Redondo',4,0,'https://www.masvision.com.ar/cdn/shop/files/UL---C3---PERFIL_871x428.jpg?v=1683204061',36000,1,5)
INSERT INTO [dbo].[ARTICULOS] ([Id],[Nombre],[Descripcion],[IdMarca],[IdCategoria],[ImagenUrl],[Precio],[Estado],[Stock]) 
VALUES (4,'Anteojos de Sol Rusty Marilyn 23 Sblk 940','Género: Unisex
Color del Armazón: Negro
Color y Tipo del Lente: verde oscuro
Material: Acetato
Estilo: Envolvente ovalado',4,0,'https://www.masvision.com.ar/cdn/shop/products/MARILYN23AGALERIA-WEB-SBLK-940_871x428.jpg?v=1674065465',46000,1,50)

------------FIN DUMMY DATA------------