using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.Mail;
using System.Net;

namespace Negocio
{
    public class EmailService
    {
        private MailMessage mensaje;
        private SmtpClient servicioCorreo;

        public EmailService()
        {
            servicioCorreo = new SmtpClient();
            servicioCorreo.Credentials = new NetworkCredential("ojodeaguilaglasses@hotmail.com", "OjoDeAguila");
            servicioCorreo.EnableSsl = true;
            servicioCorreo.Host = "smtp.office365.com";
            servicioCorreo.Port = 587;
        }

        public void ArmarCorreo(string destinatario, string asunto, string contenido)
        {
            try
            {
                mensaje = new MailMessage();
                mensaje.From = new MailAddress("ojodeaguilaglasses@hotmail.com");
                mensaje.To.Add(destinatario);
                mensaje.Subject = asunto;
                mensaje.Body = contenido;
                mensaje.IsBodyHtml = true;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        
        public void EnviarCorreo()
        {
            try
            {
                servicioCorreo.Send(mensaje);
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        public void CerrarConexion()
        {
            try
            {
                servicioCorreo.Dispose();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
