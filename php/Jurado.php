<?php
session_start();
require_once '../php/Connect.php';
header('Content-Type: application/json; charset=UTF-8');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $usuario = $_POST['usuario'] ?? '';
    $senha = $_POST['senha'] ?? '';
    try {

        $stmt = $pdo->prepare("SELECT * FROM Jurados WHERE usuario = :usuario LIMIT 1");
        $stmt->execute([':usuario' => $usuario]);

        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$user) {
            echo json_encode([
                'status' => 'erro',
                'mensagem' => 'Usuário ou senha incorretos.'
            ]);
            exit();
        }

        // Define a senha esperada com base no status de primeiro acesso:
        // - Se primeiro_acesso == 0: aceita a senha temporária gerada pelo sistema.
        // - Se primeiro_acesso == 1: exige a nova senha cadastrada pelo jurado.
        $senhaEsperada = ((int)$user['primeiro_acesso'] === 0) ? $user['senha'] : $user['senha_cadastrada'];

        // Validação de segurança: tenta validar como hash seguro (password_verify)
        // ou faz comparação direta como fallback (para compatibilidade com senhas legadas em texto puro)
        $senhaValida = password_verify($senha, $senhaEsperada) || ($senha === $senhaEsperada);

        if (!$senhaValida) {
            echo json_encode([
                'status' => 'erro',
                'mensagem' => 'Usuário ou senha incorretos.'
            ]);
            exit();
        }

        $_SESSION['id_jurados'] = $user['id_jurados'];
        $_SESSION['usuario'] = $user['usuario'];
        $_SESSION['senha_cadastrada'] = $user['senha_cadastrada'];

        if ((int)$user['primeiro_acesso'] === 0) {
            echo json_encode([
                'status' => 'primeiro_acesso',
                'usuario' => $user['usuario']
            ]);
            exit();
        }
        echo json_encode([
            'status' => 'sucesso',
            'redirect' => 'jurado-dashboard.php'
        ]);
        exit();

    } catch (PDOException $e) {
        echo json_encode([
            'status' => 'erro',
            'mensagem' => 'Erro ao tentar fazer login.'
        ]);
        exit();
    }
} else {
    echo json_encode([
        'status' => 'erro',
        'mensagem' => 'Método de requisição inválido.'
    ]);
    exit();
}
?>