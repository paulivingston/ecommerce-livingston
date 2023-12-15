using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;
using Data;

namespace Negocio
{
    public class NegocioCategoria
    {
        DatabaseAccess datos = null;
        List<Categoria> categorias = null;

        public List<Categoria> ListarCategorias()
        {
            datos = new DatabaseAccess();
            try
            {
                datos = new DatabaseAccess();
                categorias = new List<Categoria>();

                datos.SetProcedure("sp_ListarCategorias");
                datos.ReadData();

                while (datos.Reader.Read())
                {
                    categorias.Add(new Categoria((int)datos.Reader["Id"], datos.Reader["Descripcion"].ToString(), datos.Reader["ImagenUrl"].ToString()));
                }
                return categorias;
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

        public Categoria CrearCategoria(Categoria categoria)
        {
            datos = new DatabaseAccess();
            try
            {
                datos.SetProcedure("sp_CrearCategoria");
                datos.SetParameter("@descripcion", categoria.Descripcion);
                datos.SetParameter("@ImagenUrl", categoria.ImagenUrl);

                datos.ExecuteNonQuery();
                return categoria;
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

        public Categoria ModificarCategoria(Categoria categoria)
        {
            datos = new DatabaseAccess();
            try
            {
                datos.SetProcedure("sp_ModificarCategoria");
                datos.SetParameter("@descripcion", categoria.Descripcion);
                datos.SetParameter("@ImagenUrl", categoria.ImagenUrl);
                datos.SetParameter("@id", categoria.Id);

                datos.ExecuteNonQuery();
                return categoria;
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
        public void EliminarCategoria(int id)
        {
            datos = new DatabaseAccess();
            try
            {
                datos.SetProcedure("sp_EliminarCategoria");
                datos.SetParameter("@id", id);

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

        public int ExisteCategoria(string desc)
        {
            datos = new DatabaseAccess();
            try
            {
                datos.SetProcedure("sp_ExisteCategoria");
                datos.SetParameter("@descripcion", desc);
                datos.ReadData();
                return (int)datos.Reader["Id"];
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
