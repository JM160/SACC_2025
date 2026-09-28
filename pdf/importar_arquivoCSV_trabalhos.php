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

        $stmt = $pdo->query(
            "SELECT id_escolas, nome FROM Escolas"
        );

        $escolasBanco = [];

        while ($escola = $stmt->fetch(PDO::FETCH_ASSOC)) {

            $escolasBanco[
                normalizarTexto($escola['nome'])
            ] = $escola['id_escolas'];
        }

        $stmt = $pdo->query(
            "SELECT id_area, nome_area FROM Areas"
        );

        $areasBanco = [];

        while ($area = $stmt->fetch(PDO::FETCH_ASSOC)) {

            $areasBanco[
                normalizarTexto($area['nome_area'])
            ] = $area['id_area'];
        }

        $stmt = $pdo->query(
            "SELECT id_categoria, nome_categoria FROM Categorias"
        );

        $categoriasBanco = [];

        while ($categoria = $stmt->fetch(PDO::FETCH_ASSOC)) {

            $categoriasBanco[
                normalizarTexto($categoria['nome_categoria'])
            ] = $categoria['id_categoria'];
        }

        $stmt = $pdo->query(
            "SELECT id_jurados, nome FROM Jurados"
        );

        $juradosBanco = [];

        while ($jurado = $stmt->fetch(PDO::FETCH_ASSOC)) {

            $juradosBanco[
                normalizarTexto($jurado['nome'])
            ] = $jurado['id_jurados'];
        }

        fgetcsv($handle, 1000, ",");

        $stmtTrabalho = $pdo->prepare(
            "INSERT INTO Trabalhos
            (titulo, id_escolas, id_areas, id_categoria, id_jurados, ordem)
            VALUES (?, ?, ?, ?, ?, ?)"
        );

        while (($linha = fgetcsv($handle, 1000, ",")) !== false) {

            $titulo = trim($linha[0] ?? '');
            $nome_escola = trim($linha[1] ?? '');
            $nome_categoria = trim($linha[2] ?? '');
            $nome_area = trim($linha[3] ?? '');
            $nome_jurado = trim($linha[4] ?? '');
            $ordem = trim($linha[5] ?? '');

            if ($titulo == '') {
                continue;
            }

            $escolaNormalizada = normalizarTexto($nome_escola);

            if (!isset($escolasBanco[$escolaNormalizada])) {

                throw new Exception(
                    "Escola não encontrada: " . $nome_escola .
                    " | Trabalho: " . $titulo
                );
            }

            $id_escola = $escolasBanco[$escolaNormalizada];

            $areaNormalizada = normalizarTexto($nome_area);

            if (!isset($areasBanco[$areaNormalizada])) {

                throw new Exception(
                    "Área não encontrada: " . $nome_area .
                    " | Trabalho: " . $titulo
                );
            }

            $id_area = $areasBanco[$areaNormalizada];

            $categoriaNormalizada = normalizarTexto($nome_categoria);

            if (!isset($categoriasBanco[$categoriaNormalizada])) {

                throw new Exception(
                    "Categoria não encontrada: " . $nome_categoria .
                    " | Trabalho: " . $titulo
                );
            }

            $id_categoria = $categoriasBanco[$categoriaNormalizada];

            $id_jurado = null;

            if ($nome_jurado != '') {

                $juradoNormalizado = normalizarTexto($nome_jurado);

                if (!isset($juradosBanco[$juradoNormalizado])) {

                    throw new Exception(
                        "Jurado não encontrado: " . $nome_jurado .
                        " | Trabalho: " . $titulo
                    );
                }

                $id_jurado = $juradosBanco[$juradoNormalizado];
            }

            if ($ordem == '') {
                $ordem = 0;
            }

            $stmtVerifica = $pdo->prepare(
                "SELECT id_trabalhos
                 FROM Trabalhos
                 WHERE id_escolas = ?
                 AND id_areas = ?
                 LIMIT 1"
            );

            $stmtVerifica->execute([
                $id_escola,
                $id_area
            ]);

            if ($stmtVerifica->fetch()) {

                throw new Exception(
                    "A escola '" . $nome_escola .
                    "' já possui um trabalho cadastrado na área '" .
                    $nome_area . "'."
                );
            }

        

            $stmtTrabalho->execute([
                $titulo,
                $id_escola,
                $id_area,
                $id_categoria,
                $id_jurado,
                $ordem
            ]);

            $stmtAtualizaEscola = $pdo->prepare(
                "UPDATE Escolas
                 SET total_trabalhos = total_trabalhos + 1
                 WHERE id_escolas = ?"
            );

            $stmtAtualizaEscola->execute([
                $id_escola
            ]);
        }

        $pdo->commit();

        fclose($handle);

        header('Location: ../html/admin-trabalhos.php?msg=importado');
        exit();

    } catch (Exception $e) {

        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }

        fclose($handle);

        die("Erro ao importar trabalhos: " . $e->getMessage());
    }
}