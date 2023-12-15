using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Mensajes;
using Negocio;

namespace ecommerce_livingston
{
    public partial class Admin : System.Web.UI.Page
    {
        NegocioPedido NegocioPedido;
        List<Pedido> Pedidos;
        Pedido pedido;
        List<ItemCarrito> ArticulosPedido;
        NegocioUsuario NegocioUsuario;
        List<Usuario> Usuarios;
        Usuario usuario;
        NegocioArticulo NegocioArticulo;
        Articulo articulo;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //falta validacion admin
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        #region OPCIONES MENU


        //pedidos
        private void CargarPedidos()
        {
            NegocioPedido = new NegocioPedido();
            Pedidos = NegocioPedido.ListarPedidos();
            dgvAdminPedidos.DataSource = Pedidos;
            dgvAdminPedidos.DataBind();

            divEstadisticas.Visible = false;
            sectionAdminPedidos.Visible = true;
            sectionAdminPedidosTodos.Visible = true;
            dgvAdminPedidos.Visible = true;
            sectionAdminUsuarios.Visible = false;
        }

        protected void btnPedidosTodos_Click(object sender, EventArgs e)
        {
            CargarPedidos();
        }


        //articulos



        //usuarios
        private void CargarUsuarios()
        {
            NegocioUsuario = new NegocioUsuario();
            Usuarios = NegocioUsuario.ListarUsuarios();
            dgvAdminUsuario.DataSource = Usuarios;
            dgvAdminUsuario.DataBind();

            divEstadisticas.Visible = false;
            sectionAdminPedidos.Visible = false;
            sectionAdminUsuarios.Visible=true;
            lblAdministracionUsuarios.Visible = true;
            filtrosUsuarios.Visible = true;


        }

        protected void btnUsuariosTodos_Click(object sender, EventArgs e)
        {
            CargarUsuarios();
        }

        protected void btnAgregarNuevoUsuario_Click(object sender, EventArgs e)
        {
        }

        #endregion


        #region SUBMENU PEDIDOS
        //submenu pedidos


        private void CargarPedido(Pedido pedido)
        {
            ddlIdUsuarioModificarPedido.DataSource = new NegocioUsuario().ListarUsuarios();
            ddlIdUsuarioModificarPedido.DataTextField = "Id" + ' ' + "Nombre" + ' ' + "Apellido";
            ddlIdUsuarioModificarPedido.DataValueField = "Id";
            ddlIdUsuarioModificarPedido.DataBind();

            if (pedido == null) return;
            txtIdPedidoEditar.Text = pedido.IdPedido.ToString();
            ddlIdUsuarioModificarPedido.SelectedValue = pedido.IdUsuario.ToString();
            txtEstadoModificarPedido.Text = pedido.Estado; //ver de poner ddl con opciones
            txtFechaModificarPedido.Text = pedido.fecha.ToString();
            txtDescuentoModificarPedido.Text = pedido.Descuento.ToString();
            txtTotalModificarPedido.Text = pedido.PrecioTotal;
            txtCantidadTotalModificarPedido.Text = pedido.CantidadTotal.ToString();
        }

        private void CalcularTotalesPedido(List<ItemCarrito> lista)
        {
            decimal nuevoTotal = 0;
            int nuevaCantidad = 0;

            lista.ForEach(itm => nuevoTotal += itm.Cantidad * itm.Precio);
            lista.ForEach(itm => nuevaCantidad += itm.Cantidad);

            if (nuevoTotal < 0) nuevoTotal = 0;

            txtTotalModificarPedido.Text = string.Format("{0:C2}", nuevoTotal);
            txtNuevoTotal.Text = string.Format("{0:C2}", nuevoTotal);
            txtNuevoTotal.Visible = true;
            txtCantidadTotalModificarPedido.Text = nuevaCantidad.ToString();
            dgvArticulosPedido.DataSource = lista;
            dgvArticulosPedido.DataBind();
        }

