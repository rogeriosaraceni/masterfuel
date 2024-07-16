<?php
// COMPONENTE DE ENVIO DE EMAIL

// Inicializando variáveis
$toastTarget = isset($_REQUEST['toastTarget']) ? $_REQUEST['toastTarget'] : '';
$toastStatus = '';
$errorMessage = '';

// Verificar se todos os campos obrigatórios estão preenchidos
if (!empty($_REQUEST['nome']) && !empty($_REQUEST['email']) && !empty($_REQUEST['mensagem'])) {
    if (!empty($toastTarget)) {
        // Email From e AddAddress
        $emailFrom = $_REQUEST['email'];
        $emailFromName = $_REQUEST['nome'];
        $emailTo = "dev@masterfuel.com.br";
        $subject = "Formulário Site";

        // Construindo o corpo do e-mail em formato HTML
        $message = "<html><body>";
        $message .= "<b>Nome:</b> " . htmlspecialchars($_REQUEST['nome']) . "<br>";
        $message .= "<b>E-mail:</b> " . htmlspecialchars($_REQUEST['email']) . "<br><br>";
        $message .= "<b>Mensagem:</b> " . htmlspecialchars($_REQUEST['mensagem']);
        $message .= "</body></html>";

        // Configurando cabeçalhos do e-mail
        $headers = "MIME-Version: 1.0" . "\r\n";
        $headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";
        $headers .= "From: " . $emailFromName . " <" . $emailFrom . ">" . "\r\n";

        // Enviando e-mail
        if (mail($emailTo, $subject, $message, $headers)) {
            $toastStatus = $toastTarget;
        } else {
            $errorMessage = "Erro ao enviar e-mail.";
            $toastStatus = "error";
        }
    } else {
        $toastStatus = "error";
    }
} else {
    $errorMessage = "Erro de request";
    $toastStatus = "error";
}

// Passa o erro para a página HTML via localStorage
if (!empty($errorMessage)) {
    echo "<script>localStorage.setItem('toastError', '" . $errorMessage . "');</script>";
}

// Armazenar o toastStatus no localStorage via JavaScript
echo "<script>localStorage.setItem('toastStatus', '" . $toastStatus . "'); window.location.href = './index.html';</script>";
?>
