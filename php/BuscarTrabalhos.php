<?php
require_once '../php/Connect.php';
header('Content-Type: application/json');

$categoria = $_GET['categoria'] ?? null;
$area = $_GET['area'] ?? null;
$jurado = $_GET['jurado'] ?? null;

if (!$categoria || !$jurado) {
    http_response_code(400);
    echo json_encode([]);
    exit;
}

try {
    if ($categoria === '3') {
        $stmt = $pdo->prepare("
            SELECT t.id_trabalhos, t.titulo, t.ordem, a.nome_area
            FROM Trabalhos t
            LEFT JOIN Areas a ON t.id_areas = a.id_area
            WHERE t.id_categoria = ?
              AND NOT EXISTS (
                  SELECT 1
                  FROM Jurado_Trabalho jt
                  WHERE jt.id_jurado = ?
                    AND jt.id_trabalho = t.id_trabalhos
              )
            ORDER BY t.ordem ASC, t.id_trabalhos ASC
        ");
        $stmt->execute([$categoria, $jurado]);

    } else {
        if (!$area) {
            http_response_code(400);
            echo json_encode([]);
            exit;
        }
        $stmt = $pdo->prepare("
            SELECT t.id_trabalhos, t.titulo, t.ordem, a.nome_area
            FROM Trabalhos t
            INNER JOIN Areas a ON t.id_areas = a.id_area
            WHERE t.id_categoria = ?
              AND t.id_areas = ?
              AND NOT EXISTS (
                  SELECT 1
                  FROM Jurado_Trabalho jt
                  WHERE jt.id_jurado = ?
                    AND jt.id_trabalho = t.id_trabalhos
              )
            ORDER BY t.ordem ASC, t.id_trabalhos ASC
        ");
        $stmt->execute([$categoria, $area, $jurado]);
    }
    $trabalhos = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($trabalhos);
    
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'error' => 'Erro ao buscar trabalhos: ' . $e->getMessage()
    ]);
}