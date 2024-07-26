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
    public partial class MisPedidos : System.Web.UI.Page
    {
        NegocioPedido NegocioPedido;
        List<Pedido> Pedidos;
        Pedido pedido;
        List<ItemCarrito> ArticulosPedido;
        NegocioUsuario NegocioUsuario;
        int idUsuario;

        protected void Page_Load(object sender, EventArgs e)
        {
            //obtengo el usuario
            NegocioUsuario = new NegocioUsuario();
            Usuario user = Session["usuarioActual"] as Usuario;

            if (!NegocioUsuario.IsLogged(user))
            {
                Mensajes.Mensajes.MensajePopUp(this, "No tiene las credenciales para entrar o No te encuentras logeado");
                Response.Redirect("Default.aspx", false);
                return;
            }

            idUsuario = user.Id;

            CargarPedidos();
        }

        private void CargarPedidos()
        {
            NegocioPedido = new NegocioPedido();
            Pedidos = NegocioPedido.ListarPedidosPorUsuario(idUsuario);

            if (Pedidos != null && Pedidos.Count > 0)
            {
                dgvPedidosUsuario.DataSource = Pedidos;
                dgvPedidosUsuario.DataBind();

                panelPedidosUsuario.Visible = true;
                seccionVerPedidoUsuario.Visible = false;
                dgvArticulosPedido.Visible = false;
                divSinPedidos.Visible = false;
            }
            else
            {
                divSinPedidos.Visible = true;
                panelPedidosUsuario.Visible = false;
                seccionVerPedidoUsuario.Visible = false;
                dgvArticulosPedido.Visible = false;
            }
                
        }

        private void CargarPedido(Pedido pedido)
        {
            if (pedido == null) return;
            txtIdUsuarioModificarPedido.Text = pedido.IdUsuario.ToString();
            txtEstadoModificarPedido.Text = pedido.Estado; 
            txtFechaModificarPedido.Text = pedido.fecha.ToString();
            txtDescuentoModificarPedido.Text = pedido.Descuento.ToString();
            txtCantidadTotalModificarPedido.Text = pedido.CantidadTotal.ToString();
            txtTotalModificarPedido.Text = pedido.PrecioTotal.ToString();
        }


        protected void btnOrdenarPrecioPedidos_Click(object sender, EventArgs e)
        {
            try
            {
                CargarPedidos();
                NegocioPedido = new NegocioPedido();
                Pedidos = NegocioPedido.ListarPedidosPorUsuario(idUsuario);

                if (int.TryParse(txtFiltroIdPedido_Pedido.Text, out int idPedido)) Pedidos.RemoveAll(itm => itm.IdPedido != idPedido);
                if (DateTime.TryParse(txtFiltroFechaDesde.Text, out DateTime fechaDesde) && !string.IsNullOrWhiteSpace(txtFiltroFechaDesde.Text)) Pedidos.RemoveAll(itm => itm.fecha.Date < fechaDesde.Date);
                if (DateTime.TryParse(txtFiltroFechaHasta.Text, out DateTime fechaHasta) && !string.IsNullOrWhiteSpace(txtFiltroFechaHasta.Text)) Pedidos.RemoveAll(itm => itm.fecha.Date > fechaHasta.Date);

                if (((Button)sender).CommandName == "MAYOR")
                    Pedidos = Pedidos.OrderByDescending(itm => itm.precioTotal).ToList();
                else if (((Button)sender).CommandName == "MENOR")
                    Pedidos = Pedidos.OrderBy(itm => itm.precioTotal).ToList();

                dgvPedidosUsuario.DataSource = Pedidos;
                dgvPedidosUsuario.DataBind();

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
                CargarPedidos();
                NegocioPedido = new NegocioPedido();
                Pedidos = NegocioPedido.ListarPedidosPorUsuario(idUsuario);

                if (int.TryParse(txtFiltroIdPedido_Pedido.Text, out int idPedido)) Pedidos.RemoveAll(itm => itm.IdPedido != idPedido);
                if (DateTime.TryParse(txtFiltroFechaDesde.Text, out DateTime fechaDesde) && !string.IsNullOrWhiteSpace(txtFiltroFechaDesde.Text)) Pedidos.RemoveAll(itm => itm.fecha.Date < fechaDesde.Date);
                if (DateTime.TryParse(txtFiltroFechaHasta.Text, out DateTime fechaHasta) && !string.IsNullOrWhiteSpace(txtFiltroFechaHasta.Text)) Pedidos.RemoveAll(itm => itm.fecha.Date > fechaHasta.Date);

                string estado = ((Button)sender).CommandName;
                if (estado == "btnIniciado")
                    Pedidos = Pedidos.Where(itm => itm.Estado == "INICIADO").ToList();
                else if (estado == "btnTerminado")
                    Pedidos = Pedidos.Where(itm => itm.Estado == "FINALIZADO").ToList();
                else if (estado == "btnCancelado")
                    Pedidos = Pedidos.Where(itm => itm.Estado == "CANCELADO").ToList();

                dgvPedidosUsuario.DataSource = Pedidos;
                dgvPedidosUsuario.DataBind();
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
                CargarPedidos();
                NegocioPedido = new NegocioPedido();
                Pedidos = NegocioPedido.ListarPedidosPorUsuario(idUsuario);

                if (int.TryParse(txtFiltroIdPedido_Pedido.Text, out int idPedido)) Pedidos.RemoveAll(itm => itm.IdPedido != idPedido);
                if (DateTime.TryParse(txtFiltroFechaDesde.Text, out DateTime fechaDesde) && !string.IsNullOrWhiteSpace(txtFiltroFechaDesde.Text)) Pedidos.RemoveAll(itm => itm.fecha.Date < fechaDesde.Date);
                if (DateTime.TryParse(txtFiltroFechaHasta.Text, out DateTime fechaHasta) && !string.IsNullOrWhiteSpace(txtFiltroFechaHasta.Text)) Pedidos.RemoveAll(itm => itm.fecha.Date > fechaHasta.Date);

                dgvPedidosUsuario.DataSource = Pedidos;
                dgvPedidosUsuario.DataBind();
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
                txtFiltroIdPedido_Pedido.Text = "";
                txtFiltroFechaDesde.Text = "";
                txtFiltroFechaHasta.Text = "";
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
                    dgvPedidosUsuario.DataSource = NegocioPedido.ListarPedidosPorUsuario(idUsuario);
                    dgvPedidosUsuario.DataBind();
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
                int id = Convert.ToInt32(((Button)sender).CommandArgument);
                Session.Add("idPedidoEditar", id);

                //pedido
                NegocioPedido = new NegocioPedido();
                pedido = NegocioPedido.ListarPedidos(id);

                //articulos del pedido
                Session.Add("PedidoArticulosListaEdit", NegocioPedido.ListarArticulosPedido(id));
                ArticulosPedido = Session["PedidoArticulosListaEdit"] as List<ItemCarrito>;
                dgvArticulosPedido.DataSource = ArticulosPedido;
                dgvArticulosPedido.DataBind();

                //Calculo Cantidad total de Articulos del Pedido
                int total = 0;
                ArticulosPedido.ForEach(x => total += x.Cantidad);
                pedido.CantidadTotal = total;

                CargarPedido(pedido);

                lblModificarPedido.Text = "Detalle Pedido N° " + id.ToString();

                //calculo importe
                decimal nuevoTotal = 0;
                ArticulosPedido.ForEach(itm => nuevoTotal += itm.Cantidad * itm.Precio);
                txtNuevoTotal.Text = string.Format("{0:C2}", nuevoTotal);

                //cambio vistas
                panelPedidosUsuario.Visible = false;
                seccionVerPedidoUsuario.Visible = true;
                dgvArticulosPedido.Visible = true;
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnVolverMisPedidos_Click(object sender, EventArgs e) 
        {
            CargarPedidos();
        }
        
    }
}