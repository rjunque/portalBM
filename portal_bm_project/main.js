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

    // --- LÓGICA PARA CARREGAR O HEADER E FOOTER EM TODAS AS PÁGINAS ---
    // Esta função agora retorna uma Promise para garantir que os elementos sejam carregados.
    function loadHeaderAndFooter() {
        return fetch('header.html')
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                return response.text();
            })
            .then(data => {
                const tempDiv = document.createElement('div');
                tempDiv.innerHTML = data;

                // Carrega o menu principal (para desktop)
                const mainNav = tempDiv.querySelector('.main-nav');
                const mainNavPlaceholder = document.getElementById('main-nav-placeholder');
                if (mainNav && mainNavPlaceholder) {
                    mainNavPlaceholder.innerHTML = ''; 
                    mainNavPlaceholder.appendChild(mainNav);
                } else {
                    console.warn("Elemento .main-nav ou #main-nav-placeholder não encontrado. Menus podem não carregar.");
                }

                // Carrega o menu do rodapé (para mobile)
                const footerNav = tempDiv.querySelector('.footer-nav');
                const footerNavPlaceholder = document.getElementById('footer-nav-placeholder');
                if (footerNav && footerNavPlaceholder) {
                    footerNavPlaceholder.innerHTML = '';
                    footerNavPlaceholder.appendChild(footerNav);
                } else {
                    console.warn("Elemento .footer-nav ou #footer-nav-placeholder não encontrado. Menus podem não carregar.");
                }
            })
            .catch(error => console.error('Erro ao carregar o cabeçalho/rodapé:', error));
    }
    // --- FIM DA LÓGICA DE CARREGAMENTO DO HEADER/FOOTER ---

    // --- Lógica para ativação dos links de navegação e visibilidade dos links de administração ---
    // Esta função agora espera o carregamento do header/footer
    function activateNavigationAndHideAdminLinks() {
        const currentPath = window.location.pathname.split('/').pop();
        
        let activeNavId = '';
        let activeFooterId = '';

        switch (currentPath) {
            case 'index.html':
            case '': // Para quando a URL é apenas o domínio (ex: localhost:8000/)
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
            case 'noticias_db.html': 
                // Esta página carrega uma notícia específica, não um item de menu fixo.
                break;
            default:
                // Para páginas de administração, por exemplo, não ativa menu
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

        // Ocultar sempre os links de administração (Criar Notícia, Publicação em Massa)
        const adminLinks = ['nav-criar', 'nav-massa', 'footer-criar', 'footer-massa'];
        adminLinks.forEach(id => {
            const linkElement = document.getElementById(id);
            if (linkElement) {
                // Acessa o elemento pai (o <li>) e define seu display como 'none'
                linkElement.parentElement.style.display = 'none'; 
            }
        });
    }
    // --- FIM DA LÓGICA DE ATIVAÇÃO DE LINKS ---


    // --- LÓGICA ESPECÍFICA DE CADA PÁGINA ---
    const currentPath = window.location.pathname.split('/').pop();

    // Carrega o header e footer primeiro, depois executa a lógica específica da página
    loadHeaderAndFooter().then(() => {
        activateNavigationAndHideAdminLinks(); // Ativa a navegação após o header ser carregado

        if (currentPath === 'index.html' || currentPath === '') {
            fetch('noticias_db.html')
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`HTTP error! status: ${response.status}`);
                    }
                    return response.text();
                })
                .then(data => {
                    const parser = new DOMParser();
                    const doc = parser.parseFromString(data, 'text/html');
                    const allNews = doc.querySelectorAll('.news-item-expandable'); // Seleciona todas as notícias expansíveis
                    const newsContainer = document.getElementById('news-container');

                    if (newsContainer) {
                        allNews.forEach(newsItem => {
                            const clonedNewsItem = newsItem.cloneNode(true);
                            
                            // REMOVER A CLASSE 'news-db-item' DO ITEM CLONADO NA HOME
                            clonedNewsItem.classList.remove('news-db-item');

                            // Remove links de navegação específicos do DB na Home
                            const dbNavLinks = clonedNewsItem.querySelector('.nav-links');
                            if (dbNavLinks) {
                                dbNavLinks.remove(); 
                            }

                            // Garante que a notícia não venha aberta por padrão na home
                            const detailsElement = clonedNewsItem.querySelector('details');
                            if (detailsElement) {
                                detailsElement.removeAttribute('open'); 

                                // Adiciona o link "Ver notícia completa"
                                const sourceLinkDiv = document.createElement('div');
                                sourceLinkDiv.classList.add('news-full-link-container');
                                const sourceLink = document.createElement('a');
                                sourceLink.href = `noticias_db.html#${newsItem.id}`;
                                sourceLink.textContent = 'Ver notícia completa';
                                sourceLinkDiv.appendChild(sourceLink);

                                // Insere o link antes do elemento <details>
                                clonedNewsItem.insertBefore(sourceLinkDiv, detailsElement);
                            }
                            newsContainer.appendChild(clonedNewsItem);
                        });
                    } else {
                        console.error("Erro: #news-container não encontrado na página inicial.");
                    }
                })
                .catch(error => console.error('Erro ao carregar as notícias na página inicial:', error));

        } else if (currentPath === 'noticias_db.html') {
            // Lógica para a página de exibição de notícia única
            function displayNewsFromHashLocal() {
                const hash = window.location.hash.substring(1); // Pega o ID da URL (#noticia-lula-trump)
                const allNewsItems = document.querySelectorAll('.news-db-item'); // Aqui, queremos APENAS as do DB
                const newsTitleElement = document.getElementById('full-news-title');
                
                let foundNews = false;

                if (hash) {
                    allNewsItems.forEach(item => {
                        if (item.id === hash) {
                            item.style.display = 'block'; // Mostra apenas a notícia correspondente
                            // Abre o details para a notícia completa
                            const detailsElement = item.querySelector('details');
                            if (detailsElement) {
                                detailsElement.open = true; 
                            }
                            
                            const newsHeading = item.querySelector('h3');
                            if (newsHeading) {
                                document.title = `Portal BM - ${newsHeading.textContent}`; // Atualiza o título da aba
                                if (newsTitleElement) {
                                    newsTitleElement.textContent = newsHeading.textContent; // Atualiza o H2 da página
                                }
                            }
                            foundNews = true;
                        } else {
                            item.style.display = 'none'; // Esconde as outras notícias
                        }
                    });
                } 

                if (!foundNews) {
                    // Se nenhuma notícia específica for encontrada, redireciona para a página inicial
                    console.warn(`Notícia com ID '${hash}' não encontrada. Redirecionando para a página inicial.`);
                    window.location.href = 'index.html';
                }

                // Adiciona evento ao botão de voltar após um pequeno atraso para garantir que o DOM esteja pronto
                setTimeout(() => {
                    document.querySelectorAll('.news-db-item[style*="display: block"] .db-back-button').forEach(button => {
                        button.removeEventListener('click', window.handleBackButtonClick); // Evita múltiplos listeners
                        if (typeof window.handleBackButtonClick === 'function') {
                            button.addEventListener('click', window.handleBackButtonClick);
                        } else {
                            console.error("Erro: window.handleBackButtonClick não está definida.");
                        }
                    });
                }, 100);
            }

            // Executa a função na carga da página e em mudanças de hash
            displayNewsFromHashLocal();
            window.addEventListener('hashchange', displayNewsFromHashLocal);

        } else {
            // Lógica para as páginas de categoria (politica_nacional.html, economia_negocios.html, etc.)
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
                    // Para páginas como criar_noticia.html e publicacao_massa.html, não há filtro de notícias.
                    // Não faça nada aqui para não tentar carregar notícias nessas páginas.
                    return; // Sai da função para não tentar carregar notícias
            }

            if (categoryToFilter) { // Se for uma página de categoria válida
                fetch('noticias_db.html')
                    .then(response => {
                        if (!response.ok) {
                            throw new Error(`HTTP error! status: ${response.status}`);
                        }
                        return response.text();
                    })
                    .then(data => {
                        const parser = new DOMParser();
                        const doc = parser.parseFromString(data, 'text/html');
                        const allNews = doc.querySelectorAll('.news-item-expandable');
                        const newsContainer = document.getElementById('news-container');

                        if (newsContainer) {
                            allNews.forEach(newsItem => {
                                if (newsItem.dataset.category === categoryToFilter) { 
                                    const clonedNewsItem = newsItem.cloneNode(true);
                                    
                                    // REMOVER A CLASSE 'news-db-item' DO ITEM CLONADO NA CATEGORIA
                                    clonedNewsItem.classList.remove('news-db-item');

                                    // Remove links de navegação específicos do DB na categoria
                                    const dbNavLinks = clonedNewsItem.querySelector('.nav-links');
                                    if (dbNavLinks) {
                                        dbNavLinks.remove(); 
                                    }

                                    // Garante que a notícia não venha aberta por padrão na categoria
                                    const detailsElement = clonedNewsItem.querySelector('details');
                                    if (detailsElement) {
                                        detailsElement.removeAttribute('open'); 

                                        // Adiciona o link "Ver notícia completa"
                                        const sourceLinkDiv = document.createElement('div');
                                        sourceLinkDiv.classList.add('news-full-link-container');
                                        const sourceLink = document.createElement('a');
                                        sourceLink.href = `noticias_db.html#${newsItem.id}`;
                                        sourceLink.textContent = 'Ver notícia completa';
                                        sourceLinkDiv.appendChild(sourceLink);

                                        // Insere o link antes do elemento <details>
                                        clonedNewsItem.insertBefore(sourceLinkDiv, detailsElement);
                                    }
                                    newsContainer.appendChild(clonedNewsItem);
                                }
                            });
                        } else {
                            console.error(`Erro: #news-container não encontrado na página de categoria ${categoryToFilter}.`);
                        }
                    })
                    .catch(error => console.error(`Erro ao carregar notícias para ${categoryToFilter}:`, error));
            }
        }
    });
});
