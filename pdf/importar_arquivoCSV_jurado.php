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

        $stmtCategorias = $pdo->query(
            "SELECT id_categoria, nome_categoria FROM Categorias"
        );

        $categoriasBanco = [];

        while ($categoria = $stmtCategorias->fetch(PDO::FETCH_ASSOC)) {
            $categoriasBanco[normalizarTexto($categoria['nome_categoria'])] = $categoria['id_categoria'];
        }

        $stmtAreas = $pdo->query(
            "SELECT id_area, nome_area FROM Areas"
        );

        $areasBanco = [];

        while ($area = $stmtAreas->fetch(PDO::FETCH_ASSOC)) {
            $areasBanco[normalizarTexto($area['nome_area'])] = $area['id_area'];
        }

        fgetcsv($handle, 1000, ",");

        while (($linha = fgetcsv($handle, 1000, ",")) !== false) {

            $nome = trim($linha[0] ?? '');
            $telefone = trim($linha[1] ?? '');
            $cpf = trim($linha[2] ?? '');
            $email = trim($linha[3] ?? '');

            $categorias = [
                trim($linha[4] ?? '', " \t\n\r\0\x0B\";"),
                trim($linha[6] ?? '', " \t\n\r\0\x0B\";")
            ];

            $areas = [
                trim($linha[5] ?? '', " \t\n\r\0\x0B\";"),
                trim($linha[7] ?? '', " \t\n\r\0\x0B\";")
            ];

            if ($nome == '' || $cpf == '' || $email == '') {
                continue;
            }

            $stmt = $pdo->prepare(
                "INSERT INTO Contatos (telefone, email) VALUES (?, ?)"
            );

            $stmt->execute([
                $telefone,
                $email
            ]);

            $id_contato = $pdo->lastInsertId();

            $caracteresUsuario = '0123456789';

            $usuario = substr(
                str_shuffle(str_repeat($caracteresUsuario, 6)),
                0,
                6
            );

            $caracteresSenha = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';

            $senha = substr(
                str_shuffle(str_repeat($caracteresSenha, 6)),
                0,
                6
            );

            $stmt = $pdo->prepare(
                "INSERT INTO Jurados
                (nome, usuario, senha, cpf, id_contatos)
                VALUES (?, ?, ?, ?, ?)"
            );

            $stmt->execute([
                $nome,
                $usuario,
                $senha,
                $cpf,
                $id_contato
            ]);

            $id_jurado = $pdo->lastInsertId();

            $stmtAssoc = $pdo->prepare(
                "INSERT INTO Jurados_Categorias_Areas
                (id_jurados, id_categoria, id_area)
                VALUES (?, ?, ?)"
            );

            for ($i = 0; $i < 2; $i++) {

                $nome_categoria = $categorias[$i];
                $nome_area = $areas[$i];

                if ($nome_categoria == '') {
                    continue;
                }

                $categoriaNormalizada = normalizarTexto($nome_categoria);

                if (!isset($categoriasBanco[$categoriaNormalizada])) {
                    throw new Exception(
                        "Categoria não encontrada para o jurado " .
                        $nome . ": " . $nome_categoria
                    );
                }

                $id_categoria = $categoriasBanco[$categoriaNormalizada];

                if ($id_categoria == 3) {

                    $id_area = null;

                } else {

                    if ($nome_area == '') {
                        throw new Exception(
                            "A área é obrigatória para a categoria " .
                            $nome_categoria .
                            " do jurado " .
                            $nome
                        );
                    }

                    $areaNormalizada = normalizarTexto($nome_area);

                    if (!isset($areasBanco[$areaNormalizada])) {
                        throw new Exception(
                            "Área não encontrada para o jurado " .
                            $nome . ": " . $nome_area
                        );
                    }

                    $id_area = $areasBanco[$areaNormalizada];
                }

                $stmtAssoc->execute([
                    $id_jurado,
                    $id_categoria,
                    $id_area
                ]);
            }
        }

        $pdo->commit();

        fclose($handle);

        header('Location: ../html/admin-jurados.php?msg=importado');
        exit();

    } catch (Exception $e) {

        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }

        fclose($handle);

        die("Erro ao importar jurados: " . $e->getMessage());
    }
}