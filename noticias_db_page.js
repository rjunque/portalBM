// noticias_db_page.js

document.addEventListener('DOMContentLoaded', function() {
    // Carrega o header.html para os menus (apenas o HTML)
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
        .catch(error => console.error('Erro ao carregar o cabeçalho:', error));

    // --- LÓGICA ESPECÍFICA PARA noticias_db.html (exibir notícia por hash) ---
    function displayNewsFromHashLocal() {
        const hash = window.location.hash.substring(1); // Remove o '#'
        const allNewsItems = document.querySelectorAll('.news-db-item');
        const newsTitle = document.getElementById('full-news-title');
        
        let foundNews = false;

        if (hash) {
            allNewsItems.forEach(item => {
                if (item.id === hash) {
                    item.style.display = 'block'; // Mostra a notícia específica
                    item.querySelector('details').open = true; // Garante que esteja expandida
                    const newsHeading = item.querySelector('h3');
                    if (newsHeading) {
                        document.title = `Portal BM - ${newsHeading.textContent}`;
                        if (newsTitle) {
                            newsTitle.textContent = newsHeading.textContent;
                        }
                    }
                    foundNews = true;
                } else {
                    item.style.display = 'none'; // Oculta as outras
                }
            });
        } 

        if (!foundNews) {
            // Se não há hash ou a notícia não foi encontrada, redireciona para a página inicial
            window.location.href = 'index.html';
        }

        // --- Adiciona o event listener APÓS a notícia ser exibida e os botões estarem no DOM ---
        setTimeout(() => {
            // Seleciona *todos* os botões de "Voltar para a Página Anterior" visíveis
            document.querySelectorAll('.news-db-item[style*="display: block"] .db-back-button').forEach(button => {
                // Remove qualquer listener anterior para evitar duplicação (importante em hashchange)
                button.removeEventListener('click', window.handleBackButtonClick);
                
                // Adiciona o novo listener
                if (typeof window.handleBackButtonClick === 'function') {
                    button.addEventListener('click', window.handleBackButtonClick);
                } else {
                    console.error("Erro: window.handleBackButtonClick não está definida. Verifique common_scripts.js.");
                }
            });
        }, 100); // Pequeno atraso para garantir que o DOM esteja completamente atualizado
    }

    // Chama a função na carga inicial da página e ouve mudanças no hash
    displayNewsFromHashLocal();
    window.addEventListener('hashchange', displayNewsFromHashLocal);
});