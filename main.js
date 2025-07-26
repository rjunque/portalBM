// main.js

// Dados de exemplo das notícias
// Mantenha este array como a base inicial das suas notícias.
// As novas notícias adicionadas via formulário serão salvas no localStorage
// e carregadas para esta variável 'newsData' ao iniciar.
let newsData = [
    {
        id: 1,
        title: "Governo anuncia novo pacote econômico para impulsionar o PIB",
        category: "Política Nacional",
        date: "2024-07-25",
        summary: "Medidas incluem desoneração fiscal e linhas de crédito especiais para pequenas empresas.",
        full_content: "O Ministério da Economia divulgou hoje os detalhes do novo pacote de estímulo que visa aquecer a economia brasileira. As principais ações incluem a redução de impostos para setores estratégicos, como tecnologia e energias renováveis, e a abertura de novas linhas de financiamento com juros subsidiados para micro e pequenas empresas. A expectativa é que essas iniciativas gerem milhares de novos empregos e aumentem a confiança dos investidores no país. Especialistas dividem-se sobre o impacto a longo prazo das medidas, mas a maioria concorda que são um passo importante para a recuperação econômica pós-pandemia. O presidente em exercício, durante o anúncio, reforçou o compromisso do governo com o crescimento sustentável e a melhoria da qualidade de vida dos cidadãos."
    },
    {
        id: 2,
        title: "Bolsa de Valores atinge recorde histórico impulsionada por setor de tecnologia",
        category: "Economia e Negócios",
        date: "2024-07-24",
        summary: "Empresas de tecnologia lideram valorização, atraindo novos investimentos para o mercado nacional.",
        full_content: "A B3, a Bolsa de Valores de São Paulo, fechou o pregão de hoje com um novo recorde histórico, superando a marca dos 135 mil pontos. O grande destaque foi o setor de tecnologia, com várias startups e empresas consolidadas apresentando forte valorização em suas ações. Analistas de mercado atribuem o desempenho ao crescente interesse por inovações e à digitalização acelerada dos negócios, impulsionada em parte pelos novos hábitos de consumo. Fundos de investimento internacionais têm demonstrado apetite por empresas brasileiras do ramo, o que contribui para o otimismo geral. A tendência é de que o setor continue a ser um motor de crescimento nos próximos meses, apesar de preocupações com a inflação global."
    },
    {
        id: 3,
        title: "Festival de Cultura e Arte movimenta o centro da cidade com atrações diversas",
        category: "Cultura, Lazer e Sociedade",
        date: "2024-07-23",
        summary: "Shows, exposições e gastronomia local atraem milhares de visitantes durante o fim de semana.",
        full_content: "O centro histórico da cidade foi palco de um vibrante Festival de Cultura e Arte neste último fim de semana. Milhares de pessoas compareceram para prestigiar shows de artistas locais e nacionais, visitar exposições de arte contemporânea e experimentar a rica gastronomia regional. O evento, que contou com o apoio da prefeitura e de patrocinadores privados, teve como objetivo principal valorizar a produção cultural da região e promover a interação entre diferentes comunidades. A organização do festival destacou o sucesso da iniciativa e já planeja a próxima edição com ainda mais atrações e atividades para todas as idades, reforçando o papel da cultura como ferramenta de desenvolvimento social."
    },
    {
        id: 4,
        title: "Seleção Brasileira de Futebol conquista tricampeonato em torneio internacional",
        category: "Esportes",
        date: "2024-07-22",
        summary: "Com atuação brilhante de seus principais jogadores, Brasil levanta a taça em final emocionante.",
        full_content: "A Seleção Brasileira de Futebol fez a alegria da nação ao conquistar o tricampeonato do prestigiado torneio internacional. Em uma final eletrizante contra a equipe da Alemanha, o Brasil mostrou garra e talento, vencendo por 2 a 1 com gols decisivos no segundo tempo. A atuação do atacante Neymar, eleito o melhor jogador do campeonato, foi fundamental, com dribles e passes que desarmaram a defesa adversária. O técnico Tite elogiou a dedicação do grupo e a evolução tática da equipe ao longo da competição. Milhões de torcedores foram às ruas para celebrar a vitória, que reacende a paixão pelo futebol e fortalece o espírito esportivo no país."
    },
    {
        id: 5,
        title: "Descoberta de nova espécie de planta na Amazônia surpreende cientistas",
        category: "Segurança e Meio Ambiente",
        date: "2024-07-21",
        summary: "Pesquisadores brasileiros identificam planta com potencial medicinal em área remota da floresta.",
        full_content: "Cientistas brasileiros anunciaram a descoberta de uma nova espécie de planta durante uma expedição recente na Amazônia. A planta, batizada provisoriamente de 'Floris Amazonica', apresenta características únicas e pode possuir propriedades medicinais significativas, de acordo com as análises preliminares. A descoberta ressalta a importância da preservação da floresta amazônica, que ainda guarda inúmeros segredos e um potencial incalculável para a ciência e a medicina. Os pesquisadores alertam para os riscos do desmatamento e da degradação ambiental, que podem levar à perda de espécies ainda desconhecidas e de seus potenciais benefícios para a humanidade. Novas expedições estão sendo planejadas para aprofundar os estudos sobre a nova espécie."
    },
    {
        id: 6,
        title: "Entrevista exclusiva com o CEO da maior startup de IA do país",
        category: "Páginas Amarelas",
        date: "2024-07-20",
        summary: "Conheça a visão de futuro de João Silva sobre inteligência artificial e o mercado brasileiro.",
        full_content: "Em uma entrevista reveladora para nossas Páginas Amarelas, conversamos com João Silva, o visionário CEO da 'InovaTech', a startup de inteligência artificial que mais cresce no Brasil. João compartilhou sua jornada empreendedora, os desafios de inovar em um mercado competitivo e sua visão otimista sobre o impacto da IA no dia a dia das pessoas. Ele destacou a importância de investir em pesquisa e desenvolvimento, além de formar talentos na área de tecnologia. 'A inteligência artificial não é o futuro, é o presente. E estamos apenas arranhando a superfície do seu potencial transformador', afirmou Silva. A InovaTech, sob sua liderança, tem se destacado na criação de soluções inovadoras para diversos setores, da saúde ao agronegócio."
    },
    {
        id: 7,
        title: "Reforma tributária avança no Congresso com debates acalorados",
        category: "Política Nacional",
        date: "2024-07-26",
        summary: "Pontos polêmicos incluem a unificação de impostos e a distribuição de receitas entre entes federativos.",
        full_content: "A proposta de reforma tributária continua a ser o centro dos debates no Congresso Nacional. Após semanas de intensas discussões, alguns pontos da reforma começam a se solidificar, enquanto outros, como a unificação do ICMS e ISS em um Imposto sobre Bens e Serviços (IBS), ainda geram controvérsia. Governadores e prefeitos buscam garantir que a nova legislação não afete a autonomia financeira de seus estados e municípios. Parlamentares trabalham para chegar a um consenso que simplifique o sistema tributário brasileiro, sem aumentar a carga fiscal sobre a população e as empresas. A expectativa é que a votação final ocorra nas próximas semanas, após a análise de emendas e sugestões."
    },
    {
        id: 8,
        title: "Inflação desacelera e Banco Central sinaliza possível corte de juros",
        category: "Economia e Negócios",
        date: "2024-07-26",
        summary: "Dados do IPCA indicam controle dos preços, abrindo espaço para política monetária mais flexível.",
        full_content: "Uma boa notícia para a economia brasileira: a inflação registrou desaceleração em junho, segundo os dados divulgados hoje pelo IBGE. O Índice Nacional de Preços ao Consumidor Amplo (IPCA) ficou abaixo das expectativas, reforçando a tendência de controle dos preços no país. Diante desse cenário positivo, o Banco Central sinalizou a possibilidade de um novo corte na taxa básica de juros (Selic) na próxima reunião do Comitê de Política Monetária (Copom). A redução dos juros tende a baratear o crédito, estimulando o consumo e os investimentos, o que pode dar um novo fôlego à atividade econômica. No entanto, analistas alertam para a necessidade de manter a cautela com o cenário internacional."
    },
    {
        id: 9,
        title: "Documentário sobre a cultura indígena brasileira ganha prêmio internacional",
        category: "Cultura, Lazer e Sociedade",
        date: "2024-07-25",
        summary: "Obra aclamada destaca a riqueza e os desafios das comunidades tradicionais da Amazônia.",
        full_content: "Um documentário brasileiro que explora a riqueza da cultura indígena na Amazônia acaba de receber um prestigiado prêmio em um festival internacional de cinema. O filme, dirigido por Maria Eduarda Santos, mergulha no cotidiano de três etnias, mostrando seus rituais, crenças, a relação com a natureza e os desafios enfrentados na luta pela preservação de suas terras e tradições. A obra foi elogiada pela crítica por sua sensibilidade e pela forma autêntica como retrata a diversidade e a resiliência dos povos originários do Brasil. A premiação é um reconhecimento importante para o cinema nacional e para a visibilidade das causas indígenas no cenário global."
    },
    {
        id: 10,
        title: "Atleta brasileiro quebra recorde mundial de salto em distância",
        category: "Esportes",
        date: "2024-07-25",
        summary: "Felipe Almeida salta 8,95m em etapa da Diamond League, superando marca de longa data.",
        full_content: "A torcida foi à loucura com o feito histórico de Almeida, que agora se firma como favorito à medalha de ouro nas próximas Olimpíadas. O atleta, visivelmente emocionado, dedicou a vitória à sua equipe técnica e à sua família. O salto é um marco para o esporte brasileiro e um incentivo para a nova geração de atletas que buscam inspiração."
    },
    // Notícias adicionadas a partir do ID 11
    {
        id: 11,
        title: "Brasil Lança Satélite de Comunicações de Última Geração",
        category: "Tecnologia", 
        date: "2025-07-26", 
        summary: "Novo satélite promete revolucionar o acesso à internet em áreas remotas do país e impulsionar a pesquisa científica.",
        full_content: "<p>A Agência Espacial Brasileira (AEB) anunciou hoje o lançamento bem-sucedido de um novo satélite geoestacionário, o 'Brasilsat-5', que promete trazer avanços significativos para o setor de comunicações e pesquisa no país. O satélite, desenvolvido em parceria com universidades e empresas nacionais, terá como principal função expandir a cobertura de internet de banda larga para regiões de difícil acesso, além de coletar dados ambientais cruciais para estudos climáticos.</p><p>O projeto representa um marco na capacidade tecnológica do Brasil, demonstrando a expertise local em engenharia espacial. Especialistas afirmam que o Brasilsat-5 fortalecerá a soberania digital do país e abrirá novas portas para inovações em telemedicina, educação a distância e agronegócio de precisão.</p>"
    },
    {
        id: 12,
        title: "Cidade Anuncia Projeto Ambioclima para Mitigar Impactos das Chuvas",
        category: "Segurança e Meio Ambiente",
        date: "2025-07-26",
        summary: "Iniciativa prevê obras de drenagem e conscientização ambiental para enfrentar eventos climáticos extremos.",
        full_content: "A prefeitura de Itatiba lançou hoje o 'Projeto Ambioclima', uma série de ações integradas para preparar a cidade para os desafios impostos pelas mudanças climáticas, especialmente as fortes chuvas. O plano inclui a construção de novas bacias de retenção, a modernização da rede de drenagem urbana e um programa intensivo de educação ambiental nas escolas. 'Nosso objetivo é garantir a segurança da população e minimizar os transtornos causados pelos fenôchos meteorológicos cada vez mais intensos', declarou o prefeito durante a coletiva de imprensa. A iniciativa, que conta com financiamento federal e parcerias com a sociedade civil, prevê também o mapeamento de áreas de risco e a implementação de um sistema de alerta precoce para moradores."
    },
    {
        id: 13,
        title: "Empresa Local de Softwares Conquista Mercado Internacional com Inovação em Fintech",
        category: "Economia e Negócios",
        date: "2025-07-26",
        summary: "Startup de Itatiba fecha contratos milionários na Europa e Ásia com plataforma de gestão financeira inteligente.",
        full_content: "A 'InovaGestão Tech', startup de softwares sediada em Itatiba, está celebrando um marco histórico: a conquista de importantes contratos nos mercados europeu e asiático. A empresa, especializada em soluções fintech para pequenas e médias empresas, desenvolveu uma plataforma de gestão financeira que integra inteligência artificial para otimizar fluxos de caixa e prever tendências de mercado. 'É o reconhecimento de anos de trabalho árduo e inovação contínua. Estamos provando que o interior paulista tem capacidade de gerar tecnologia de ponta para o mundo', afirmou a CEO, Ana Clara, em comunicado. A expansão internacional deverá gerar dezenas de novos empregos na cidade nos próximos meses, consolidando a região como um polo de tecnologia."
    },
    {
        id: 14,
        title: "Festival Gastronômico Regional Quebra Recordes de Público e Vendas",
        category: "Cultura, Lazer e Sociedade",
        date: "2025-07-25",
        summary: "Evento de quatro dias celebra a culinária local com pratos típicos e shows, superando expectativas.",
        full_content: "O 'Sabor do Interior', festival gastronômico que reuniu cozinheiros e produtores de toda a região, encerrou sua quarta edição com números impressionantes de público e vendas. Durante quatro dias, moradores e turistas lotaram a praça central, desfrutando de uma variedade de pratos típicos, desde doces artesanais a comidas de rua inovadoras, todos com ingredientes locais. Além das delícias culinárias, o evento contou com apresentações musicais de artistas da região e oficinas de culinária para crianças. 'É um orgulho ver nossa cultura gastronômica valorizada e, ao mesmo tempo, impulsionar a economia local', disse o organizador principal. O sucesso do festival já garante sua realização no próximo ano, com a promessa de ainda mais atrações."
    },
    {
        id: 15,
        title: "Time de Basquete Feminino de Itatiba Vence Campeonato Estadual Invicto",
        category: "Esportes",
        date: "2025-07-24",
        summary: "A equipe local demonstra superioridade tática e técnica, conquistando o título com campanha impecável.",
        full_content: "As 'Panteras da Cesta', como são carinhosamente chamadas, o time de basquete feminino de Itatiba, sagraram-se campeãs estaduais de forma invicta, em uma campanha que entrará para a história do esporte local. Com atuações dominantes desde a fase de grupos, a equipe demonstrou um entrosamento tático e uma técnica apurada, superando todos os adversários com placares expressivos. A final, disputada na capital, foi um espetáculo de garra e talento, culminando em uma vitória por 78 a 65 sobre o forte time da metrópole. A técnica, Roberta Oliveira, elogiou a dedicação das atletas e o apoio incondicional da torcida. A vitória inspira jovens atletas e reforça a importância do investimento no esporte feminino."
    },
    {
        id: 16,
        title: "Seminário de Segurança Pública Reúne Especialistas para Debater Desafios Urbanos",
        category: "Política Nacional", 
        date: "2025-07-23",
        summary: "Autoridades e acadêmicos discutem estratégias inovadoras para combater a criminalidade e promover a paz social.",
        full_content: "Um seminário de alto nível sobre segurança pública foi realizado hoje em Itatiba, reunindo renomados especialistas, autoridades policiais, representantes do poder judiciário e acadêmicos. O evento teve como foco a troca de experiências e a proposição de soluções inovadoras para os desafios da segurança em centros urbanos. Temas como o uso de tecnologia no combate ao crime, a importância da inteligência policial e a participação comunitária na construção da paz social foram amplamente debatidos. 'A segurança é um direito de todos e uma responsabilidade compartilhada. Precisamos de abordagens multifacetadas para construir cidades mais seguras', pontuou o Secretário de Segurança Pública. As conclusões do seminário serão encaminhadas aos órgãos competentes para subsidiar novas políticas."
    }
];

