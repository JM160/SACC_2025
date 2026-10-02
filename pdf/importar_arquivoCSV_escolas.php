<?php

require_once '../php/Connect.php';

function normalizarTexto($texto)
{
    $texto = trim($texto, " \t\n\r\0\x0B\";");

    $texto = mb_strtolower($texto, 'UTF-8');

    $texto = strtr($texto, [
        'á' => 'a',
        'à' => 'a',
        'ã' => 'a',
        'â' => 'a',
        'ä' => 'a',
        'é' => 'e',
        'è' => 'e',
        'ê' => 'e',
        'ë' => 'e',
        'í' => 'i',
        'ì' => 'i',
        'î' => 'i',
        'ï' => 'i',
        'ó' => 'o',
        'ò' => 'o',
        'õ' => 'o',
        'ô' => 'o',
        'ö' => 'o',
        'ú' => 'u',
        'ù' => 'u',
        'û' => 'u',
        'ü' => 'u',
        'ç' => 'c'
    ]);

    return $texto;
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    if (!isset($_FILES['meu_arquivo']) || $_FILES['meu_arquivo']['error'] != 0) {
        die("Erro ao enviar o arquivo.");
    }

    $arquivoTemp = $_FILES['meu_arquivo']['tmp_name'];

    if (($handle = fopen($arquivoTemp, 'r')) === false) {
        die("Erro ao abrir o arquivo.");
    }

    try {

        $pdo->beginTransaction();

        // Buscar categorias existentes no banco
        $stmtCategorias = $pdo->query(
            "SELECT id, categoria_da_escola FROM categoria_escolas"
        );

        $categoriasBanco = [];

        while ($categoria = $stmtCategorias->fetch(PDO::FETCH_ASSOC)) {

            $categoriasBanco[
                normalizarTexto($categoria['categoria_da_escola'])
            ] = $categoria['id'];
        }

        // Pular cabeçalho
        fgetcsv($handle, 1000, ",");

        while (($linha = fgetcsv($handle, 1000, ",")) !== false) {

            $nome_categoria = trim($linha[0] ?? '');
            $nome = trim($linha[1] ?? '');
            $municipio = trim($linha[2] ?? '');
            //$focalizada = trim($linha[2] ?? '');
            //$ide = trim($linha[3] ?? '');
            $IDEB = trim($linha[3] ?? '');
            $total_trabalhos = trim($linha[4] ?? '');

            // Ignorar linha vazia
            if ($nome == '') {
                continue;
            }

            // Categoria obrigatória
            if ($nome_categoria == '') {
                throw new Exception(
                    "A categoria da escola é obrigatória para: " . $nome
                );
            }

            // Procurar categoria pelo nome
            $categoriaNormalizada = normalizarTexto($nome_categoria);

            if (!isset($categoriasBanco[$categoriaNormalizada])) {
                throw new Exception(
                    "Categoria não encontrada para a escola " .
                    $nome . ": " . $nome_categoria
                );
            }

            $id_categoria_escola = $categoriasBanco[$categoriaNormalizada];

            // Se total_trabalhos estiver vazio, usar 0
            if ($total_trabalhos == '') {
                $total_trabalhos = 0;
            }

            // Cadastrar escola
            $stmt = $pdo->prepare(
                "INSERT INTO Escolas
                (nome, municipio, IDEB, id_categoria_escola, total_trabalhos)
                VALUES (?, ?, ?, ?, ?)"
            );

            $stmt->execute([
                $nome,
                $municipio,
                $IDEB,
                $id_categoria_escola,
                $total_trabalhos
            ]);
        }

        $pdo->commit();

        fclose($handle);

        header('Location: ../html/admin-escolas.php?msg=importado');
        exit();

    } catch (Exception $e) {

        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }

        fclose($handle);

        die("Erro ao importar escolas: " . $e->getMessage());
    }
}