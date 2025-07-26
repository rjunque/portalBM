// seguranca_meio_ambiente_page.js

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

    // Lógica para carregar, filtrar e exibir as notícias desta categoria
    fetch('noticias_db.html')
        .then(response => response.text())
        .then(data => {
            const parser = new DOMParser();
            const doc = parser.parseFromString(data, 'text/html');
            const allNews = doc.querySelectorAll('.news-item-expandable');
            const newsContainer = document.getElementById('news-container');

            allNews.forEach(newsItem => {
                if (newsItem.dataset.category === 'seguranca_meio_ambiente') { // <-- Mude para a categoria correta
                    const clonedNewsItem = newsItem.cloneNode(true);
                    
                    const dbNavLinks = clonedNewsItem.querySelector('.nav-links');
                    if (dbNavLinks) {
                        dbNavLinks.remove();
                    }

                    const detailsElement = clonedNewsItem.querySelector('details');
                    if (detailsElement) {
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
        .catch(error => console.error('Erro ao carregar as notícias:', error));
});