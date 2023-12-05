using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Negocio
{
    public class NegocioItemCarrito
    {
        public List<ItemCarrito> Items { get; set; }

        public NegocioItemCarrito()
        {
            Items = new List<ItemCarrito>();
        }

        public void AgregarItem(ItemCarrito item)
        {
            ItemCarrito itemExistente = Items.FirstOrDefault(it => it.Id == item.Id);
            if (itemExistente != null) //si esta
            {
                itemExistente.Cantidad += item.Cantidad;
            }
            else //si no esta
            {
                Items.Add(item);
            }
        }

        public void ModificarCantidad(int id, int cantidad)
        {
            ItemCarrito item = Items.FirstOrDefault(it => it.Id == id);
            if (item != null)
            {
                item.Cantidad = cantidad;
            }
        }

        public void EliminarItem(int id)
        {
            ItemCarrito item = Items.FirstOrDefault(it => it.Id == id);
            if (item != null)
            {
                Items.Remove(item);
            }
        }
    }
}
