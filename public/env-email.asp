<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001" %>

<%
    'COMPONENTE DE ENVIO DE EMAIL
    Dim toastTarget, toastStatus, errorMessage
    toastTarget = request("toastTarget")

    'Verificar se todos os campos obrigatórios estão preenchidos
    If request("nome") <> "" And request("email") <> "" And request("mensagem") <> "" Then
        If Len(toastTarget) > 0 Then

            'Email From e AddAddress
            Dim emailFromAddAddress
            emailFromAddAddress = "masterfuel@masterfuel.com.br"

            'Configurando o objeto de e-mail
            Set Mail = Server.CreateObject("Persits.MailSender")

            Mail.Host = "localhost"
            Mail.From = request("email")
            Mail.MailFrom = emailFromAddAddress
            Mail.FromName = request("nome")
            Mail.AddAddress emailFromAddAddress

            Mail.IsHTML = True 
            Mail.Subject = "Formulário Site"

            'Construindo o corpo do e-mail em formato HTML
            texto = "<html><body>"
            texto = texto & "<b>Nome:</b> " & request("nome") & "<br>"
            texto = texto & "<b>E-mail:</b> " & request("email") & "<br><br>"
            texto = texto & "<b>Mensagem:</b> " & request("mensagem") & ""
            texto = texto & "</body></html>"

            mail.body = texto

            On Error Resume Next 
            Mail.Send 
            If Err <> 0 Then 
                errorMessage = "Erro ao enviar e-mail: " & Err.Description
                toastStatus = "error"
            Else
                toastStatus = toastTarget
            End If 
            Set Mail = Nothing
        Else
            toastStatus = "error"
        End If
    Else
        errorMessage = "Erro de request"
        toastStatus = "error"
    End If

    'Passa o erro para a página HTML via localStorage
    If Len(errorMessage) > 0 Then
        Response.Write "<script>localStorage.setItem('toastError', '" & errorMessage & "');</script>"
    End If

    'Armazenar o toastStatus no localStorage via JavaScript
    Response.Write "<script>localStorage.setItem('toastStatus', '" & toastStatus & "'); window.location.href = './index.html';</script>"
%>