// --- Funções para Gerenciamento de Notícias (localStorage) ---

// Função para carregar notícias do localStorage
function loadNewsFromLocalStorage() {
    const storedNews = localStorage.getItem('portalBmNews');
    if (storedNews) {
        const parsedNews = JSON.parse(storedNews);
        
        // Crie um Set para armazenar IDs já vistos e evitar duplicatas
        const uniqueNewsMap = new Map();

        // Adicione as notícias base primeiro (garante que IDs fixos sempre estejam lá)
        newsData.forEach(news => uniqueNewsMap.set(news.id, news));

        // Adicione as notícias do localStorage, sobrescrevendo se o ID já existir
        parsedNews.forEach(news => uniqueNewsMap.set(news.id, news));
        
        // Converte o mapa de volta para um array e atualiza newsData
        newsData = Array.from(uniqueNewsMap.values()).sort((a, b) => new Date(b.date) - new Date(a.date));

    }
}

// Função para salvar o newsData atual no localStorage
function saveNewsToLocalStorage() {
    localStorage.setItem('portalBmNews', JSON.stringify(newsData));
}

// --- Funções de Carregamento de Conteúdo ---

function loadHeaderAndFooter() {
    fetch('header.html')
        .then(response => response.text())
        .then(html => {
            const parser = new DOMParser();
            const doc = parser.parseFromString(html, 'text/html');
            const navContent = doc.querySelector('.main-nav').innerHTML;
            const mainNavPlaceholder = document.getElementById('main-nav-placeholder');
            if (mainNavPlaceholder) {
                mainNavPlaceholder.innerHTML = `<nav class="main-nav"><ul>${navContent}</ul></nav>`;
            }
            const footerNavContent = doc.querySelector('.footer-nav') ? doc.querySelector('.footer-nav').innerHTML : '';
            const footerNavPlaceholder = document.getElementById('footer-nav-placeholder');
            if (footerNavPlaceholder) {
                footerNavPlaceholder.innerHTML = `<nav class="footer-nav"><ul>${footerNavContent}</ul></nav>`;
            }
            setActiveLink();
        })
        .catch(error => console.error('Erro ao carregar cabeçalho e rodapé:', error));
}

