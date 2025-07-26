#!/bin/bash

# Define o diretório onde os arquivos serão criados
OUTPUT_DIR="portal_bm_updated"

echo "Criando diretório temporário: $OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"
if [ $? -ne 0 ]; then
    echo "Erro: Não foi possível criar o diretório $OUTPUT_DIR. Verifique as permissões."
    exit 1
fi

echo "Gerando header.html..."
cat << 'EOF' > "$OUTPUT_DIR/header.html"
<nav class="main-nav">
    <ul>
        <li><a id="nav-inicio" href="index.html">Início</a></li>
        <li><a id="nav-politica" href="politica_nacional.html">Política Nacional</a></li>
        <li><a id="nav-economia" href="economia_negocios.html">Economia e Negócios</a></li>
        <li><a id="nav-cultura" href="cultura_lazer_sociedade.html">Cultura, Lazer e Sociedade</a></li>
        <li><a id="nav-esportes" href="esportes.html">Esportes</a></li>
        <li><a id="nav-seguranca" href="seguranca_meio_ambiente.html">Segurança e Meio Ambiente</a></li>
        <li><a id="nav-amarelas" href="paginas_amarelas.html">Páginas Amarelas</a></li>
        <li><a id="nav-criar" href="criar_noticia.html">Criar Notícia</a></li>
        <li><a id="nav-massa" href="publicacao_massa.html">Publicação em Massa</a></li>
    </ul>
</nav>

<nav class="footer-nav">
    <ul>
        <li><a id="footer-inicio" href="index.html">Início</a></li>
        <li><a id="footer-politica" href="politica_nacional.html">Política Nacional</a></li>
        <li><a id="footer-economia" href="economia_negocios.html">Economia e Negócios</a></li>
        <li><a id="footer-cultura" href="cultura_lazer_sociedade.html">Cultura, Lazer e Sociedade</a></li>
        <li><a id="footer-esportes" href="esportes.html">Esportes</a></li>
        <li><a id="footer-seguranca" href="seguranca_meio_ambiente.html">Segurança e Meio Ambiente</a></li>
        <li><a id="footer-amarelas" href="paginas_amarelas.html">Páginas Amarelas</a></li>
        <li><a id="footer-criar" href="criar_noticia.html">Criar Notícia</a></li>
        <li><a id="footer-massa" href="publicacao_massa.html">Publicação em Massa</a></li>
    </ul>
</nav>
EOF

echo "Gerando main.js..."
cat << 'EOF' > "$OUTPUT_DIR/main.js"
// main.js

