﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;
using Data;

namespace Negocio
{
    public class NegocioArticulo
    {
        DatabaseAccess datos = null;
        List<Articulo> Articulos = null;
        List<string> imagenes = null;
        Articulo articulo;
        public List<Categoria> categorias;
        public List<Marca> marcas;
        public List<int> idMarcas;

        
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

        public void CrearArticulo(Articulo articulo)
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

        public void ModificarArticulo(Articulo articulo)
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

        public void EliminarArticulo(int idArticulo)
        {
            datos = new DatabaseAccess();
            try
            {
                datos.SetProcedure("sp_EliminarArticulo");
                datos.SetParameter("@id", idArticulo);

                datos.ExecuteNonQuery();
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

    }
}