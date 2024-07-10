<%
    response.Charset = "utf-8"
    'COMPONENTE DE ENVIO DE EMAIL

    if request("action") = "ok" then
		Dim emailFromAddAddress

		//emailFromAddAddress = "masterfuel@masterfuel.com.br"
		emailFromAddAddress = "dev@masterfuel.com.br"

    	Set Mail = Server.CreateObject("Persits.MailSender")
        
    	Mail.Host = "localhost"
    	Mail.From = ""&request("email")&""
    	
    	Mail.MailFrom = emailFromAddAddress 
    	Mail.FromName = ""&request("nome")&"" 
    	
    	Mail.AddAddress emailFromAddAddress

    	Mail.IsHTML = True 
    	Mail.Subject = "Formulário Site" 

    	'Corpo da mensagem 

    	texto = "<font family: arial>"
    	texto = texto & "<b>Nome:</b> "&request("nome")&""
    	texto = texto & "<br>"
    	texto = texto & "<b>E-mail:</b> "&request("email")&""
    	texto = texto & "<br>"
    	texto = texto & "<br>"
    	texto = texto & "<b>Mensagem:</b> "&request("mensagem")&""
    	texto = texto & "</font>"

    	mail.body = texto

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