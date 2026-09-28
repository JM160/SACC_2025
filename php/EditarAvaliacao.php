<?php
session_start();
require_once 'Connect.php'; // Certifique-se que o caminho está correto

// Validação de acesso
if (!isset($_SESSION['id_jurados']) || !isset($_POST['id_trabalho'])) {
    header('Location: ../html/dashboard.php?erro=acesso');
    exit();
}

$idJurado = $_SESSION['id_jurados'];
$idTrabalho = $_POST['id_trabalho'];

try {
    $stmtCheck = $pdo->prepare("
        SELECT t.id_categoria, t.id_areas, j.avaliacoes_finalizadas
        FROM Trabalhos t
        JOIN Jurados j ON j.id_jurados = ?
        WHERE t.id_trabalhos = ?
    ");
    $stmtCheck->execute([$idJurado, $idTrabalho]);
    $infoCheck = $stmtCheck->fetch(PDO::FETCH_ASSOC);

    if ($infoCheck) {
        $chaveCheck = ($infoCheck['id_categoria'] ?? 0) . '_' . ($infoCheck['id_areas'] ?? 0);
        $finalizadasCheck = array_filter(explode(',', (string)$infoCheck['avaliacoes_finalizadas']));
        if (in_array($chaveCheck, $finalizadasCheck) || $infoCheck['avaliacoes_finalizadas'] === '1') {
            die("Esta área já foi finalizada e suas avaliações não podem mais ser alteradas.");
        }
    }

    $pdo->beginTransaction();

    // Loop para atualizar os 9 critérios listados na tabela do HTML
    for ($i = 1; $i <= 9; $i++) {
        if (isset($_POST["criterio$i"])) {
            // Nota vem no formato brasileiro (9,50). Precisamos mudar para americano (9.50) para o BD.
            $notaFormatada = str_replace(',', '.', $_POST["criterio$i"]);
            $comentario = isset($_POST["comentario$i"]) ? trim($_POST["comentario$i"]) : '';

            $stmt = $pdo->prepare("
                UPDATE avaliacoes 
                SET nota = ?, comentario = ?, data_avaliacao = NOW() 
                WHERE id_trabalho = ? AND id_jurado = ? AND criterio = ?
            ");
            
            $stmt->execute([$notaFormatada, $comentario, $idTrabalho, $idJurado, $i]);
        }
    }

    $pdo->commit();
    
    // Redireciona de volta ao dashboard com sucesso
    // Substitua 'dashboard_jurado.php' pelo nome correto do seu arquivo caso seja diferente
    header('Location: ../html/jurado-dashboard.php'); 
    exit();

} catch (PDOException $e) {
    $pdo->rollBack();
    die('Erro ao atualizar a avaliação no banco de dados: ' . $e->getMessage());
}
?>