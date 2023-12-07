using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Pedido
    {
        public int IdPedido { get; set; }
        public int IdUsuario { get; set; }
        public string Usuario { get; set; }
        public int Cantidad { get; set; }
        public int CantidadTotal { get; set; }
        public DateTime fecha { get; set; }
        public string Estado { get; set; }
        public string DireccionEntrega { get; set; }
        public decimal Descuento { get; set; }
        public decimal precioTotal { get; set; }
        public string PrecioTotal { get { return string.Format("{0:C2}", precioTotal); } }
        public List<ItemCarrito> totalItems { get; set; } 

        public Pedido() { }
        public Pedido(int idPedido, int idUsuario, DateTime fecha, string estado, string direccionEntrega, decimal descuento, decimal total)
        {
            IdPedido = idPedido;
            IdUsuario = idUsuario;
            this.fecha = fecha;
            Estado = estado;
            DireccionEntrega = direccionEntrega;
            Descuento = descuento;
            this.precioTotal = total;
        }
    }
}