document.addEventListener('DOMContentLoaded', function() {
    // --- FUNÇÃO GLOBAL PARA O BOTÃO VOLTAR ---
    window.handleBackButtonClick = function(event) {
        event.preventDefault(); // Impede o comportamento padrão do botão

        if (window.history.length > 1) {
            window.history.back(); // Volta para a página anterior no histórico
        } else {
            window.location.href = 'index.html'; // Fallback para a página inicial
        }
    };
    // --- FIM DA FUNÇÃO GLOBAL PARA O BOTÃO VOLTAR ---

    // --- Lógica para ativação dos links de navegação e visibilidade dos links de administração ---
    const currentPath = window.location.pathname.split('/').pop();
    
    let activeNavId = '';
    let activeFooterId = '';

    switch (currentPath) {
        case 'index.html':
        case '':
            activeNavId = 'nav-inicio';
            activeFooterId = 'footer-inicio';
            break;
        case 'politica_nacional.html':
            activeNavId = 'nav-politica';
            activeFooterId = 'footer-politica';
            break;
        case 'economia_negocios.html':
            activeNavId = 'nav-economia';
            activeFooterId = 'footer-economia';
            break;
        case 'cultura_lazer_sociedade.html':
            activeNavId = 'nav-cultura';
            activeFooterId = 'footer-cultura';
            break;
        case 'esportes.html':
            activeNavId = 'nav-esportes';
            activeFooterId = 'footer-esportes';
            break;
        case 'seguranca_meio_ambiente.html':
            activeNavId = 'nav-seguranca';
            activeFooterId = 'footer-seguranca';
            break;
        case 'paginas_amarelas.html':
            activeNavId = 'nav-amarelas';
            activeFooterId = 'footer-amarelas';
            break;
        default:
            break;
    }

    if (activeNavId) {
        const navLink = document.getElementById(activeNavId);
        if (navLink) {
            navLink.classList.add('active');
        }
    }
    if (activeFooterId) {
        const footerLink = document.getElementById(activeFooterId);
        if (footerLink) {
            footerLink.classList.add('active');
        }
    }

    // Ocultar sempre os links de administração
    const adminLinks = ['nav-criar', 'nav-massa', 'footer-criar', 'footer-massa'];
    adminLinks.forEach(id => {
        const linkElement = document.getElementById(id);
        if (linkElement) {
            linkElement.parentElement.style.display = 'none'; 
        }
    });
    // --- FIM DA LÓGICA DO common_scripts.js ---


    // --- LÓGICA PARA CARREGAR O HEADER E FOOTER EM TODAS AS PÁGINAS ---
    function loadHeaderAndFooter() {
        fetch('header.html')
            .then(response => response.text())
            .then(data => {
                const tempDiv = document.createElement('div');
                tempDiv.innerHTML = data;

                // Carrega o menu principal (para desktop)
                const mainNav = tempDiv.querySelector('.main-nav');
                if (mainNav) {
                    // Limpa o placeholder antes de adicionar para evitar duplicação
                    document.getElementById('main-nav-placeholder').innerHTML = ''; 
                    document.getElementById('main-nav-placeholder').appendChild(mainNav);
                }

                // Carrega o menu do rodapé (para mobile)
                const footerNav = tempDiv.querySelector('.footer-nav');
                if (footerNav) {
                    // Limpa o placeholder antes de adicionar
                    document.getElementById('footer-nav-placeholder').innerHTML = '';
                    document.getElementById('footer-nav-placeholder').appendChild(footerNav);
                }
            })
            .catch(error => console.error('Erro ao carregar o cabeçalho/rodapé:', error));
    }
    // --- FIM DA LÓGICA DE CARREGAMENTO DO HEADER/FOOTER ---


    // --- LÓGICA ESPECÍFICA DE CADA PÁGINA (Antes eram arquivos JS separados) ---
    // Usamos 'currentPath' (definido acima) para saber qual lógica executar

    if (currentPath === 'index.html' || currentPath === '') {
        // Lógica do index_page.js
        loadHeaderAndFooter(); // Carrega o header/footer primeiro
        fetch('noticias_db.html')
            .then(response => response.text())
            .then(data => {
                const parser = new DOMParser();
                const doc = parser.parseFromString(data, 'text/html');
                const allNews = doc.querySelectorAll('.news-item-expandable');
                const newsContainer = document.getElementById('news-container');

                allNews.forEach(newsItem => {
                    const clonedNewsItem = newsItem.cloneNode(true);
                    
                    const dbNavLinks = clonedNewsItem.querySelector('.nav-links');
                    if (dbNavLinks) {
                        dbNavLinks.remove();
                    }

                    const detailsElement = clonedNewsItem.querySelector('details');
                    if (detailsElement) {
                        detailsElement.removeAttribute('open'); // Garante que não tenha o atributo 'open'

                        const sourceLinkDiv = document.createElement('div');
                        sourceLinkDiv.classList.add('news-full-link-container');
                        const sourceLink = document.createElement('a');
                        sourceLink.href = `noticias_db.html#${newsItem.id}`;
                        sourceLink.textContent = 'Ver notícia completa';
                        sourceLinkDiv.appendChild(sourceLink);

                        clonedNewsItem.insertBefore(sourceLinkDiv, detailsElement);
                    }
                    newsContainer.appendChild(clonedNewsItem);
                });
            })
            .catch(error => console.error('Erro ao carregar as notícias na página inicial:', error));

    } else if (currentPath === 'noticias_db.html') {
        // Lógica do noticias_db_page.js
        loadHeaderAndFooter(); // Carrega o header/footer primeiro
        
        function displayNewsFromHashLocal() {
            const hash = window.location.hash.substring(1);
            const allNewsItems = document.querySelectorAll('.news-db-item');
            const newsTitle = document.getElementById('full-news-title');
            
            let foundNews = false;

            if (hash) {
                allNewsItems.forEach(item => {
                    if (item.id === hash) {
                        item.style.display = 'block';
                        item.querySelector('details').open = true; // Mantém aberto para notícia completa
                        const newsHeading = item.querySelector('h3');
                        if (newsHeading) {
                            document.title = `Portal BM - ${newsHeading.textContent}`;
                            if (newsTitle) {
                                newsTitle.textContent = newsHeading.textContent;
                            }
                        }
                        foundNews = true;
                    } else {
                        item.style.display = 'none';
                    }
                });
            } 

            if (!foundNews) {
                window.location.href = 'index.html';
            }

            setTimeout(() => {
                document.querySelectorAll('.news-db-item[style*="display: block"] .db-back-button').forEach(button => {
                    button.removeEventListener('click', window.handleBackButtonClick);
                    if (typeof window.handleBackButtonClick === 'function') {
                        button.addEventListener('click', window.handleBackButtonClick);
                    } else {
                        console.error("Erro: window.handleBackButtonClick não está definida.");
                    }
                });
            }, 100);
        }

        displayNewsFromHashLocal();
        window.addEventListener('hashchange', displayNewsFromHashLocal);

    } else {
        // Lógica para as páginas de categoria (politica_nacional.html, economia_negocios.html, etc.)
        // Refatoramos para uma função genérica para evitar repetição massiva
        loadHeaderAndFooter(); // Carrega o header/footer primeiro

        let categoryToFilter = '';
        switch (currentPath) {
            case 'politica_nacional.html':
                categoryToFilter = 'politica_nacional';
                break;
            case 'economia_negocios.html':
                categoryToFilter = 'economia_negocios';
                break;
            case 'cultura_lazer_sociedade.html':
                categoryToFilter = 'cultura_lazer_sociedade';
                break;
            case 'esportes.html':
                categoryToFilter = 'esportes';
                break;
            case 'seguranca_meio_ambiente.html':
                categoryToFilter = 'seguranca_meio_ambiente';
                break;
            case 'paginas_amarelas.html':
                categoryToFilter = 'paginas_amarelas';
                break;
            default:
                break;
        }

        if (categoryToFilter) { // Se for uma página de categoria válida
            fetch('noticias_db.html')
                .then(response => response.text())
                .then(data => {
                    const parser = new DOMParser();
                    const doc = parser.parseFromString(data, 'text/html');
                    const allNews = doc.querySelectorAll('.news-item-expandable');
                    const newsContainer = document.getElementById('news-container');

                    allNews.forEach(newsItem => {
                        if (newsItem.dataset.category === categoryToFilter) { 
                            const clonedNewsItem = newsItem.cloneNode(true);
                            
                            const dbNavLinks = clonedNewsItem.querySelector('.nav-links');
                            if (dbNavLinks) {
                                dbNavLinks.remove();
                            }

                            const detailsElement = clonedNewsItem.querySelector('details');
                            if (detailsElement) {
                                detailsElement.removeAttribute('open'); // Garante que não tenha o atributo 'open'

                                const sourceLinkDiv = document.createElement('div');
                                sourceLinkDiv.classList.add('news-full-link-container');
                                const sourceLink = document.createElement('a');
                                sourceLink.href = `noticias_db.html#${newsItem.id}`;
                                sourceLink.textContent = 'Ver notícia completa';
                                sourceLinkDiv.appendChild(sourceLink);

                                clonedNewsItem.insertBefore(sourceLinkDiv, detailsElement);
                            }
                            newsContainer.appendChild(clonedNewsItem);
                        }
                    });
                })
                .catch(error => console.error(`Erro ao carregar notícias para ${categoryToFilter}:`, error));
        }
    }
});
EOF