function setActiveLink() {
    const currentPath = window.location.pathname.split('/').pop();
    const navLinks = document.querySelectorAll('.main-nav a, .footer-nav a');
    navLinks.forEach(link => {
        link.classList.remove('active');
        if (link.getAttribute('href') === currentPath) {
            link.classList.add('active');
        }
    });
}

function renderNews(category, containerId = 'news-container', displayCount = 5) {
    const container = document.getElementById(containerId);
    if (!container) return;

    let filteredNews = [];
    if (category === 'Destaques do Dia') {
        filteredNews = newsData.sort((a, b) => new Date(b.date) - new Date(a.date)).slice(0, displayCount);
    } else {
        filteredNews = newsData.filter(news => news.category === category)
                               .sort((a, b) => new Date(b.date) - new Date(a.date));
    }

    container.innerHTML = '';

    if (filteredNews.length === 0) {
        container.innerHTML = '<p>Nenhuma notícia encontrada nesta categoria.</p>';
        return;
    }

    filteredNews.forEach(news => {
        const newsItem = document.createElement('div');
        newsItem.classList.add('news-item-expandable');
        newsItem.innerHTML = `
            <details>
                <summary>
                    <h3>${news.title}</h3>
                    <p class="meta-info">Publicado em: ${news.date}</p>
                    <p class="summary-text">${news.summary}</p>
                    <div class="news-full-link-container-summary">
                        <a href="noticias_db.html?id=${news.id}">Ver notícia completa</a>
                    </div>
                </summary>
                <div class="news-content">
                    <p>${news.full_content}</p>
                </div>
            </details>
        `;
        container.appendChild(newsItem);
    });
}

