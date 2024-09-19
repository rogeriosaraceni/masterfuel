<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001" %>

<%
' Configura o tipo de resposta como JSON
Response.ContentType = "application/json"

' Variáveis para capturar os dados do formulário
Dim nome, email, mensagem, errorMessage, successMessage
nome = Trim(Request.Form("nome"))
email = Trim(Request.Form("email"))
mensagem = Trim(Request.Form("mensagem"))

' Verificar se todos os campos obrigatórios estão preenchidos
If nome <> "" And email <> "" And mensagem <> "" Then
    ' Configurando o objeto de e-mail
    Dim emailFromAddAddress, Mail, texto
    emailFromAddAddress = "dev@masterfuel.com.br" ' Endereço de e-mail que receberá a mensagem

    Set Mail = Server.CreateObject("Persits.MailSender")

    ' Configurações do servidor de e-mail
    Mail.Host = "localhost"
    Mail.From = email
    Mail.MailFrom = emailFromAddAddress
    Mail.FromName = nome
    Mail.AddAddress emailFromAddAddress
    
    Mail.IsHTML = True
    Mail.Subject = "Formulário Site"
    
    ' Construindo o corpo do e-mail em formato HTML
    texto = "<html><body>"
    texto = texto & "<b>Nome:</b> " & Server.HTMLEncode(nome) & "<br>"
    texto = texto & "<b>E-mail:</b> " & Server.HTMLEncode(email) & "<br><br>"
    texto = texto & "<b>Mensagem:</b> " & Server.HTMLEncode(mensagem) & ""
    texto = texto & "</body></html>"
    
    Mail.Body = texto

    ' Tentativa de envio do e-mail
    On Error Resume Next
    Mail.Send
    
    If Err.Number = 0 Then
        ' E-mail enviado com sucesso
        successMessage = "E-mail enviado com sucesso!"
        Response.Write "{""status"":""success"",""message"":""" & successMessage & """}"
    Else
        ' Erro ao enviar e-mail
        errorMessage = "Erro ao enviar e-mail: " & Err.Description
        Response.Write "{""status"":""error"",""message"":""" & errorMessage & """}"
    End If

    ' Limpeza do objeto de e-mail
    Set Mail = Nothing
    On Error GoTo 0
Else
    ' Erro: campos obrigatórios não preenchidos
    errorMessage = "Todos os campos são obrigatórios. Por favor, preencha todos os campos."
    Response.Write "{""status"":""error"",""message"":""" & errorMessage & """}"
End If
%>