echo "Gerando style.css..."
cat << 'EOF' > "$OUTPUT_DIR/style.css"
/* style.css */

/* Estilos Globais */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f4f4f4;
    color: #333;
    line-height: 1.6;
}

.container {
    width: 90%;
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px 0;
}

/* Estilos de Cabeçalho */
header {
    background-color: #333;
    color: white;
    padding: 1rem 0;
    text-align: center;
}

header h1 {
    margin: 0;
    font-size: 2.5rem;
}

header p {
    margin: 0.5rem 0;
    font-size: 1.1rem;
}

/* Menu Principal (Desktop) */
.main-nav ul {
    list-style: none;
    padding: 0;
    margin: 1rem 0 0; /* Espaçamento abaixo do título */
    display: flex; /* Para itens lado a lado no desktop */
    justify-content: center;
    flex-wrap: wrap; /* Permite que os itens quebrem a linha se não couberem */
}

.main-nav ul li {
    margin: 0 10px;
}

.main-nav ul li a {
    color: white;
    text-decoration: none;
    font-weight: bold;
    padding: 5px 10px;
    border-radius: 5px;
    transition: background-color 0.3s ease;
}

.main-nav ul li a:hover,
.main-nav ul li a.active {
    background-color: #555;
}

/* Oculta o menu do rodapé por padrão (só aparecerá em mobile) */
.footer-nav {
    display: none; 
}

/* Estilos de Rodapé */
footer {
    background-color: #333;
    color: white;
    text-align: center;
    padding: 1rem 0;
    margin-top: 2rem; /* Espaçamento entre o conteúdo principal e o rodapé */
}

footer p {
    margin-bottom: 0.5rem;
    font-size: 0.9rem;
}

.footer-nav ul {
    list-style: none;
    padding: 0;
    margin: 1rem 0 0;
    /* No desktop, este menu ficará oculto, então os estilos de flexbox não importam aqui. */
}

.footer-nav ul li {
    margin-bottom: 5px; /* Espaçamento entre os itens na pilha */
}

.footer-nav ul li a {
    color: white;
    text-decoration: none;
    font-weight: bold;
    padding: 5px 10px;
    border-radius: 5px;
    transition: background-color 0.3s ease;
    display: block; /* Ocupa a largura total para cada item da pilha */
}

.footer-nav ul li a:hover,
.footer-nav ul li a.active {
    background-color: #555;
}

/* Estilos do Banner */
.banner-section {
    text-align: center;
    padding: 20px;
    background-color: #fff;
    border-bottom: 1px solid #ddd;
}

.banner-section img.main-banner {
    max-width: 100%;
    height: auto;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
}

.banner-text {
    margin-top: 15px;
    font-size: 1.2rem;
    color: #555;
}