function displayFullNews(newsId) {
    const fullNewsContainer = document.getElementById('full-news-display');
    const newsItem = newsData.find(item => item.id == newsId);

    if (newsItem) {
        fullNewsContainer.innerHTML = `
            <div class="news-db-item" id="news-item-${newsItem.id}">
                <h2>${newsItem.title}</h2>
                <p class="meta-info">Publicado em: ${newsItem.date} | Categoria: ${newsItem.category}</p>
                <div class="news-content">
                    <p>${newsItem.full_content}</p>
                </div>
                <div class="nav-links">
                    <button class="db-back-button">Voltar à Página Anterior</button>
                    <a href="index.html" class="db-back-home-button">Voltar à Página Inicial</a>
                </div>
            </div>
        `;
        
        const backButton = document.querySelector('.db-back-button');
        if (backButton) {
            backButton.addEventListener('click', () => {
                window.history.back();
            });
        }
        
        document.querySelectorAll('.news-db-item').forEach(item => {
            item.style.display = 'none';
        });
        document.getElementById(`news-item-${newsId}`).style.display = 'block';

    } else {
        fullNewsContainer.innerHTML = `
            <p>Erro: Notícia não encontrada ou ID inválido.</p>
            <div class="nav-links">
                <button class="db-back-button">Voltar à Página Anterior</button>
                <a href="index.html" class="db-back-home-button">Voltar à Página Inicial</a>
            </div>
        `;
        const backButton = document.querySelector('.db-back-button');
        if (backButton) {
            backButton.addEventListener('click', () => {
                window.history.back();
            });
        }
    }
}


