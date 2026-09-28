<?php
session_start();
require_once '../php/Connect.php';

header('Content-Type: application/json; charset=UTF-8');

if (!isset($_SESSION['id_jurados'])) {
    echo json_encode([
        'status' => 'erro',
        'mensagem' => 'Sessão do jurado não encontrada.'
    ]);
    exit();
}

$idJurado = $_SESSION['id_jurados'];
$idCategoria = isset($_POST['id_categoria']) ? (int)$_POST['id_categoria'] : 0;
$idArea = isset($_POST['id_area']) ? (int)$_POST['id_area'] : 0;

try {
    $stmtUser = $pdo->prepare("SELECT avaliacoes_finalizadas FROM Jurados WHERE id_jurados = ?");
    $stmtUser->execute([$idJurado]);
    $user = $stmtUser->fetch(PDO::FETCH_ASSOC);

    $atualStr = $user ? (string)$user['avaliacoes_finalizadas'] : '';
    if ($atualStr === '1') {
        $atualStr = '';
    }

    $lista = array_filter(explode(',', $atualStr));

    if ($idCategoria > 0 || $idArea > 0) {
        $chave = $idCategoria . '_' . $idArea;
        if (!in_array($chave, $lista)) {
            $lista[] = $chave;
        }
    }

    $novoStr = implode(',', $lista);

    $stmt = $pdo->prepare("
        UPDATE Jurados
        SET avaliacoes_finalizadas = ?
        WHERE id_jurados = ?
    ");

    $stmt->execute([$novoStr, $idJurado]);

    echo json_encode([
        'status' => 'sucesso'
    ]);
    exit();

} catch (PDOException $e) {
    echo json_encode([
        'status' => 'erro',
        'mensagem' => 'Erro ao finalizar as avaliações.'
    ]);
    exit();
}
?>