/* Estilos da Seção Principal */
main {
    padding: 20px;
    max-width: 1200px;
    margin: 20px auto;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.category h2 {
    color: #333;
    border-bottom: 2px solid #eee;
    padding-bottom: 10px;
    margin-bottom: 20px;
    text-align: center;
}

/* Estilos das Notícias (Expandable - Resumo e Completo) */
.news-item-expandable {
    background-color: #f9f9f9;
    border: 1px solid #ddd;
    border-radius: 8px;
    margin-bottom: 15px;
    overflow: hidden; /* Garante que o conteúdo de details/summary não vaze */
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);
}

.news-item-expandable summary {
    cursor: pointer;
    padding: 15px;
    background-color: #eee;
    font-weight: bold;
    border-bottom: 1px solid #ddd;
    display: block; /* Garante que toda a área da summary é clicável */
}

.news-item-expandable summary::-webkit-details-marker {
    display: none; /* Esconde a setinha padrão do Chrome */
}

.news-item-expandable summary:before {
    content: '▶'; /* Seta para indicar fechado */
    display: inline-block;
    margin-right: 10px;
    transition: transform 0.2s ease;
}

.news-item-expandable[open] summary:before {
    content: '▼'; /* Seta para indicar aberto */
    transform: rotate(90deg); /* Rotaciona a seta quando aberto */
}

.news-item-expandable h3 {
    margin: 0 0 5px 0;
    color: #0056b3;
    font-size: 1.3rem;
    display: inline-block; /* Para que a seta não afete o título */
}

.news-item-expandable .meta-info {
    font-size: 0.85rem;
    color: #666;
    margin-bottom: 10px;
}

.news-item-expandable .summary-text {
    font-size: 0.95rem;
    color: #444;
    margin-top: 10px;
}

.news-item-expandable .news-content {
    padding: 15px;
    border-top: 1px solid #eee; /* Linha divisória para conteúdo expandido */
}

.news-item-expandable .news-content p {
    margin-bottom: 10px;
}

.news-item-expandable .news-full-link-container {
    text-align: right;
    padding: 10px 15px 5px;
    background-color: #f0f0f0;
    border-top: 1px solid #ddd;
    border-bottom-left-radius: 8px;
    border-bottom-right-radius: 8px;
}

.news-item-expandable .news-full-link-container a {
    color: #007bff;
    text-decoration: none;
    font-weight: bold;
    transition: color 0.3s ease;
}

.news-item-expandable .news-full-link-container a:hover {
    color: #0056b3;
    text-decoration: underline;
}

/* Estilos específicos para noticias_db.html */
.news-db-item {
    display: none; /* Oculta todas por padrão no DB */
    margin-bottom: 20px;
}

.full-news-display h2 {
    margin-bottom: 30px;
}

.news-db-item .news-content {
    border-top: none; /* Remove a linha superior no conteúdo expandido do DB */
    padding-top: 0;
}

.news-db-item .nav-links {
    margin-top: 20px;
    padding-top: 15px;
    border-top: 1px solid #eee;
    display: flex; /* Para alinhar botões/links */
    justify-content: space-between; /* Espaço entre eles */
    align-items: center;
}

.news-db-item .nav-links .db-back-button,
.news-db-item .nav-links .db-back-home-button {
    background-color: #007bff;
    color: white;
    padding: 10px 15px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 1rem;
    text-decoration: none; /* Para o link */
    display: inline-block; /* Para o link */
    transition: background-color 0.3s ease;
}

.news-db-item .nav-links .db-back-button:hover,
.news-db-item .nav-links .db-back-home-button:hover {
    background-color: #0056b3;
}

/* Estilos para páginas de administração (criar_noticia, publicacao_massa) */
.admin-page {
    text-align: center;
    padding: 50px 20px;
    min-height: 400px; /* Para garantir que o rodapé não suba muito */
}

.admin-page h2 {
    color: #0056b3;
    margin-bottom: 20px;
}

.admin-page p {
    font-size: 1.1rem;
    color: #555;
}