// --- Lógica de Inicialização ao Carregar a Página ---

document.addEventListener('DOMContentLoaded', () => {
    // 0. Carregar notícias do localStorage ANTES de tudo
    loadNewsFromLocalStorage();

    // 1. Carregar cabeçalho e rodapé em todas as páginas
    loadHeaderAndFooter();

    // 2. Lógica para carregar notícias dependendo da página
    const currentPage = window.location.pathname.split('/').pop();

    if (currentPage === 'index.html' || currentPage === '') {
        renderNews('Destaques do Dia');
    } else if (currentPage === 'politica_nacional.html') {
        renderNews('Política Nacional');
    } else if (currentPage === 'economia_negocios.html') {
        renderNews('Economia e Negócios');
    } else if (currentPage === 'cultura_lazer_sociedade.html') {
        renderNews('Cultura, Lazer e Sociedade');
    } else if (currentPage === 'esportes.html') {
        renderNews('Esportes');
    } else if (currentPage === 'seguranca_meio_ambiente.html') {
        renderNews('Segurança e Meio Ambiente');
    } else if (currentPage === 'paginas_amarelas.html') {
        renderNews('Páginas Amarelas');
    } else if (currentPage === 'noticias_db.html') {
        const urlParams = new URLSearchParams(window.location.search);
        const newsId = urlParams.get('id');
        if (newsId && !isNaN(newsId)) { 
            displayFullNews(parseInt(newsId));
        } else {
            const fullNewsContainer = document.getElementById('full-news-display');
            if (fullNewsContainer) {
                fullNewsContainer.innerHTML = `
                    <p>Erro: Nenhuma notícia válida foi especificada.</p>
                    <div class="nav-links">
                        <button class="db-back-button">Voltar à Página Anterior</button>
                        <a href="index.html" class="db-back-home-button">Voltar à Página Inicial</a>
                    </div>
                `;
                const backButton = document.querySelector('.db-back-button');
                if (backButton) {
                    backButton.addEventListener('click', () => {
                        window.history.back();
                    });
                }
            } else {
                console.error("Elemento #full-news-display não encontrado na noticias_db.html");
            }
        }
    } else if (currentPage === 'tecnologia.html') { 
        renderNews('Tecnologia');
    }
    else if (currentPage === 'criar_noticia.html') {
        const newsForm = document.getElementById('news-form');
        const messageDiv = document.getElementById('message');

        if (newsForm) {
            newsForm.addEventListener('submit', (event) => {
                event.preventDefault();

                const title = document.getElementById('news-title').value;
                const category = document.getElementById('news-category').value;
                const summary = document.getElementById('news-summary').value;
                const full_content = document.getElementById('news-full-content').value;
                const date = new Date().toISOString().slice(0, 10);

                const newId = newsData.length > 0 ? Math.max(...newsData.map(n => n.id)) + 1 : 1;

                const newNews = {
                    id: newId,
                    title,
                    category,
                    date,
                    summary,
                    full_content
                };

                newsData.push(newNews);
                saveNewsToLocalStorage();
                
                messageDiv.textContent = 'Notícia publicada com sucesso!';
                newsForm.reset();
            });
        }
    }
});