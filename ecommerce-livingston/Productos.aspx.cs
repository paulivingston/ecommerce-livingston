﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Negocio;

namespace ecommerce_livingston
{
    public partial class Productos : System.Web.UI.Page
    {
        NegocioCategoria NegocioCategoria;
        NegocioMarca NegocioMarca;
        NegocioItemCarrito items;
        Articulo articulo;
        ItemCarrito item;
        public int CountCarrito { get; set; } = 0;
        public string Filtro { get; set; } = string.Empty;


        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    List<Articulo> listaArticulos;
                    cargarFiltros();

                    if (Session["listaCarrito"] == null)
                        Session.Add("listaCarrito", new NegocioItemCarrito());

                    if (Session["listaPrincipal"] == null)
                        Session.Add("listaPrincipal", new NegocioArticulo().ListarArticulosActivos());

                    if (Session["listaFiltrada"] == null)
                        Session.Add("listaFiltrada", new List<Articulo>());

                    if (Request.Params["idCategoria"] != null)
                    {
                        listaArticulos = filtrarLista(int.Parse(Request.Params["idCategoria"]), "idCategoria");
                        Filtro = listaArticulos[0]?.Categoria.Descripcion;
                    }
                    else if (Request.Params["idMarca"] != null)
                    {
                        listaArticulos = filtrarLista(int.Parse(Request.Params["idMarca"]), "idMarca");
                        Filtro = listaArticulos[0]?.Marca.Descripcion;
                    }
                    else if (Request.Params["text"] != null)
                    {
                        listaArticulos = filtrarLista(Request.Params["text"]);
                        Filtro = Request.Params["text"].ToString();
                    }
                    else
                    {
                        listaArticulos = (List<Articulo>)Session["ListaPrincipal"];
                        Filtro = "";
                    }
                    repArticulos.DataSource = listaArticulos;
                    repArticulos.DataBind();