/* Media Queries para Mobile */
@media (max-width: 768px) { /* Exemplo: telas menores que 768px (tablets e celulares) */
    header h1 {
        font-size: 2rem;
    }

    header p {
        font-size: 1rem;
    }

    /* Oculta o menu principal no cabeçalho em mobile */
    .main-nav {
        display: none;
    }

    /* Exibe o menu do rodapé em mobile e o formata em pilha */
    .footer-nav {
        display: block; /* Torna o menu visível no rodapé */
        margin-top: 1rem;
    }

    .footer-nav ul {
        display: flex;
        flex-direction: column; /* Coloca os itens em pilha */
        align-items: center; /* Centraliza os itens na pilha */
        gap: 5px; /* Espaçamento entre os itens */
        padding: 0 1rem; /* Padding nas laterais se necessário */
    }

    .footer-nav ul li {
        width: 100%; /* Faz cada item ocupar a largura total do container do menu */
        text-align: center; /* Centraliza o texto dentro de cada item */
        margin: 0; /* Remove margens extras se houverem */
    }
    
    .footer-nav ul li a {
        padding: 10px; /* Aumenta o padding para facilitar o toque */
    }

    /* Ajustes para o banner e conteúdo principal em mobile */
    .banner-section {
        padding: 15px;
    }

    .banner-section img.main-banner {
        width: 100%;
        height: auto;
    }

    .banner-text {
        font-size: 0.9rem;
        padding: 0 1rem;
    }

    main {
        padding: 1rem;
        margin: 15px auto;
    }

    .category h2 {
        font-size: 1.8rem;
    }

    .news-item-expandable {
        margin-bottom: 10px;
    }

    .news-item-expandable summary {
        padding: 12px;
    }

    .news-item-expandable h3 {
        font-size: 1.1rem;
    }

    .news-item-expandable .meta-info {
        font-size: 0.8rem;
    }

    .news-item-expandable .summary-text {
        font-size: 0.9rem;
    }

    .news-item-expandable .news-content {
        padding: 12px;
    }

    .news-db-item .nav-links {
        flex-direction: column; /* Botões um abaixo do outro no mobile */
        gap: 10px;
    }

    .news-db-item .nav-links .db-back-button,
    .news-db-item .nav-links .db-back-home-button {
        width: calc(100% - 30px); /* Ajusta largura com padding */
        text-align: center;
    }
}
EOF

echo "Gerando index.html..."
cat << 'EOF' > "$OUTPUT_DIR/index.html"
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Portal BM - Seu Portal de Notícias</title>
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
        <p class="banner-text">Bem-vindo ao Portal BM! Fique por dentro das últimas notícias.</p>
    </section>

    <main>
        <section class="category home-news">
            <h2>Destaques do Dia</h2>
            
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

echo "Gerando politica_nacional.html..."
cat << 'EOF' > "$OUTPUT_DIR/politica_nacional.html"
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Portal BM - Política Nacional</title>
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
        <p class="banner-text">Acompanhe as últimas notícias sobre Política Nacional.</p>
    </section>

    <main>
        <section class="category">
            <h2>Política Nacional</h2>
            <div id="news-container"></div>
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

echo "Gerando economia_negocios.html..."
cat << 'EOF' > "$OUTPUT_DIR/economia_negocios.html"
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Portal BM - Economia e Negócios</title>
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
        <p class="banner-text">Fique por dentro das últimas notícias sobre Economia e Negócios.</p>
    </section>

    <main>
        <section class="category">
            <h2>Economia e Negócios</h2>
            <div id="news-container"></div>
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

echo "Gerando cultura_lazer_sociedade.html..."
cat << 'EOF' > "$OUTPUT_DIR/cultura_lazer_sociedade.html"
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Portal BM - Cultura, Lazer e Sociedade</title>
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
        <p class="banner-text">Explore as novidades em Cultura, Lazer e Sociedade.</p>
    </section>

    <main>
        <section class="category">
            <h2>Cultura, Lazer e Sociedade</h2>
            <div id="news-container"></div>
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

echo "Gerando esportes.html..."
cat << 'EOF' > "$OUTPUT_DIR/esportes.html"
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Portal BM - Esportes</title>
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
        <p class="banner-text">As últimas notícias do mundo dos Esportes.</p>
    </section>

    <main>
        <section class="category">
            <h2>Esportes</h2>
            <div id="news-container"></div>
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

echo "Gerando seguranca_meio_ambiente.html..."
cat << 'EOF' > "$OUTPUT_DIR/seguranca_meio_ambiente.html"
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Portal BM - Segurança e Meio Ambiente</title>
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
        <p class="banner-text">Notícias sobre Segurança e Meio Ambiente.</p>
    </section>

    <main>
        <section class="category">
            <h2>Segurança e Meio Ambiente</h2>
            <div id="news-container"></div>
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

echo "Gerando paginas_amarelas.html..."
cat << 'EOF' > "$OUTPUT_DIR/paginas_amarelas.html"
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Portal BM - Páginas Amarelas</title>
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
        <p class="banner-text">Leia nossas Páginas Amarelas e perfis exclusivos.</p>
    </section>

    <main>
        <section class="category">
            <h2>Páginas Amarelas</h2>
            <div id="news-container"></div>
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

echo "Gerando criar_noticia.html..."
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

echo "Gerando publicacao_massa.html..."
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

