---
title: "Julia e Pluto.jl"
tags: ["welcome"]
order: 1
layout: "md.jlmd"
---

# Linguagem de programação Julia 
[Julia](https://en.wikipedia.org/wiki/Julia_(programming_language)) é uma linguagem de programação de [alto nível](https://en.wikipedia.org/wiki/High-level_programming_language), [dinâmica](https://en.wikipedia.org/wiki/Dynamic_programming_language) e de elevado desempenho, lançada em 2012 como solução multi-plataforma e de código aberto para [computação científica](https://pt.wikipedia.org/wiki/Computa%C3%A7%C3%A3o_cient%C3%ADfica). Apresenta ótimas características para a construção de modelos matemáticos e de técnicas de simulação numérica, permitindo analisar e resolver problemas científicos e de engenharia, através do computador.


# Pluto.jl
O [Pluto.jl](https://plutojl.org/) é uma biblioteca Julia que proporciona um ambiente de desenvolvimento integrado para a criação de documentos computacionais interativos (*notebooks*).
Utilizando um navegador *web* (recomendado: Mozilla Firefox ou Google Chrome), o Pluto.jl permite combinar código Julia, resultados computacionais, texto explicativo, expressões matemáticas, gráficos, imagens, *etc.*, de forma interligada. Esta abordagem facilita o processo de ensino-aprendizagem, oferecendo uma experiência interativa ao utilizador.

## *Notebooks* reativos e reproduzíveis
Os *notebooks* Pluto são reativos, pois a atualização de uma parte do código reexecuta automaticamente todas as partes afetadas por essa alteração. 
Ou seja, o Pluto reconhece as dependências entre as células, nas parcelas de código Julia. Por conseguinte, sempre que uma célula é alterada, todas as células dependentes são automaticamente atualizadas (como numa folha de cálculo: MS Excel, Google Sheets, ...). Assim, os resultados são recalculados em tempo real, permitindo ao utilizador a exploração dinâmica dos conceitos de forma interativa.

Os *notebooks* Pluto são reproduzíveis, pois configuram automaticamente as dependências necessárias. O Pluto.jl regista as bibliotecas usadas no *notebook* e configura o ambiente de execução, assegurando a qualquer utilizador as mesmas condições computacionais. Esta funcionalidade elimina o problema comum de "funciona no meu computador", permitindo uma colaboração mais eficiente e resultados consistentes entre diferentes máquinas.


# *Notebooks* de Máquinas Elétricas II
A escolha do Pluto.jl como ambiente de programação reativo para Julia, para a elaboração de *notebooks* de apoio a Máquinas Elétricas II, possibilita a implementação de boas práticas de [Ciência Aberta](https://www.ciencia-aberta.pt/). O Julia com o Pluto.jl permitem disponibilizar [recursos educacionais abertos](https://en.wikipedia.org/wiki/Open_educational_resources), através da realização de materiais de ensino-aprendizagem. Também no âmbito da investigação e desenvolvimento, estas ferramentas permitem aplicar os princípios [FAIR](https://openscience.eu/):

- _**F**indable_
- _**A**ccessible_
- _**I**nteroperable_
- _**R**eusable_

Assim, os *notebooks* reativos com Julia/Pluto podem fomentar a transparência, reprodutibilidade, reutilização e inovação em ciência/engenharia.


## "*Time to first plot*"
Julia é uma linguagem compilada *just-in-time* (JIT). Isso significa que o compilador irá gerar código binário conforme necessário. Assim, quando abrir/executar o *notebook* pela primeira vez, verificará que tem de aguardar algum tempo pela compilação do código Julia, dependendo da complexidade do mesmo e da capacidade de processamento do seu computador. Por exemplo, a biblioteca `Plots.jl` para realização de gráficos tem uma dimensão considerável e exige tempo de compilação. Esta latência na compilação de um programa Julia é conhecida por "**_time to first plot_**", que teve melhorias significativas nas versões [1.6](https://lwn.net/Articles/856819/), [1.9](https://lwn.net/Articles/933019/) e [1.10](https://lwn.net/Articles/958337/) do Julia. Após a 1ª execução, apenas as alterações que realize (no código, nos dados, por interação) serão compiladas, pelo que verificará, a partir daí o [elevado desempenho](https://julialang.org/benchmarks/) da linguagem Julia.

Assim, como sugestão, após abrir um dos *notebooks* de Máquinas Elétricas II no seu Julia/Pluto, pode fazer uma primeira leitura desse *notebook* na versão estática do mesmo, disponibilizada neste *website*, até a 1ª compilação/execução terminar, para então depois poder utilizá-lo.


# Informação complementar

## Sobre *notebooks* Pluto

- Fons van der Plas, Mikołaj Bochenski, [Interactive notebooks Pluto.jl](https://youtu.be/IAF8DjrQSSk), vídeo de apresentação do Pluto, conferência JuliaCon 2020. Duração: 24min.

- Fons van der Plas, [Pluto.jl — one year later](https://youtu.be/HiI4jgDyDhY), vídeo da conferência JuliaCon 2021. Duração: 27min.

- Fons van der Plas, [Pluto.jl – reactive and reproducible notebooks for Julia](https://www.youtube.com/watch?v=Rg3r3gG4nQo), vídeo de apresentação do Pluto, conferência JupyterCon 2023. Duração: 29min.

- Connor Burns, [A Guide to Building Reactive Notebooks for Scientific Computing With Julia and Pluto.jl](https://medium.com/swlh/a-guide-to-building-reactive-notebooks-for-scientific-computing-with-julia-and-pluto-jl-1a2c0c455d51), artigo de opinião, Medium, Dez. 2020.

- Lee Phillips, [An introduction to Pluto](https://lwn.net/Articles/835930/), artigo de opinião, LWN.net, Nov. 2020.


## Sobre a linguagem de programação Julia

- Jeff Bezanson, Stefan Karpinski, Viral B. Shah, Alan Edelman, [Why We Created Julia](https://julialang.org/blog/2012/02/why-we-created-julia/), Massachusetts Institute of Technology, Fev. 2012.

- Gabriel Maistre, [10 Reasons Why You Should Learn Julia](https://blog.goodaudience.com/10-reasons-why-you-should-learn-julia-d786ac29c6ca), artigo de opinião, Good Audience, Set. 2018.

- Lee Phillips, [An introduction to the Julia language, part 1](https://lwn.net/Articles/763626/), LWN.net, Ago. 2018.

- Lee Phillips, [An introduction to the Julia language, part 2](https://lwn.net/Articles/764001/), LWN.net, Set. 2018.

- Lee Phillips, [Julia: Fast as Fortran, easy as Python](https://www.admin-magazine.com/Archive/2019/50/Julia-Fast-as-Fortran-easy-as-Python), ADMIN Magazine, Issue 50, 2019.

- Toby Driscoll, [Matlab vs. Julia vs. Python](https://tobydriscoll.net/blog/matlab-vs.-julia-vs.-python/), artigo de opinião, Jun. 2019.

- Bekhruz Tuychiev, [The Rise of the Julia Programming Language  — Is it Worth Learning in 2023?](https://www.datacamp.com/blog/the-rise-of-julia-is-it-worth-learning-in-2022), artigo de opinião, DataCamp, Maio 2023.

- William F Godoy, [Julia's Value Proposition for Better Scientific Software](https://bssw.io/blog_posts/julia-s-value-proposition-for-better-scientific-software), artigo de opinião, Better Scientific Software, Abril, 2023.

- João Pereira, Mario Siqueira, [Linguagem de programação JULIA: uma alternativa open source e de alto desempenho ao MATLAB](https://periodicos.ifpb.edu.br/index.php/principia/article/view/1345), Revista principia - divulgação científica e tecnológica do IFPB, N.º 34, p. 132-140, 2017.

- Abel Soares Siqueira, Gustavo Sarturi, João Okimoto, Kally Chung, [Introdução à programação em Julia](https://juliaintro.github.io/JuliaIntroBR.jl/), tradução do livro de: Allen Downey, Ben Lauwens, [Think Julia: How to Think Like a Computer Scientist](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html), O’Reilly Media, 2018.

- Raimundo Filho, Marina Miranda, Millena Rocha, André Nascimento, [Introdução a linguagem de programação Julia](https://www.edufma.ufma.br/wp-content/uploads/woocommerce_uploads/2023/05/Introdu%C3%A7%C3%A3o-a-linguagem-de-programa%C3%A7%C3%A3o-Julia.pdf),  EDFUMA - Editora da Universidade Federal do Maranhão, São Luís, Brasil, 2023.

