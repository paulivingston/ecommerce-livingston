using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;
using Data;

namespace Negocio
{
    public class NegocioMarca
    {
        DatabaseAccess datos = null;
        List<Marca> marcas = null;

        public List<Marca> ListarMarcas()
        {
            datos = new DatabaseAccess();
            try
            {
                datos = new DatabaseAccess();
                marcas = new List<Marca>();

                datos.SetProcedure("sp_ListarMarcas");
                datos.ReadData();

                while (datos.Reader.Read())
                {
                    marcas.Add(new Marca((int)datos.Reader["Id"], datos.Reader["Descripcion"].ToString(), datos.Reader["ImagenUrl"].ToString()));
                }
                return marcas;
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

        public Marca CrearMarca(Marca marca)
        {
            datos = new DatabaseAccess();
            try
            {
                datos.SetProcedure("sp_CrearMarca");
                datos.SetParameter("@Id", marca.Id);
                datos.SetParameter("@descripcion", marca.Descripcion);
                datos.SetParameter("@ImagenUrl", marca.ImagenUrl);

                datos.ExecuteNonQuery();
                return marca;
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

        public Marca ModificarMarca(Marca marca)
        {
            datos = new DatabaseAccess();
            try
            {
                datos.SetProcedure("sp_ModificarMarca");
                datos.SetParameter("@descripcion", marca.Descripcion);
                datos.SetParameter("@ImagenUrl", marca.ImagenUrl);
                datos.SetParameter("@id", marca.Id);

                datos.ExecuteNonQuery();
                return marca;
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
        public void EliminarMarca(int id)
        {
            datos = new DatabaseAccess();
            try
            {
                datos.SetProcedure("sp_EliminarMarca");
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
    }
}
