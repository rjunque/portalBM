// common_scripts.js

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

    // Lógica para ativação dos links de navegação
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
        // As páginas de administração não terão um estado 'active' padrão,
        // nem serão tratadas para visibilidade aqui se quisermos ocultá-las sempre.
        // case 'criar_noticia.html':
        //     activeNavId = 'nav-criar';
        //     activeFooterId = 'footer-criar';
        //     break;
        // case 'publicacao_massa.html':
        //     activeNavId = 'nav-massa';
        //     activeFooterId = 'footer-massa';
        //     break;
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

    // --- Lógica para visibilidade dos links de administração (ALTERADO AQUI) ---
    // Remova ou comente as linhas abaixo para ocultar sempre esses links.
    const adminLinks = ['nav-criar', 'nav-massa', 'footer-criar', 'footer-massa'];
    adminLinks.forEach(id => {
        const linkElement = document.getElementById(id);
        if (linkElement) {
            linkElement.parentElement.style.display = 'none'; // Define como 'none' para ocultar sempre
        }
    });
    // --- FIM DA ALTERAÇÃO ---
});