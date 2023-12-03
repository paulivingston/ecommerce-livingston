using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Articulo
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public Marca Marca { get; set; }
        public Categoria Categoria { get; set; }
        public decimal Precio { get; set; }
        public bool Estado { get; set; } 
        public int Stock { get; set; }
        public string ImagenUrl { get; set; }

        public Articulo()
        {
            Marca = new Marca();
            Categoria = new Categoria();
        }
        public Articulo(int id, string nombre, string descripcion, Marca marca, Categoria categoria, decimal precio, bool estado, int stock)
        {
            Id = id;
            Nombre = nombre;
            Descripcion = descripcion;
            Marca = marca;
            Categoria = categoria;
            Precio = precio;
            Estado = estado;
            Stock = stock;
        }
    }
}
