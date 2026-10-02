<?php
require_once '../php/Connect.php';
function normalizarTexto($texto){
    $texto = (string) $texto;

    // Remove BOM e espaços invisíveis
    $texto = preg_replace('/^\xEF\xBB\xBF/', '', $texto);
    $texto = str_replace("\xC2\xA0", ' ', $texto);
    $texto = trim($texto, " \t\n\r\0\x0B\"'");
    $texto = mb_strtolower($texto, 'UTF-8');
    // Remove acentos
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
        'ç' => 'c',
        'ñ' => 'n'
    ]);

    $texto = str_replace(
        ['–', '—', '-', '−'],
        '-',
        $texto
    );

    $texto = preg_replace('/\s+/', ' ', $texto);
    $texto = preg_replace('/\s*-\s*/', ' - ', $texto);

    return trim($texto);
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    if (
        !isset($_FILES['meu_arquivo']) ||
        $_FILES['meu_arquivo']['error'] != 0
    ) {
        die("Erro ao enviar o arquivo.");
    }

    $arquivoTemp = $_FILES['meu_arquivo']['tmp_name'];

    if (($handle = fopen($arquivoTemp, 'r')) === false) {
        die("Erro ao abrir o arquivo.");
    }

    try {

        $pdo->beginTransaction();

        $stmt = $pdo->query(
            "SELECT
                e.id_escolas,
                e.nome,
                e.id_categoria_escola,
                ce.categoria_da_escola
             FROM Escolas e
             LEFT JOIN categoria_escolas ce
                ON e.id_categoria_escola = ce.id"
        );

        $escolasBanco = [];

        while ($escola = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $nomeEscola = normalizarTexto(
                $escola['nome']
            );
            $categoriaEscola = normalizarTexto(
                $escola['categoria_da_escola'] ?? ''
            );
            if ($nomeEscola == '' || $categoriaEscola == '') {
                continue;
            }
            $chave = $categoriaEscola . '|' . $nomeEscola;

            $escolasBanco[$chave] = [
                'id' => $escola['id_escolas'],
                'nome' => $nomeEscola,
                'categoria' => $categoriaEscola
            ];
        }

        $categoriasEscolasBanco = [];
        foreach ($escolasBanco as $escola) {
            $categoria = $escola['categoria'];
            if (!isset($categoriasEscolasBanco[$categoria])) {
                $categoriasEscolasBanco[$categoria] = true;
            }
        }

        uksort(
            $categoriasEscolasBanco,
            function ($a, $b) {
                return strlen($b) - strlen($a);
            }
        );

        $stmt = $pdo->query(
            "SELECT
                id_area,
                nome_area
             FROM Areas"
        );

        $areasBanco = [];

        while ($area = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $nomeArea = normalizarTexto(
                $area['nome_area']
            );
            $areasBanco[$nomeArea] = $area['id_area'];
        }

        $stmt = $pdo->query(
            "SELECT
                id_categoria,
                nome_categoria
             FROM Categorias"
        );

        $categoriasBanco = [];

        while ($categoria = $stmt->fetch(PDO::FETCH_ASSOC)) {

            $nomeCategoria = normalizarTexto(
                $categoria['nome_categoria']
            );

            $categoriasBanco[$nomeCategoria] =
                $categoria['id_categoria'];
        }

        fgetcsv($handle, 0, ",");

        $stmtTrabalho = $pdo->prepare(
            "INSERT INTO Trabalhos
            (
                titulo,
                id_escolas,
                id_areas,
                id_categoria,
                id_jurados,
                ordem
            )
            VALUES (?, ?, ?, ?, ?, ?)"
        );

        $numeroLinha = 1;

        while (
            ($linha = fgetcsv($handle, 0, ",")) !== false
        ) {
            $numeroLinha++;
            if (
                count($linha) == 1 &&
                trim($linha[0]) == ''
            ) {
                continue;
            }

            $titulo = trim(
                $linha[0] ?? ''
            );

            $nomeEscolaCSV = trim(
                $linha[1] ?? ''
            );

            $nomeCategoriaCSV = trim(
                $linha[2] ?? ''
            );

            $nomeAreaCSV = trim(
                $linha[3] ?? ''
            );

            if ($titulo == '') {
                continue;
            }

            $escolaNormalizada = normalizarTexto(
                $nomeEscolaCSV
            );

            $categoriaEscolaCSV = '';
            $nomeEscolaSemCategoria = '';

            foreach (
                $categoriasEscolasBanco as $categoria => $valor
            ) {

                if (
                    $escolaNormalizada === $categoria ||
                    str_starts_with(
                        $escolaNormalizada,
                        $categoria . ' '
                    )
                ) {
                    $categoriaEscolaCSV = $categoria;

                    $nomeEscolaSemCategoria = trim(
                        substr(
                            $escolaNormalizada,
                            strlen($categoria)
                        )
                    );
                    break;
                }
            }
            if ($categoriaEscolaCSV == '') {

                throw new Exception(
                    "Categoria da escola não encontrada na linha " .
                    $numeroLinha .
                    ": '" .
                    $nomeEscolaCSV .
                    "' | Trabalho: " .
                    $titulo
                );
            }

            $chaveEscola =
                $categoriaEscolaCSV .
                '|' .
                $nomeEscolaSemCategoria;

            if (!isset($escolasBanco[$chaveEscola])) {

                throw new Exception(
                    "Escola não encontrada na linha " .
                    $numeroLinha .
                    ": '" .
                    $nomeEscolaSemCategoria .
                    "' | Categoria: '" .
                    $categoriaEscolaCSV .
                    "' | Valor no CSV: '" .
                    $nomeEscolaCSV .
                    "' | Trabalho: " .
                    $titulo
                );
            }

            $idEscola = $escolasBanco[$chaveEscola]['id'];

            $areaNormalizada = normalizarTexto(
                $nomeAreaCSV
            );

            if (!isset($areasBanco[$areaNormalizada])) {
                $idArea = null;

                foreach (
                    $areasBanco as $areaBanco => $id
                ) {
                    if (
                        normalizarTexto($areaBanco) ===
                        $areaNormalizada
                    ) {
                        $idArea = $id;
                        break;
                    }
                }

                if ($idArea === null) {

                    throw new Exception(
                        "Área não encontrada na linha " .
                        $numeroLinha .
                        ": '" .
                        $nomeAreaCSV .
                        "' | Trabalho: " .
                        $titulo
                    );
                }

            } else {

                $idArea =
                    $areasBanco[$areaNormalizada];
            }

            $categoriaNormalizada =
                normalizarTexto(
                    $nomeCategoriaCSV
                );

            if (
                !isset(
                    $categoriasBanco[
                        $categoriaNormalizada
                    ]
                )
            ) {

                throw new Exception(
                    "Categoria não encontrada na linha " .
                    $numeroLinha .
                    ": '" .
                    $nomeCategoriaCSV .
                    "' | Trabalho: " .
                    $titulo
                );
            }

            $idCategoria =
                $categoriasBanco[
                    $categoriaNormalizada
                ];

            $idJurado = null;

            $ordem = 0;

            $stmtVerifica = $pdo->prepare(
                "SELECT id_trabalhos
                 FROM Trabalhos
                 WHERE id_escolas = ?
                 AND id_areas = ?
                 LIMIT 1"
            );

            $stmtVerifica->execute([
                $idEscola,
                $idArea
            ]);

            if ($stmtVerifica->fetch()) {

                throw new Exception(
                    "A escola '" .
                    $nomeEscolaCSV .
                    "' já possui um trabalho cadastrado " .
                    "na área '" .
                    $nomeAreaCSV .
                    "'."
                );
            }

            $stmtTrabalho->execute([
                $titulo,
                $idEscola,
                $idArea,
                $idCategoria,
                $idJurado,
                $ordem
            ]);
        }

        $pdo->commit();

        fclose($handle);

        header(
            'Location: ../html/admin-trabalhos.php?msg=importado'
        );

        exit();

    } catch (Exception $e) {

        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }

        fclose($handle);

        die(
            "Erro ao importar trabalhos: " .
            $e->getMessage()
        );
    }
}