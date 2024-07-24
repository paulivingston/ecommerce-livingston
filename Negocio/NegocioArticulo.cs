using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;
using Data;
using System.Data.SqlTypes;

namespace Negocio
{
    public class NegocioArticulo
    {
        DatabaseAccess datos = null;
        List<Articulo> Articulos = null;

        public List<Categoria> categorias;
        public List<Marca> marcas;

        
        public List<Articulo> ListarArticulos()
        {
            datos = new DatabaseAccess();
            Articulos = new List<Articulo>();
            Articulo articulo;

            try
            {
                datos.SetProcedure("sp_ListarArticulos");
                datos.ReadData();
                
                while (datos.Reader.Read())
                {
                    articulo = new Articulo();
                    articulo.Id = (int)datos.Reader["Id"];
                    articulo.Nombre = datos.Reader["Nombre"].ToString();
                    articulo.Descripcion = datos.Reader["Descripcion"].ToString();

                    articulo.Marca.Id = (int)datos.Reader["IdMarca"];
                    articulo.Marca.Descripcion = datos.Reader["Marca"].ToString();

                    articulo.Categoria.Id = (int)datos.Reader["IdCategoria"];
                    articulo.Categoria.Descripcion = datos.Reader["Categoria"].ToString();

                    articulo.Precio = (decimal)datos.Reader["Precio"];
                    articulo.Estado = (bool)datos.Reader["Estado"];
                    articulo.Stock = (int)datos.Reader["Stock"];
                    articulo.ImagenUrl = datos.Reader["ImagenUrl"].ToString();

                    Articulos.Add(articulo);
                }
                return Articulos;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CloseConnection();
            }
        }

        public List<Articulo> ListarArticulosActivos()
        {
            datos = new DatabaseAccess();
            Articulos = new List<Articulo>();
            Articulo articulo;

            try
            {
                datos.SetProcedure("sp_ListarArticulosActivos");
                datos.ReadData();

                while (datos.Reader.Read())
                {
                    articulo = new Articulo();
                    articulo.Id = (int)datos.Reader["Id"];
                    articulo.Nombre = datos.Reader["Nombre"].ToString();
                    articulo.Descripcion = datos.Reader["Descripcion"].ToString();

                    articulo.Marca.Id = (int)datos.Reader["IdMarca"];
                    articulo.Marca.Descripcion = datos.Reader["Marca"].ToString();

                    articulo.Categoria.Id = (int)datos.Reader["IdCategoria"];
                    articulo.Categoria.Descripcion = datos.Reader["Categoria"].ToString();

                    articulo.Precio = (decimal)datos.Reader["Precio"];
                    articulo.Stock = (int)datos.Reader["Stock"];
                    articulo.ImagenUrl = datos.Reader["ImagenUrl"].ToString();

                    Articulos.Add(articulo);
                }
                return Articulos;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CloseConnection();
            }
        }

        public Articulo ListarArticulos(int id)
        {
            datos = new DatabaseAccess();
            Articulo articulo = new Articulo();

            try
            {
                datos.SetProcedure("sp_ListarArticulosPorID");
                datos.SetParameter("@Id", id);
                datos.ReadData();

                while (datos.Reader.Read())
                {
                    articulo.Id = (int)datos.Reader["Id"];
                    articulo.Nombre = datos.Reader["Nombre"].ToString();
                    articulo.Descripcion = datos.Reader["Descripcion"].ToString();

                    articulo.Marca.Id = (int)datos.Reader["IdMarca"];
                    articulo.Marca.Descripcion = datos.Reader["Marca"].ToString();

                    articulo.Categoria.Id = (int)datos.Reader["IdCategoria"];
                    articulo.Categoria.Descripcion = datos.Reader["Categoria"].ToString();

                    articulo.Precio = (decimal)datos.Reader["Precio"];
                    articulo.Estado = (bool)datos.Reader["Estado"];
                    articulo.Stock = (int)datos.Reader["Stock"];
                    articulo.ImagenUrl = datos.Reader["ImagenUrl"].ToString();
                }
                return articulo;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CloseConnection();
            }
        }

        public int CrearArticulo(Articulo articulo)
        {
            DatabaseAccess datos = new DatabaseAccess();
            try
            {
                datos.SetProcedure("sp_CrearArticulo");
                datos.SetParameter("@Id", articulo.Id);
                datos.SetParameter("@nombre", articulo.Nombre);
                datos.SetParameter("@descripcion", articulo.Descripcion);
                datos.SetParameter("@idMarca", articulo.Marca.Id);
                datos.SetParameter("@idCategoria", articulo.Categoria.Id);
                datos.SetParameter("@precio", articulo.Precio);
                datos.SetParameter("@estado", articulo.Estado);
                datos.SetParameter("@stock", articulo.Stock);
                datos.SetParameter("@imagenUrl", articulo.ImagenUrl);

                datos.ExecuteNonQuery();

                return 1;
            }
            catch
            {
                return 0;
            }
            finally
            {
                datos.CloseConnection();
            }
        }

        public int ModificarArticulo(Articulo articulo)
        {
            datos = new DatabaseAccess();
            try
            {
                datos.SetProcedure("sp_ModificarArticulo");
                datos.SetParameter("@id", articulo.Id);
                datos.SetParameter("@nombre", articulo.Nombre);
                datos.SetParameter("@descripcion", articulo.Descripcion);
                datos.SetParameter("@idMarca", articulo.Marca.Id);
                datos.SetParameter("@idCategoria", articulo.Categoria.Id);
                datos.SetParameter("@precio", articulo.Precio);
                datos.SetParameter("@estado", articulo.Estado);
                datos.SetParameter("@stock", articulo.Stock);
                datos.SetParameter("@imagenUrl", articulo.ImagenUrl);

                datos.ExecuteNonQuery();

                return 1;
            }
            catch
            {
                return 0;
            }
            finally
            {
                datos.CloseConnection();
            }
        }

        public int EliminarArticulo(int idArticulo)
        {
            datos = new DatabaseAccess();
            try
            {
                datos.SetProcedure("sp_EliminarArticulo");
                datos.SetParameter("@id", idArticulo);

                datos.ExecuteNonQuery();

                return 1;
            }
            catch
            {
                return 0;
            }
            finally
            {
                datos.CloseConnection();
            }
        }
    
        public List<string> ListarImgArt(int id)
        {
            datos = new DatabaseAccess();
            List<string> img = new List<string>();

            try
            {
                datos.SetProcedure("sp_ListarImgArt");
                datos.SetParameter("@id", id);
                datos.ReadData();

                while (datos.Reader.Read())
                {
                    img.Add(datos.Reader["ImagenUrl"].ToString());
                }
                return img;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CloseConnection();
            }
        }

        public int CambiarEstado(int id, bool estado)
        {
            datos = new DatabaseAccess();
            try
            {
                datos.SetProcedure("sp_CambiarEstadoArticulo");
                SqlBoolean sqlBoolEstado = estado;
                datos.SetParameter("@estado", sqlBoolEstado);
                datos.SetParameter("@id", id);

                datos.ExecuteNonQuery();

                return 1;
            }
            catch 
            {
                return 0;
            }
            finally
            {
                datos.CloseConnection();
            }
        }

    }
}