echo "Gerando noticias_db.html..."
cat << 'EOF' > "$OUTPUT_DIR/noticias_db.html"
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Portal BM - Notícia Completa</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <header>
        <h1>Portal BM</h1>
        <p>As notícias mais importantes do dia, reunidas em um só lugar.</p>
    </header>

    <div id="main-nav-placeholder"></div>

    <main>
        <section class="category full-news-display">
            <h2 id="full-news-title">Notícia Completa</h2> 
            
            <div id="full-news-container">
                <article class="news-item-expandable news-db-item" id="noticia-lula-trump" data-category="politica_nacional">
                    <details>
                        <summary>
                            <h3>Lula Cogita Encontro com Trump para Preservar Relações Comerciais</h3>
                            <p class="meta-info">Por **Mariana Reis** (O Globo)</p>
                            <p class="summary-text">O presidente Luiz Inácio Lula da Silva está avaliando a possibilidade de um encontro com o ex-presidente dos Estados Unidos, Donald Trump, caso este retorne à Casa Branca, visando preservar relações comerciais e econômicas estratégicas para o Brasil.</p>
                        </summary>
                        <div class="news-content">
                            <p>A medida, considerada pragimática, busca assegurar que a relação bilateral não seja prejudicada por divergências ideológicas. Fontes do Itamaraty indicam que o governo brasileiro está monitorando de perto o cenário eleitoral americano e se preparando para qualquer desfecho, priorizando os interesses econômicos e comerciais do país.</p>
                            <p>Um eventual encontro demonstraria a disposição do Brasil em manter uma política externa de Estado, capaz de dialogar com diferentes espectros políticos globais em benefício do desenvolvimento nacional.</p>
                            <div class="nav-links">
                                <a href="index.html" class="db-back-home-button">Voltar para a Página Inicial</a>
                                <button class="db-back-button">Voltar para a Página Anterior</button> 
                            </div>
                        </div>
                    </details>
                </article>

                <article class="news-item-expandable news-db-item" id="noticia-fabcaro-asterix" data-category="cultura_lazer_sociedade">
                    <details>
                        <summary>
                            <h3>Conversa com Fabcaro: O Novo Roteirista de Asterix e Obelix e a Magia de "A Íris Branca"</h3>
                            <p class="meta-info">Por **Isabelle Marat** (Le Monde)</p>
                            <p class="summary-text">Fabcaro, o aclamado novo roteirista de Asterix e Obelix, compartilha insights sobre seu trabalho no álbum "A Íris Branca" e os desafios de manter o tone clássico e o humor da icônica série francesa.</p>
                        </summary>
                        <div class="news-content">
                            <p>Em entrevista exclusiva, Fabcaro revelou sua paixão pelos personagens e a responsabilidade de dar continuidade a um legado tão amado.</p>
                            <p>Nesse álbum, Fabcaro explora temas contemporâneos de forma sutil e divertida, provando que Asterix e Obelix continuam relevantes para novas gerações.</p>
                            <div class="nav-links">
                                <a href="index.html" class="db-back-home-button">Voltar para a Página Inicial</a>
                                <button class="db-back-button">Voltar para a Página Anterior</button>
                            </div>
                        </div>
                    </details>
                </article>

                <article class="news-item-expandable news-db-item" id="noticia-tarifas-eua" data-category="economia_negocios">
                    <details>
                        <summary>
                            <h3>Missão Difícil: Esforços para Conter os Danos do Tarifaço Americano nas Exportações Brasileiras</h3>
                            <p class="meta-info">Por **Fernando Costa** (Folha de S.Paulo)</p>
                            <p class="summary-text">Detalhes sobre os complexos esforços para mitigar os impactos das recentes tarifas impostas por Donald Trump sobre produtos brasileiros, que ameaçam diversos setores e empresas exportadoras do país.</p>
                        </summary>
                        <div class="news-content">
                            <p>A equipe econômica brasileira tem trabalhado em diversas frentes, incluindo negociações diplomáticas e busca por novos mercados, para minimizar os prejuízos. Setores como o agronegócio e a indústria manufatureira, que dependem significativamente do mercado americano, estão entre os mais preocupados.</p>
                            <p>Analistas apontam que a situação exige uma estratégia multifacetada, combinando resiliência interna com proatividade na busca por acordos comerciais alternativos.</p>
                            <div class="nav-links">
                                <a href="index.html" class="db-back-home-button">Voltar para a Página Inicial</a>
                                <button class="db-back-button">Voltar para a Página Anterior</button>
                            </div>
                        </div>
                    </details>
                </article>

                <article class="news-item-expandable news-db-item" id="noticia-polarizacao-brasil" data-category="politica_nacional">
                    <details>
                        <summary>
                            <h3>O Veneno da Polarização no Brasil: Reflexões sobre o Debate Nacional</h3>
                            <p class="meta-info">Por **João Almeida**</p>
                            <p class="summary-text">A polarização política no Brasil continua a ser um obstáculo significativo para o debate construtivo sobre questões cruciais do país, afetando a capacidade de encontrar soluções e gerar consenso entre diferentes setores da sociedade.</p>
                        </summary>
                        <div class="news-content">
                            <p>Recentemente, especialistas têm apontado para a intensificação dos discursos extremos, tanto à direita quanto à esquerda, o que tem dificultado a formação de um ambiente propício para discussões democráticas e inclusivas. A disseminação de notícias falsas e a tribalização das redes sociais contribuem para esse cenário, onde o diálogo é substituído por ataques pessoais e desqualificação do oponente.</p>
                            <p>A consequência direta é a paralisia em pautas importantes e a dificuldade em construir pontes. A superação desse desafio exige um esforço conjunto de lideranças políticas, meios de comunicação e da própria sociedade civil para promover a tolerância, o respeito às diferenças e a valorização do debate baseado em fatos.</p>
                            <div class="nav-links">
                                <a href="index.html" class="db-back-home-button">Voltar para a Página Inicial</a>
                                <button class="db-back-button">Voltar para a Página Anterior</button>
                            </div>
                        </div>
                    </details>
                </article>

                <article class="news-item-expandable news-db-item" id="noticia-david-ricks" data-category="paginas_amarelas">
                    <details>
                        <summary>
                            <h3>Entrevista Exclusiva com David Ricks: O "Doutor Mounjaro" e a Luta Contra a Obesidade</h3>
                            <p class="meta-info">Por **Revista Veja**</p>
                            <p class="summary-text">O CEO da Eli Lilly, David Ricks, conhecido como "Doutor Mounjaro", detalha os planos ambiciosos da farmacêutica para erradicar a obesidade e sua busca incessante por medicamentos inovadores, incluindo uma promissora droga para Alzheimer.</p>
                        </summary>
                        <div class="news-content">
                            <p>Na entrevista exclusiva, Ricks discute a importância de abordagens multifacetadas para a obesidade, combinando medicação com mudanças no estilo de vida. Ele também compartilha insights sobre os desafios e as oportunidades no desenvolvimento de novas terapias para doenças crônicas, e a visão da Eli Lilly para o futuro da saúde global.</p>
                            <h4>Principais pontos da entrevista:</h4>
                            <ul>
                                <li>**Mounjaro e Zepbound:** Ricks enfatiza o impacto dessas drogas no tratamento da obesidade e diabetes tipo 2, destacando que elas são mais do que "medicamentos para emagrecer", mas sim para tratar uma doença crônica complexa.</li>
                                <li>**Estratégia de Longo Prazo:** A Eli Lilly está comprometida com a pesquisa e desenvolvimento contínuos de novas moléculas para obesidade, com o objetivo de oferecer opções mais variadas e eficazes.</li>
                                <li>**Pesquisa em Alzheimer:** Embora o foco principal seja obesidade, a empresa tem uma droga promissora em testes para Alzheimer, o que demonstra a amplitude de sua pesquisa farmacêutica. Ricks ressalta a importância de encontrar soluções para doenças neurodegenerativas.</li>
                                <li>**Acessibilidade e Preço:** A entrevista aborda os desafios de acessibilidade e o custo dos novos medicamentos, e a Eli Lilly está buscando estratégias para tornar as terapias mais amplamente disponíveis.</li>
                                <li>**Inovação e Futuro:** Ricks expressa otimismo sobre o futuro da medicina e a capacidade da indústria farmacêutica de transformar a vida das pessoas, através da ciência e da inovação contínua.</li>
                            </ul>
                            <div class="nav-links">
                                <a href="index.html" class="db-back-home-button">Voltar para a Página Inicial</a>
                                <button class="db-back-button">Voltar para a Página Anterior</button>
                            </div>
                        </div>
                    </details>
                </article>

                <article class="news-item-expandable news-db-item" id="noticia-gaza-desespero" data-category="seguranca_meio_ambiente">
                    <details>
                        <summary>
                            <h3>Imagem da Semana: O Retrato do Desespero na Faixa de Gaza</h3>
                            <p class="meta-info">Por **Agência Reuters**</p>
                            <p class="summary-text">A escassez de itens básicos e a dramática situação humanitária na Faixa de Gaza é ilustrada pela comovente imagem que se tornou o retrato do desespero em uma região assolada pela crise.</p>
                        </summary>
                        <div class="news-content">
                            <p>A fotografia, capturada por um fotojornalista local, mostra uma criança em meio a escombros, simbolizando a urgência da ajuda internacional.</p>
                            <p>Organizações humanitárias têm alertado para a deterioração das condições de vida, com a falta de água potável, alimentos e medicamentos afetando milhões de pessoas. A imagem serve como um lembrete contundente da necessidade de ações imediatas para aliviar o sofrimento da população e buscar soluções duradouras para o conflito na região.</p>
                            <div class="nav-links">
                                <a href="index.html" class="db-back-home-button">Voltar para a Página Inicial</a>
                                <button class="db-back-button">Voltar para a Página Anterior</button>
                            </div>
                        </div>
                    </details>
                </article>

                <article class="news-item-expandable news-db-item" id="noticia-culinaria-grega" data-category="cultura_lazer_sociedade">
                    <details>
                        <summary>
                            <h3>Tradição e Modernidade na Culinária Grega em São Paulo: Um Passeio pelos Sabores do Mediterrâneo</h3>
                            <p class="meta-info">Por **Ana Paula Viveiros** (Estadão)</p>
                            <p class="summary-text">A cena gastronômica grega em São Paulo oferece uma rica fusão de tradição e modernidade, com estabelecimentos que celebram a riqueza de ingredientes frescos e temperos marcantes, como o Acropolis e Prato Grego.</p>
                        </summary>
                        <div class="news-content">
                            <p>De pratos clássicos como o Moussaka e Souvlaki, a inovações que reinventam a culinária mediterrânea, os restaurantes gregos da capital paulista convidam a uma viagem de sabores e aromas, proporcionando uma experiência autêntica e inesquecível para os amantes da boa mesa.</p>
                            <div class="nav-links">
                                <a href="index.html" class="db-back-home-button">Voltar para a Página Inicial</a>
                                <button class="db-back-button">Voltar para a Página Anterior</button>
                            </div>
                        </div>
                    </details>
                </article>

                <article class="news-item-expandable news-db-item" id="noticia-olimpiadas-paris" data-category="esportes">
                    <details>
                        <summary>
                            <h3>Olimpíadas de Paris: Expectativas para as medalhas brasileiras</h3>
                            <p class="meta-info">Por **Maria Clara Pires** (GE)</p>
                            <p class="summary-text">Com a proximidade dos Jogos Olímpicos de Paris, a delegação brasileira intensifica os treinos e a preparação final. As expectativas são altas em diversas modalidades, com atletas buscando superar seus próprios recordes e trazer medalhas para casa.</p>
                        </summary>
                        <div class="news-content">
                            <p>Nesta análise, destacamos os esportes e os atletas com maior potencial de pódio, considerando o desempenho recente em competições internacionais e o nível de preparação. A torcida brasileira se prepara para vibrar a cada prova.</p>
                            <div class="nav-links">
                                <a href="index.html" class="db-back-home-button">Voltar para a Página Inicial</a>
                                <button class="db-back-button">Voltar para a Página Anterior</button>
                            </div>
                        </div>
                    </details>
                </article>

                <article class="news-item-expandable news-db-item" id="noticia-brasileirao" data-category="esportes">
                    <details>
                        <summary>
                            <h3>Brasileirão: Análise dos favoritos e surpresas da rodada</h3>
                            <p class="meta-info">Por **Lucas Silva** (Lance!)</p>
                            <p class="summary-text">Com o campeonato pegando fogo, a última rodada do Brasileirão trouxe resultados inesperados e consolidou a posição de alguns favoritos ao título.</p>
                        </summary>
                        <div class="news-content">
                            <p>Analisamos os destaques, as táticas que funcionaram e as performances individuais que chamaram a atenção.</p>
                            <p>Times que vinham em baixa conseguiram reverter o quadro, enquanto gigantes tropeçaram, deixando o cenário ainda mais imprevisível. A briga pela liderança e contra o rebaixamento promete emoção até o fim.</p>
                            <div class="nav-links">
                                <a href="index.html" class="db-back-home-button">Voltar para a Página Inicial</a>
                                <button class="db-back-button">Voltar para a Página Anterior</button>
                            </div>
                        </div>
                    </details>
                </article>

                <article class="news-item-expandable news-db-item" id="noticia-maria-silva" data-category="paginas_amarelas">
                    <details>
                        <summary>
                            <h3>Perfil: Maria Silva, a Influenciadora que Transformou a Jardinagem em Paixão Nacional</h3>
                            <p class="meta-info">Por **Júlia Martins** (Casa e Jardim)</p>
                            <p class="summary-text">Conheça a história de Maria Silva, a influenciadora digital que saiu do anonimato para se tornar a voz da jardinagem no Brasil.</p>
                        </summary>
                        <div class="news-content">
                            <p>Com dicas práticas e um carisma contagiante, ela conquistou milhões de seguidores e transformou a forma como muitos brasileiros veem o cultivo de plantas.</p>
                            <p>Em sua entrevista exclusiva, Maria compartilha sua jornada, desde o primeiro vaso de suculentas até o império digital que construiu. Ela discute a importância da conexão com a natureza, os desafios de ser uma criadora de conteúdo e seus planos futuros para expandir seu alcance e impactar ainda mais vidas.</p>
                            <div class="nav-links">
                                <a href="index.html" class="db-back-home-button">Voltar para a Página Inicial</a>
                                <button class="db-back-button">Voltar para a Página Anterior</button>
                            </div>
                        </div>
                    </details>
                </article>
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

echo "Todos os arquivos foram gerados no diretório '$OUTPUT_DIR'."
echo "Para atualizar sua base no GitHub:"
echo "1. Copie o conteúdo do diretório '$OUTPUT_DIR' para a raiz do seu repositório Git."
echo "   Exemplo: cp -r $OUTPUT_DIR/* ./"
echo "2. Adicione as mudanças: git add ."
echo "3. Faça um commit: git commit -m \"Atualiza arquivos com as últimas versões e correção de formatação\""
echo "4. Envie para o GitHub: git push origin main (ou o nome da sua branch principal)"
echo "Lembre-se de remover os arquivos .js antigos (como common_scripts.js, etc.) se eles ainda existirem na sua raiz."

