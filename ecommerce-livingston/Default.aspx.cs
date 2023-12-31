﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;
using Dominio;
using Mensajes;

namespace ecommerce_livingston
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    guardadoExitoso();
                    NegocioCategoria categoria = new NegocioCategoria();
                    List<Categoria> categorias = categoria.ListarCategorias();
                    rptCategorias.DataSource = categorias;
                    rptCategorias.DataBind();

                    NegocioMarca marca = new NegocioMarca();
                    List<Marca> marcas = marca.ListarMarcas();
                    rptMarcas.DataSource = marcas;
                    rptMarcas.DataBind();
                }
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void guardadoExitoso()
        {
            if (Session["MensajeExito"] != null)
            {
                string mensajeExito = Session["MensajeExito"].ToString();
                Mensajes.Mensajes.MensajePopUp(this, mensajeExito);
                Session.Remove("MensajeExito");
            }
        }
        
        protected void btnImgCategoria_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                var cate = ((ImageButton)sender).CommandArgument;
                Response.Redirect("Productos.aspx?idCate=" + cate, false);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnImgMarca_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                var marca = ((ImageButton)sender).CommandArgument;
                Response.Redirect("Productos.aspx?idMarca=" + marca, false);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }
    }
}