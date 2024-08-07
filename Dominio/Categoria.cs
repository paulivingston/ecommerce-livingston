﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Categoria
    {
        public int Id { get; set; }
        public string Descripcion { get; set; }
        public string ImagenUrl { get; set; }

        public Categoria() {}
        public Categoria(int id, string descripcion)
        {
            Id = id;
            Descripcion = descripcion;
        }
        public Categoria(int id, string descripcion, string img)
        {
            Id = id;
            Descripcion = descripcion;
            ImagenUrl = img;
        }
    }
}
