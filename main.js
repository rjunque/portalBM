// main.js

document.addEventListener('DOMContentLoaded', function() {
    // --- FUNÇÃO GLOBAL PARA O BOTÃO VOLTAR (Do common_scripts.js) ---
    window.handleBackButtonClick = function(event) {
        event.preventDefault(); // Impede o comportamento padrão do botão

        if (window.history.length > 1) {
            window.history.back(); // Volta para a página anterior no histórico
        } else {
            window.location.href = 'index.html'; // Fallback para a página inicial
        }
    };
    // --- FIM DA FUNÇÃO GLOBAL PARA O BOTÃO VOLTAR ---

    // --- Lógica para ativação dos links de navegação e visibilidade dos links de administração (Do common_scripts.js) ---
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
    // Esta função será chamada em cada bloco de script específico da página
    function loadHeaderAndFooter() {
        fetch('header.html')
            .then(response => response.text())
            .then(data => {
                const tempDiv = document.createElement('div');
                tempDiv.innerHTML = data;

                const mainNav = tempDiv.querySelector('.main-nav');
                if (mainNav) {
                    document.getElementById('main-nav-placeholder').appendChild(mainNav);
                }

                const footerNav = tempDiv.querySelector('.footer-nav');
                if (footerNav) {
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
            // Para as páginas de admin, não há lógica de carregamento de notícias, então não precisamos delas aqui.
            // case 'criar_noticia.html':
            // case 'publicacao_massa.html':
            //    break;
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