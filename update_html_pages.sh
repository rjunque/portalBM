#!/bin/bash

# Define o diretório do projeto
OUTPUT_DIR="portal_bm_project"

echo "Atualizando páginas HTML com os placeholders de cabeçalho e rodapé..."

# Função para gerar o boilerplate HTML com placeholders
generate_html_with_placeholders() {
    local filename="$1"
    local title="$2"
    local banner_text="$3"
    local category_title="$4"

    cat << EOF > "$OUTPUT_DIR/$filename"
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Portal BM - $title</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <header>
        <h1>Portal BM</h1>
        <p>As notícias mais importantes do dia, reunidas em um só lugar.</p>
    </header>

    <div id="main-nav-placeholder"></div>

    <section class="banner-section">
        <a href="https://pay.hub.la/UGt7sP1xgskF9R3YRNUI" target="_blank">
            <img src="Banner.jpg" alt="Banner do Portal BM" class="main-banner">
        </a>
        <p class="banner-text">$banner_text</p>
    </section>

    <main>
        <section class="category">
            <h2>$category_title</h2>
            <div id="news-container">
                </div>
        </section>
    </main>

    <footer>
        <p>&copy; 2024 Portal BM. Todos os direitos reservados.</p>
        <div id="footer-nav-placeholder"></div>
    </footer>

    <script src="main.js"></script> 
</body>
</html>
EOF
echo "Gerado $OUTPUT_DIR/$filename"
}

# Gerar index.html
generate_html_with_placeholders \
    "Seu Portal de Notícias" \
    "Bem-vindo ao Portal BM! Fique por dentro das últimas notícias." \
    "Destaques do Dia" \
    "index.html"

# Gerar politica_nacional.html
generate_html_with_placeholders \
    "Política Nacional" \
    "Acompanhe as últimas notícias sobre Política Nacional." \
    "Política Nacional" \
    "politica_nacional.html"

# Gerar economia_negocios.html
generate_html_with_placeholders \
    "Economia e Negócios" \
    "Fique por dentro das últimas notícias sobre Economia e Negócios." \
    "Economia e Negócios" \
    "economia_negocios.html"

# Gerar cultura_lazer_sociedade.html
generate_html_with_placeholders \
    "Cultura, Lazer e Sociedade" \
    "Explore as novidades em Cultura, Lazer e Sociedade." \
    "Cultura, Lazer e Sociedade" \
    "cultura_lazer_sociedade.html"

# Gerar esportes.html
generate_html_with_placeholders \
    "Esportes" \
    "As últimas notícias do mundo dos Esportes." \
    "Esportes" \
    "esportes.html"

# Gerar seguranca_meio_ambiente.html
generate_html_with_placeholders \
    "Segurança e Meio Ambiente" \
    "Notícias sobre Segurança e Meio Ambiente." \
    "Segurança e Meio Ambiente" \
    "seguranca_meio_ambiente.html"

# Gerar paginas_amarelas.html
generate_html_with_placeholders \
    "Páginas Amarelas" \
    "Leia nossas Páginas Amarelas e perfis exclusivos." \
    "Páginas Amarelas" \
    "paginas_amarelas.html"

# Gerar criar_noticia.html (Sem news-container)
cat << 'EOF' > "$OUTPUT_DIR/criar_noticia.html"
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Portal BM - Criar Notícia</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <header>
        <h1>Portal BM</h1>
        <p>As notícias mais importantes do dia, reunidas em um só lugar.</p>
    </header>

    <div id="main-nav-placeholder"></div>

    <main>
        <section class="category admin-page">
            <h2>Criar Nova Notícia</h2>
            <p>Em desenvolvimento. Futuramente, aqui você poderá criar e enviar novas notícias para o portal.</p>
            </section>
    </main>

    <footer>
        <p>&copy; 2024 Portal BM. Todos os direitos reservados.</p>
        <div id="footer-nav-placeholder"></div>
    </footer>

    <script src="main.js"></script>
</body>
</html>
EOF
echo "Gerado $OUTPUT_DIR/criar_noticia.html"


# Gerar publicacao_massa.html (Sem news-container)
cat << 'EOF' > "$OUTPUT_DIR/publicacao_massa.html"
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Portal BM - Publicação em Massa</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <header>
        <h1>Portal BM</h1>
        <p>As notícias mais importantes do dia, reunidas em um só lugar.</p>
    </header>

    <div id="main-nav-placeholder"></div>

    <main>
        <section class="category admin-page">
            <h2>Publicação em Massa</h2>
            <p>Em desenvolvimento. Futuramente, aqui você poderá gerenciar e publicar múltiplas notícias simultaneamente.</p>
            </section>
    </main>

    <footer>
        <p>&copy; 2024 Portal BM. Todos os direitos reservados.</p>
        <div id="footer-nav-placeholder"></div>
    </footer>

    <script src="main.js"></script>
</body>
</html>
EOF
echo "Gerado $OUTPUT_DIR/publicacao_massa.html"


echo "Todas as páginas HTML foram atualizadas com os placeholders necessários."
echo ""
echo "--- Próximos Passos Essenciais ---"
echo ""
echo "1.  **Limpe o Cache do Navegador:** É crucial fazer um 'Hard Refresh' (Ctrl+Shift+R ou Cmd+Shift+R no Windows/Linux ou Cmd+Shift+R no Mac) no seu navegador para garantir que ele carregue as novas versões das páginas HTML."
echo "2.  **Verifique as Páginas:** Acesse novamente \`http://localhost:8000/index.html\` e navegue para as outras páginas de categoria para confirmar que o cabeçalho e o rodapé estão aparecendo corretamente."
echo "3.  **Deploy para o GitHub (se estiver usando):** Se tudo estiver funcionando localmente, lembre-se de adicionar as mudanças aos seus arquivos HTML, fazer o commit e dar um push para o seu repositório Git."
echo "    \`cd portal_bm_project\`"
echo "    \`git add *.html\`"
echo "    \`git commit -m \"Adiciona placeholders de cabecalho e rodape em todas as paginas HTML\"\`"
echo "    \`git push origin main\`"
