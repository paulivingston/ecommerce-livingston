using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Descuento
    {
        public int Id { get; set; }
        public string Codigo { get; set; }
        public int Porcentaje { get; set; }
        public bool Estado { get; set; }

        public Descuento() { }
        public Descuento(int id, string codigo, int porcentaje, bool estado)
        {
            Id = id;
            Codigo = codigo;
            Porcentaje = porcentaje;
            Estado = estado;
        }
    }
}