        protected void btnOrdenarPrecioPedidos_Click(object sender, EventArgs e)
        {
            try
            {
                divEstadisticas.Visible = false;
                NegocioPedido = new NegocioPedido();
                Pedidos = NegocioPedido.ListarPedidos();

                if (((Button)sender).CommandName == "MAYOR")
                    Pedidos = Pedidos.OrderByDescending(itm => itm.precioTotal).ToList();
                else if (((Button)sender).CommandName == "MENOR")
                    Pedidos = Pedidos.OrderBy(itm => itm.precioTotal).ToList();

                dgvAdminPedidos.DataSource = Pedidos;
                dgvAdminPedidos.DataBind();

            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnEstadosPedidosFiltros_Click(object sender, EventArgs e)
        {
            try
            {
                divEstadisticas.Visible = false;
                NegocioPedido = new NegocioPedido();
                Pedidos = NegocioPedido.ListarPedidos();

                string estado = ((Button)sender).CommandName;
                if (estado == "btnIniciado")
                    Pedidos = Pedidos.Where(itm => itm.Estado == "INICIADO").ToList();
                else if (estado == "btnFinalizado")
                    Pedidos = Pedidos.Where(itm => itm.Estado == "FINALIZADO").ToList();
                else if (estado == "btnCancelado")
                    Pedidos = Pedidos.Where(itm => itm.Estado == "CANCELADO").ToList();

                dgvAdminPedidos.DataSource = Pedidos;
                dgvAdminPedidos.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnFiltrosPersonalizados_Click(object sender, EventArgs e)
        {
            try
            {
                divEstadisticas.Visible = false;
                NegocioPedido = new NegocioPedido();
                Pedidos = NegocioPedido.ListarPedidos();

                int idPedidoUser = string.IsNullOrWhiteSpace(txtFiltroIdUser_Pedido.Text) ? 0 : Convert.ToInt32(txtFiltroIdUser_Pedido.Text);
                int idPedido = string.IsNullOrWhiteSpace(txtFiltroIdPedido_Pedido.Text) ? 0 : Convert.ToInt32(txtFiltroIdPedido_Pedido.Text);
                string nombreUser = string.IsNullOrWhiteSpace(txtFiltroNombreUsuario_Pedido.Text) ? string.Empty : txtFiltroNombreUsuario_Pedido.Text;
                DateTime fechaDesde = string.IsNullOrWhiteSpace(txtFiltroFecha.Text) ? DateTime.MinValue : Convert.ToDateTime(txtFiltroFecha.Text);

                if (idPedidoUser != 0)
                    Pedidos.RemoveAll(itm => itm.IdUsuario != idPedidoUser);
                if (idPedido != 0)
                    Pedidos.RemoveAll(itm => itm.IdPedido != idPedido);
                if (nombreUser != string.Empty)
                    Pedidos.RemoveAll(itm => itm.Usuario != nombreUser);
                if (fechaDesde != DateTime.MinValue)
                    Pedidos.RemoveAll(itm => itm.fecha.Date != fechaDesde.Date);

                dgvAdminPedidos.DataSource = Pedidos;
                dgvAdminPedidos.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnLimpiarFiltrosPedidos_Click(object sender, EventArgs e)
        {
            try
            {
                CargarPedidos();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnCancelarTerminarPedido(object sender, EventArgs e)
        {
            int idPedido = int.Parse(((Button)sender).CommandArgument);
            string tipo = ((Button)sender).CommandName;
            if (tipo == "Cancelar")
            {
                try
                {
                    NegocioPedido = new NegocioPedido();
                    NegocioPedido.ModificarEstado(idPedido, "CANCELADO");
                    dgvAdminPedidos.DataSource = NegocioPedido.ListarPedidos();
                    dgvAdminPedidos.DataBind();
                }
                catch (Exception ex)
                {
                    Session.Add("error", ex);
                    Response.Redirect("Error.aspx", false);
                }
            }
            else if (tipo == "Finalizar")
            {
                try
                {
                    NegocioPedido = new NegocioPedido();
                    NegocioPedido.ModificarEstado(idPedido, "FINALIZADO");
                    dgvAdminPedidos.DataSource = NegocioPedido.ListarPedidos();
                    dgvAdminPedidos.DataBind();
                }
                catch (Exception ex)
                {
                    Session.Add("error", ex);
                    Response.Redirect("Error.aspx", false);
                }
            }
        }

        protected void ibtModificarPedido_Click(object sender, EventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(((ImageButton)sender).CommandArgument);
                Session.Add("idPedidoEditar", id);

                //pedido
                NegocioPedido = new NegocioPedido();
                pedido = NegocioPedido.ListarPedidos(id);
                dgvAdminPedido.DataSource = pedido;
                dgvAdminPedido.DataBind();

                //articulos del pedido
                Session.Add("PedidoArticulosListaEdit", NegocioPedido.ListarArticulosPedido(id));
                ArticulosPedido = Session["PedidoArticulosListaEdit"] as List<ItemCarrito>;
                dgvArticulosPedido.DataSource = ArticulosPedido;
                dgvArticulosPedido.DataBind();

                int total = 0;
                ArticulosPedido.ForEach(x => total += x.Cantidad);
                pedido.CantidadTotal = total;
                CargarPedido(pedido);

                ddlAgregarArticuloPedido.DataSource = new NegocioArticulo().ListarArticulos();
                ddlAgregarArticuloPedido.DataTextField = "Nombre";
                ddlAgregarArticuloPedido.DataValueField = "Id";
                ddlAgregarArticuloPedido.DataBind();

                //cambio vistas
                sectionAdminPedidoIndividual.Visible = true;
                sectionAdminPedidosTodos.Visible = false;
                dgvAdminPedido.Visible = true;
                dgvArticulosPedido.Visible = true;
                seccionEditarPedidos.Visible = true;
                accordionPedidoArticulos.Visible = true;
                txtTotalModificarPedido.Enabled = false;
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnAgregarArticuloPedido_Click(object sender, EventArgs e)
        {
            

            if (Session["idPedidoEditar"] == null)
            {
                Session["MensajeError"] = "Ha ocurrido un error al validar la informacion del pedido";
                Response.Redirect("Error.aspx", false);
                return;
            }

            int idPedido = (int)Session["idPedidoEditar"];
            
            int idArticulo = int.Parse(ddlAgregarArticuloPedido.SelectedValue);
            List<ItemCarrito> listaArticulosPedido = Session["PedidoArticulosListaEdit"] as List<ItemCarrito>;

            //si es el primer articulo
            if (listaArticulosPedido == null)
            {
                listaArticulosPedido = new List<ItemCarrito>();
                Session.Add("PedidoArticulosListaEdit", listaArticulosPedido);
            }

            //si el articulo ya existia en la lista
            if (listaArticulosPedido.Find(itm => itm.Id == idArticulo) != null)
            {
                listaArticulosPedido.Find(itm => itm.Id == idArticulo).Cantidad += 1;
            }
            else
            {
            //agregar articulo
                Articulo art = new NegocioArticulo().ListarArticulos(idArticulo);
                ItemCarrito newItem = new ItemCarrito()
                {
                    Id = idArticulo,
                    Cantidad = 1,
                    Nombre = art.Nombre,
                    Categoria = art.Categoria.Descripcion,
                    Descripcion = art.Descripcion,
                    Estado = art.Estado ? "Alta" : "Baja",
                    IdPedido = idPedido,
                    Precio = art.Precio,
                    ImagenUrl = art.ImagenUrl,
                    Marca = art.Marca.Descripcion,
                    Stock = art.Stock,
                };
                listaArticulosPedido.Add(newItem);
            }

            //calculo nuevos totales y asigno
            CalcularTotalesPedido(listaArticulosPedido);
        }

        protected void btnBuscarArticuloPorIDPedido_Click(object sender, EventArgs e)
        {
            try
            {
                int id = int.Parse(txtBuscarArticuloPorIDPedido.Text);
                NegocioArticulo = new NegocioArticulo();
                dgvBuscarArticuloPorIDPedido.DataSource = NegocioArticulo.ListarArticulos(id);
                dgvBuscarArticuloPorIDPedido.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }
        
        protected void btnAgregarArtPedido_Click(object sender, EventArgs e)
        {
            try
            {
                int idArticulo = int.Parse(((ImageButton)sender).CommandArgument);
                List<ItemCarrito> listaArticulosPedido = Session["PedidoArticulosListaEdit"] as List<ItemCarrito>;

                listaArticulosPedido.Find(itm => itm.Id == idArticulo).Cantidad += 1;

                //calculo nuevos totales y asigno
                CalcularTotalesPedido(listaArticulosPedido);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnRestarArtPedido_Click(object sender, EventArgs e)
        {
            int idArticulo = int.Parse(((ImageButton)sender).CommandArgument);
            List<ItemCarrito> listaArticulosPedido = Session["PedidoArticulosListaEdit"] as List<ItemCarrito>;
            
            listaArticulosPedido.Find(itm => itm.Id == idArticulo).Cantidad -= 1; //restamos aca el item
            if (listaArticulosPedido.Find(itm => itm.Id == idArticulo).Cantidad == 0)
            {
                listaArticulosPedido.RemoveAll(itm => itm.Id == idArticulo);
            }

            //calculo nuevos totales y asigno
            CalcularTotalesPedido(listaArticulosPedido);
        }

        protected void btnEliminarArtPedido_Click(object sender, EventArgs e)
        {
            try
            {
                int idArticulo = int.Parse(((ImageButton)sender).CommandArgument);
                List<ItemCarrito> listaArticulosPedido = Session["PedidoArticulosListaEdit"] as List<ItemCarrito>;

                listaArticulosPedido.RemoveAll(itm => itm.Id == idArticulo);

                //calculo nuevos totales y asigno
                CalcularTotalesPedido(listaArticulosPedido);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnConfirmarPedido_Click(object sender, EventArgs e)
        {
            try
            {
                NegocioPedido = new NegocioPedido();
                Pedido pedido = new Pedido();
                
                if (string.IsNullOrWhiteSpace(txtIdPedidoEditar.Text))
                {
                    lblErrorPedidos.Visible = true;
                    lblErrorPedidosText.Text = "Id pedido no puede estar vacio";
                    return;
                }
                if (string.IsNullOrWhiteSpace(txtIdUsuarioModificarPedido.Text))
                {
                    lblErrorPedidos.Visible = true;
                    lblErrorPedidosText.Text = "Id usuario no puede estar vacio";
                    return;
                }
                if (string.IsNullOrWhiteSpace(txtEstadoModificarPedido.Text))
                {
                    lblErrorPedidos.Visible = true;
                    lblErrorPedidosText.Text = "Estado no puede estar vacio";
                    return;
                }
                if (string.IsNullOrWhiteSpace(txtFechaModificarPedido.Text))
                {
                    lblErrorPedidos.Visible = true;
                    lblErrorPedidosText.Text = "Fecha no puede estar vacio";
                    return;
                }
                if (string.IsNullOrWhiteSpace(txtDescuentoModificarPedido.Text) || !txtDescuentoModificarPedido.Text.All(c => char.IsDigit(c) || char.IsNumber(c)))
                {
                    lblErrorPedidos.Visible = true;
                    lblErrorPedidosText.Text = "Descuento no puede estar vacio y tiene que ser un numero";
                    return;
                }
                if (string.IsNullOrWhiteSpace(txtCantidadTotalModificarPedido.Text) || !txtCantidadTotalModificarPedido.Text.All(c => char.IsDigit(c) || char.IsNumber(c)))
                {
                    lblErrorPedidos.Visible = true;
                    lblErrorPedidosText.Text = "Cantidad no puede estar vacio y tiene que ser un numero";
                    return;
                }

                CargarPedido(pedido);
                
                int res = 0;
                //busco sesion actual y error si no existe
                List<ItemCarrito> listaArticulosPedido = Session["PedidoArticulosListaEdit"] as List<ItemCarrito>;
                if (listaArticulosPedido == null)
                {
                    Mensajes.Mensajes.MensajePopUp(this, "No hay articulos en Pedido");
                    return;
                }
                //nuevas cantidades
                int resTotal = listaArticulosPedido.Sum(x => x.Cantidad);
                if (resTotal != pedido.Cantidad)
                {
                    Mensajes.Mensajes.MensajePopUp(this, "Cantidades distintas, verificar");
                }
                //edito pedido
                res = NegocioPedido.ModificarPedido(pedido);

                //elimino y vuelvo a agregar
                for (int i = 0; i < listaArticulosPedido.Count; i++)
                {
                    NegocioPedido.EliminarArticuloPedido(pedido.IdPedido);
                }
                res += NegocioPedido.AgregarArticuloPedido(listaArticulosPedido);

                //respuesta
                if (res >= 1)
                {
                    Mensajes.Mensajes.MensajePopUp(this, "Pedido editado con exito");
                    dgvAdminPedido.DataSource = new NegocioPedido().ListarPedidos(pedido.IdPedido);
                    dgvAdminPedido.DataBind();
                }
                else if (res == 0)
                    Mensajes.Mensajes.MensajePopUp(this, "Ocurrio un error al intentar guardar los cambios");
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnEliminarArticulosPedido_Click(object sender, EventArgs e)
        {
            try
            {
                NegocioPedido = new NegocioPedido();
                int res = NegocioPedido.EliminarPedido((int)Session["idPedidoEditar"]);

                if (res == 1)
                {
                    Session["MensajeExito"] = "Pedido eliminado";
                    CargarPedidos();
                }
                else
                {
                    Mensajes.Mensajes.MensajePopUp(this, "Error al eliminar pedido");
                }
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnVolverListaPedidos_Click(object sender, EventArgs e)
        {
            CargarPedidos();
        }


        /* protected void btnCrearNuevoPedidoMenu_Click(object sender, EventArgs e)
        {
            try
            {
                sectionAdminPedidosTodos.Visible = false;
                divEstadisticas.Visible = false;

                //cargo articulos
                ddlAgregarArticuloPedido.DataSource = new NegocioArticulo().ListarArticulos();
                ddlAgregarArticuloPedido.DataTextField = "Nombre";
                ddlAgregarArticuloPedido.DataValueField = "Id";
                ddlAgregarArticuloPedido.DataBind();

                if (Session["PedidoArticulosListaEdit"] != null)
                    Session.Remove("PedidoArticulosListaEdit");

                accordionPedidoArticulos.Visible = true;

                seccionEditarPedidos.Visible = true;
                lblNuevoPedido.Visible = true;
                lblModificarPedido.Visible = false;
                btnEliminarArticulosPedido.Visible = false;

                txtFechaModificarPedido.Text = DateTime.Now.ToString("yyyy-MM-dd");

                //falta ocultar otros submenu
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }
        */


        #endregion


        #region SUBMENU USUARIOS

        //submenu usuarios


        protected void btnFiltrarEstadoUsuarios_Click(object sender, EventArgs e)
        {
            try
            {
                NegocioUsuario = new NegocioUsuario();
                Usuarios = NegocioUsuario.ListarUsuarios();

                string estado = ((Button)sender).CommandName;
                if (estado == "ACTIVO")
                    Usuarios = Usuarios.Where(itm => itm.Activo).ToList();
                else if (estado == "INACTIVO")
                    Usuarios = Usuarios.Where(itm => !itm.Activo).ToList();

                dgvAdminUsuario.DataSource = Usuarios;
                dgvAdminUsuario.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnFiltrarUsuarios_Click(object sender, EventArgs e)
        {
            try
            {
                CargarUsuarios();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }
        protected void btnLimpiarFiltrosUsuarios_Click(object sender, EventArgs e)
        {
        }

        protected void ibtEditarUsuario_Click(object sender, EventArgs e)
        {
        }

        protected void btnCambiarEstadoUsuario_Click(object sender, EventArgs e)
        {
            //ex alta baja usuario
            //CommandName="BAJA"
        }


        protected void btnEliminarUsuario_Click(object sender, EventArgs e)
        {
        }

        protected void btnGuardarUsuario_Click(object sender, EventArgs e)
        {
        }



        protected void lnkVolverListaUsuarios_Click(object sender, EventArgs e)
        {
        }






        


        #endregion






    }
}