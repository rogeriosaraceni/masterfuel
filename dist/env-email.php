<?php
// Definindo variáveis do formulário
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["action"]) && $_POST["action"] == "ok") {
    $nome = $_POST["nome"];
    $email = $_POST["email"];
    $mensagem = nl2br($_POST["mensagem"]); // Converter quebras de linha para <br>

    // Definindo variáveis de e-mail
    $emailRemetente = "dev@masterfuel.com.br";
    $assunto = "Formulário Site";

    // Construindo o corpo do e-mail em formato HTML
    $corpo = "<html><body>";
    $corpo .= "<b>Nome:</b> " . $nome . "<br>";
    $corpo .= "<b>E-mail:</b> " . $email . "<br><br>";
    $corpo .= "<b>Mensagem:</b><br>" . $mensagem;

    // Cabeçalhos do e-mail
    $headers = "MIME-Version: 1.0\r\n";
    $headers .= "Content-type: text/html; charset=UTF-8\r\n";
    $headers .= "From: " . $email . "\r\n"; // Remetente
    $headers .= "Return-Path: " . $email . "\r\n"; // Return-path

    // Envio do e-mail
    $envio = mail($emailRemetente, $assunto, $corpo, $headers);

    if ($envio) {
        // Redirecionamento para index.html
        header("Location: index.html");
        exit; // Certifique-se de parar a execução do script após o redirecionamento
    } else {
        echo "A mensagem não pode ser enviada";
    }
}
?>
