using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;
using Negocio;
using System.Web.UI;

namespace Mensajes
{
    static public class Mensajes
    {
        static public void MensajePopUp(Page page, string mensaje)
        {
            ScriptManager.RegisterStartupScript(page, page.GetType(), "alertMenssage", $"alert('{mensaje}');", true);
        }

        static public void MensajePopUp(MasterPage master, string mensaje)
        {
            ScriptManager.RegisterStartupScript(master, master.GetType(), "alertMenssage", $"alert('{mensaje}');", true);
        }

        static public void MensajeConfirmacionBorrado(Page page, string mensaje, string funcionConfirmacion)
        {
            string script = $"if (confirm('{mensaje}')) {{ {funcionConfirmacion} }}";
            ScriptManager.RegisterStartupScript(page, page.GetType(), "confirmDialog", script, true);
        }
    }
}
