<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001" %>

<%
    'COMPONENTE DE ENVIO DE EMAIL
    if request("action") = "ok" then
		Dim emailFromAddAddress

		emailFromAddAddress = "dev@masterfuel.com.br"

		' Obtendo e tratando o texto do textarea
		Dim nome, email, mensagem, corpoEmail
		nome = request("nome")
		email = request("email")
		mensagem = request("mensagem")
		
		' Configurando o objeto de e-mail
    	Set Mail = Server.CreateObject("Persits.MailSender")
        
    	Mail.Host = "localhost"
    	Mail.From = ""&request("email")&""
    	Mail.MailFrom = emailFromAddAddress 
    	Mail.FromName = ""&request("nome")&"" 
    	Mail.AddAddress emailFromAddAddress

    	Mail.IsHTML = True 
    	Mail.Subject = "Formulário Site" 

    	' Construindo o corpo do e-mail em formato HTML
    	texto = "<html><body>"
    	texto = texto & "<b>Nome:</b> "&request("nome") & "<br>"
    	texto = texto & "<b>E-mail:</b> "&request("email") & "<br><br>"
    	texto = texto & "<b>Mensagem:</b> "&request("mensagem") & ""
    	texto = texto & "</body></html>"

    	Mail.body = texto

    	On Error Resume Next 
		Mail.Send 
		If Err <> 0 Then 
			Response.Write "Error encountered: " & Err.Description 
		Else
			Response.Redirect "index.html"
		End If 
		Set Mail = Nothing
    end if
%>