                    CantidadCarrito();
                }
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx");
            }
        }

        private void cargarFiltros()
        {
            NegocioMarca = new NegocioMarca();
            NegocioCategoria = new NegocioCategoria();

            ddlFiltroCategoria.DataSource = NegocioCategoria.ListarCategorias();
            ddlFiltroCategoria.DataValueField = "Id";
            ddlFiltroCategoria.DataTextField = "Descripcion";
            ddlFiltroCategoria.DataBind();

            ddlFiltroMarca.DataSource = NegocioMarca.ListarMarcas();
            ddlFiltroMarca.DataValueField = "Id";
            ddlFiltroMarca.DataTextField = "Descripcion";
            ddlFiltroMarca.DataBind();
        }


        private List<Articulo> filtrarLista(object filtro, string tipoFiltro = null)
        {
            try
            {
                if (Session["listaPrincipal"] == null)
                    return null;

                List<Articulo> listaPrincipal = (List<Articulo>)Session["listaPrincipal"];
                List<Articulo> listaFiltrada = (List<Articulo>)Session["listaFiltrada"];

                if (filtro is string)
                {
                    string item = filtro as string;
                    listaFiltrada = listaPrincipal.FindAll(
                        x => (x.Nombre.ToUpperInvariant().Contains(item.ToUpperInvariant()) ||
                        x.Marca.Descripcion.ToUpperInvariant().Contains(item.ToUpperInvariant()))
                        );
                }
                else if (filtro is int)
                {
                    int item = (int)filtro;

                    if (tipoFiltro == "idCategoria")
                        listaFiltrada = listaPrincipal.FindAll(art => art.Categoria.Id == item);
                    else if (tipoFiltro == "idMarca")
                        listaFiltrada = listaPrincipal.FindAll(art => art.Marca.Id == item);
                }
                return listaFiltrada;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void CantidadCarrito()
        {
            if (Session["countCarrito"] == null) Session.Add("countCarrito", 0);
            int count = 0;

            if (Session["listaCarrito"] != null)
            {
                var itemList = ((NegocioItemCarrito)Session["listaCarrito"]).Items;
                foreach (var item in itemList) count += item.Cantidad;
            }

            Session["countCarrito"] = count;

            SiteMaster masterPage = (SiteMaster)Master;
            if (count > 0)
            {
                Label lblcantidad = (Label)Master.FindControl("lblTotalArticulos");
                if (lblcantidad != null)
                {
                    lblcantidad.Text = count.ToString();
                    masterPage.Flag = true;
                }
            }
            else
            {
                masterPage.Flag = false;
            }
        }

        protected void btnFiltro_Click(object sender, EventArgs e)
        {
            if (Session["listaPrincipal"] == null)
                Session.Add("listaPrincipal", new NegocioArticulo().ListarArticulos());

            List<Articulo> listaPrincipal = (List<Articulo>)Session["listaPrincipal"];

            try
            {
                string cat = ddlFiltroCategoria.SelectedValue;
                string mrc = ddlFiltroMarca.SelectedValue;

                if(!(string.IsNullOrEmpty(cat) && string.IsNullOrEmpty(mrc)))
                {
                    if (string.IsNullOrEmpty(cat))
                    {
                        listaPrincipal = listaPrincipal.FindAll(x =>
                            x.Marca.Id.ToString() == mrc);
                    }
                    else if (string.IsNullOrEmpty(mrc))
                    {
                        listaPrincipal = listaPrincipal.FindAll(x =>
                            x.Categoria.Id.ToString() == cat);
                    }
                    else
                    {
                        listaPrincipal = listaPrincipal.FindAll(x =>
                            x.Categoria.Id.ToString() == cat
                            && x.Marca.Id.ToString() == mrc);
                    }
                    repArticulos.DataSource = listaPrincipal;
                    repArticulos.DataBind();
                }
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx");
            }
        }

        protected void btnEliminarFilros_Click(object sender, EventArgs e)
        {
            Session.Remove("listaFiltrada");
            Response.Redirect("Productos.aspx", false);
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            try
            {
                int itemId = int.Parse((sender as Button).CommandArgument);
                item = new ItemCarrito();


                List<Articulo> list = Session["listaPrincipal"] as List<Articulo>;
                NegocioItemCarrito carrito = Session["listaCarrito"] as NegocioItemCarrito;
                ItemCarrito itemMatch = carrito.Items.Find(itm => itm.Id == itemId);

                articulo = list.Find(art => art.Id == itemId);

                int stock = 0;
                if (itemMatch != null) {
                    stock = articulo.Stock - itemMatch.Cantidad;
                } else {
                    stock = articulo.Stock;
                }

                if (articulo != null && stock>0)
                {
                    item.Id = itemId;
                    item.Nombre = articulo.Nombre;
                    item.Precio = articulo.Precio;
                    item.ImagenUrl = articulo.ImagenUrl;
                    item.Cantidad = 1;
                    carrito.AgregarItem(item);

                    //Session["countCarrito"] = Convert.ToInt32(Session["countCarrito"]) + 1;
                    //Label lblTotalArticulos = (Label)Master.FindControl("lblTotalArticulos");
                    //lblTotalArticulos.Text = Session["countCarrito"].ToString();
                    //SiteMaster masterPage = (SiteMaster)Master;
                    //masterPage.Flag = true;

                    Mensajes.Mensajes.MensajePopUp(this, "Articulo agregado el carrito");
                }
                else
                {
                    Mensajes.Mensajes.MensajePopUp(this, "No disponemos de más unidades de este artículo");
                    return;
                }

                CantidadCarrito();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx");
            }
        }

        protected void btnDetalles_Click(object sender, EventArgs e)
        {
            int id = int.Parse(((Button)sender).CommandArgument);

            Response.Redirect("Detalle.aspx?idProd=" + id, false);
        }

    }
}