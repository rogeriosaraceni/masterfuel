<?php
header('Content-Type: application/json'); // Define o tipo de conteúdo como JSON

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Capture os dados do formulário
    $name = $_POST['name'];
    $email = $_POST['email'];
    $mensagem = $_POST['mensagem'];

    // Aqui você pode fazer qualquer processamento necessário, como salvar no banco de dados

    // Responda com um JSON
    echo json_encode([
        'status' => 'success',
        'message' => "Dados recebidos: Nome - $name, Email - $email"
    ]);
} else {
    // Se a solicitação não for POST, envie uma resposta de erro
    echo json_encode([
        'status' => 'error',
        'message' => 'Método de requisição não suportado'
    ]);
}
