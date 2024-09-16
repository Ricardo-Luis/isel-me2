### A Pluto.jl notebook ###
# v0.19.46

#> [frontmatter]
#> chapter = "1"
#> section = "9"
#> order = "9"
#> title = "📄 Máquina CC: induzido, RMI, comutação"
#> tags = ["lecture", "module2"]
#> date = "2024-09-16"
#> 
#>     [[frontmatter.author]]
#>     name = "Ricardo Luís"
#>     url = "https://ricardo-luis.github.io/isel-me2/"

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 3b461ddf-3b4b-457b-9f9c-f606d8b260aa
using PlutoUI, Handcalcs, PlutoTeachingTools
# Short packages description:
  # PlutoUI.jl, to add interactivity objects to notebook
  # PlutoTeachingTools.jl, to enhance the notebook
  # Handcalcs.jl, to generate LaTeX formatted strings from mathematical formulas, mimitizing an handwriting calculation

# ╔═╡ 91180300-0b49-4211-9ad3-12fd0785f518
TwoColumnWideLeft(md"`MaqDCinduzido.jl`", md"`Last update: 16·09·2024`")

# ╔═╡ 4e3917b0-4458-11ef-2b69-bd55e90578e0
md"""
---
$\textbf{MÁQUINAS ELÉTRICAS DE CORRENTE CONTÍNUA}$

$\text{RELATÓRIO}$ 

$\textbf{Aspetos construtivos e de funcionamento da máquina de corrente contínua}$
---
"""

# ╔═╡ 2239ebd6-bb9c-4e48-bf2b-78557cd8f7e6
md"""
# 1 - Introdução
"""

# ╔═╡ 14c7e7d9-5e3f-4680-a625-cfa81ba48e69
md"""
A máquina de Corrente Contínua (CC) distingue-se das restantes máquinas elétricas rotativas devido à presença do coletor e escovas. Estes componentes operam como um retificador mecânico de contato deslizante das forças eletromotrizes alternadas geradas nos condutores do enrolamento induzido (rotor) em movimento, sob um campo magnético constante.\

O coletor faz a ligação elétrica com o **enrolamento do induzido**, através das suas lâminas. O conjunto lâminas e escovas, realiza a retificação da forma de onda da tensão induzida nas bobinas do enrolamento induzido. Este processo é designado por **comutação**. Como resultado, quando o induzido da máquina CC se encontra num circuito fechado, verifica-se uma corrente unidirecional, entre escova(s) positiva(s) e escova(s) negativa(s).\

Quando circula um valor considerável de corrente no enrolamento induzido, tanto no funcionamento como gerador como motor, ocorre a **reação magnética do induzido** que tem algumas implicações no funcionamento da máquina CC e que são observáveis neste trabalho experimental.
"""

# ╔═╡ 9ef12029-565b-4a7c-8075-da777a76159d


# ╔═╡ dfa3294f-a708-4ce8-afcd-b75d02ade322
md"""
## 1.1 - Objetivos
"""

# ╔═╡ 951470b1-3506-4d92-898d-5b3f996e0bab
md"""
As observações laboratoriais deste trabalho têm como foco principal, o rotor da máquina CC, com os seguintes objetivos: 
- Esquematização dos enrolamentos do induzido;
- Observação da reação magnética do induzido;
- Observação do processo da comutação.
"""

# ╔═╡ 09eb0bd2-d889-4969-a426-5d76b394dd4b
aside((md"![](https://github.com/Ricardo-Luis/notebooks/blob/main/ME2/images/armature_winders.jpg?raw=true)\

Fig. 1: Bobinadores executando a montagem de um enrolamento induzido, [^Kennedy_1903].

"),v_offset=100)

# ╔═╡ f5802767-8a84-4a79-a949-2c873e47af28
md"""
## 1.2 - Enrolamentos do induzido
"""

# ╔═╡ ff0e1c6b-6c1a-4d27-b986-a2c003b27ab3
md"""
Existem dois tipos de enrolamentos do induzido para disposições em tambor:
- enrolamento imbricado
- enrolamento ondulado

Estes enrolamentos podem ser simples ou múltiplos (geramente duplos ou triplos). É possível percepcionar a multiplicidade do enrolamento do induzido pela largura das escovas, medida em número de lâminas do coletor abrangidas na área de contacto entre uma escova e o coletor. 

No presente trabalho, serão executados apenas enrolamentos simples. Em vez de utilizar um rotor real, _e.g._ Fig. 1, será empregue um modelo de madeira, utilizando um cordel para simular a sequência de execução do enrolamento induzido.
"""

# ╔═╡ de94ef0e-5ff7-4233-b38b-ad6ad6ec8171
md"""
Para o dimensionamento de um enrolamento induzido são necessários os seguintes parâmetros:

 $\quad\quad c$: Número de lâminas do coletor;\
 $\quad\quad s$: Número de secções (bobinas) no induzido; $\quad\quad\:\: s=c$\
 $\quad\quad la$: Número de lados ativos no induzido; $\quad\quad\quad\quad la=2s$\
 $\quad\quad N_s$: Número de condutores por lado ativo;\
 $\quad\quad p$: Número de par de polos;\
 $\quad\quad k$: Número de cavas do induzido;\
 $\quad\quad z$: Número de condutores ativos no induzido; $\quad\quad\: z=la\:s=2\:s\:Ns$\
 $\quad\quad y_p$: Passo polar. Número de lados ativos entre dois polos adjacentes;\
 $\quad\quad y_1$: Passo da secção ou passo posterior. Número de lados ativos entre a ida e o retorno da mesma secção;\
 $\quad\quad y_2$: Passo da ligação ou passo anterior. Número de lados ativos entre o retorno de uma secção e a ida da secção seguinte;\
 $\quad\quad y$: Passo do enrolamento ou passo resultante. Número de lados ativos entre a ida de uma secção e a ida da secção seguinte;\
 $\quad\quad y_c$: Passo do coletor. Número de lâminas no coletor entre as duas ligações da mesma secção.
"""

# ╔═╡ eaef98e4-c79f-4932-8b7c-32a90fa664db
aside((md"![](https://github.com/Ricardo-Luis/notebooks/blob/main/ME2/images/armature_reaction.jpg?raw=true)\

Fig. 2: Distorção do campo magnético num induzido em anel de Gramme, [^Audel_1917]


"),v_offset=100)

# ╔═╡ 3571ba78-44b7-489a-a2bd-c4841c931879
md"""
## 1.3 - Reação magnética o induzido
"""

# ╔═╡ 2b9ef51e-bfe4-4a77-9e04-f1eea7320f99
md"""
Na máquina CC em vazio ou com corrente do induzido muito baixa, o campo magnético produzido no enrolamento indutor (enrolamento de excitação) que envolve os polos magnéticos é simétrico em relação à linha dos polos (linha de **S** a **N** da Fig. 2). Como a permeabilidade magnética de um núcleo ferromagnético é muito superior à do ar, as linhas de campo tendem a ser perpendiculares às superfícies dos núcleos ferromagnéticos.\

Quando circula corrente no enrolamento do rotor, são produzidas linhas de campo magnético em torno do enrolamento do induzido. Na sobreposição dos dois campos magnéticos, indutor e induzido, obtém-se um campo magnético resultante, caracterizado por uma distribuição assimétrica das linhas de fluxo magnético nos núcleos ferromagnéticos. A Fig. 2 ilustra o efeito do campo resultante, verificando-se uma concentração de linhas de fluxo numa parte do polo magnético e uma rarefação na outra parte. No polo oposto, ocorre o mesmo efeito de forma invertida segundo a linha dos polos.\

Assim, o campo magnético resultante que a atravessa o enrolamento induzido, quando este está em carga, apresenta-se com elevada distorção. Isso implica uma movimentação do plano das escovas para que fique perpendicular à distribuição das linhas de fluxo. Este processo denomina-se por **calagem das escovas**, posicionando-as na Linha Neutra Real, que é dependente do valor da corrente do induzido. 
"""

# ╔═╡ 173f214d-6a15-44e4-abec-3b336d6bb6db


# ╔═╡ 0d4b1a9b-de84-4e60-8256-ab48dbde4ccc
aside((md"![](https://github.com/Ricardo-Luis/notebooks/blob/main/ME2/images/commutator.jpg?raw=true)\

Fig. 3: Coletor e escovas, [^Kral_2022]


"),v_offset=130)

# ╔═╡ 689c4341-3ff8-4a3f-b913-8b196fde0a0f
md"""
## 1.4 - Comutação
"""

# ╔═╡ 17402250-5f39-4343-9dcb-a30a0d5a361f
md"""
A comutação é um processo fundamental nas máquinas CC e ocorre no processo de retificação mecânica da forma de onda da tensão induzida nas secções do enrolamento induzido (rotor) em movimento. Este processo é realizado pelo conjunto coletor e escovas, Fig. 3, que também retifica a corrente que circule no enrolamento. A comutação é essencial para manter a unidirecionalidade da corrente no exterior da máquina, característica que define uma máquina de corrente contínua.

O posicionamento das escovas é fundamental para o correto funcionamento da máquina CC. Idealmente, o plano das escovas deve estar em quadratura com a linha dos polos magnéticos ou de excitação. Essa posição é designada por **Linha Neutra Geométrica**  (linha de **N'** a **S'** da Fig. 2). Nessa posição, verifica-se que a força eletromotriz na(s) secção(ões) do induzido que entra(m) em comutação é nula, o que reduz a ocorrência de arcos elétricos (faíscas) entre as lâminas do coletor e as escovas. A existência de intenso faiscamento no processo de comutação pode provocar, a longo prazo, dois tipos de deterioração na superfície do coletor:
- surgimento de pequenas cavidades, formadas pela remoção de cobre, na superfície das lâminas do coletor (faíscas num tom esverdeado -> vaporização do cobre);
- formação de uma ranhura ou sulco de desgaste, correspondente a um rebaixamento na superfície das lâminas na área de contacto com as escovas (faíscas num tom alaranjado -> vaporização do carvão).

Um comutação insatisfatória (ocorrência de arcos elétricos) pode ainda provocar danos nas escovas, por sobreaquecimento. Assim, a qualidade da comutação é essencial para o bom funcionamento da máquina CC.
"""

# ╔═╡ fe8c05b9-e4fe-4f43-91a4-90c150992a83


# ╔═╡ 4f237e49-6ff8-4539-a73d-8847d14d4696
md"""
# 2A - Procedimento de ensaio (Enrolamentos do induzido)
"""

# ╔═╡ d51cf305-b047-4f54-8875-c161edc12cd1
md"""
## 2A.1 - 💻 Dados da máquina de corrente contínua (modelo)
"""

# ╔═╡ 8cc2adb9-6748-4859-92cc-f9014c42392e
md"""
Introduzir os dados do modelo de madeira representativo de um rotor de uma máquina CC:
"""

# ╔═╡ 2c807192-20d8-4bbd-9d6e-496f592b404a
md"""
 $$\textrm{modelo n.º:}$$  $(@bind modelo TextField(default=""))


 $$k =$$ $(@bind k NumberField(0:100, default=24)) cavas


 $$c =$$ $(@bind c NumberField(0:200, default=48)) lâminas


 $$p =$$  $(@bind p NumberField(0:10, default=2)) pares de polos

"""

# ╔═╡ b8ce899e-dc76-4b98-b563-703f6fb296d7
aside((md"""
!!! info "Informação"
	A biblioteca `handcalcs.jl` permite transpor código de cálculo em Julia para $\LaTeX$, mas de uma forma que imita como alguém escreveria o seu cálculo manualmente: escreve-se a fórmula simbólica de cálculo, seguida das substituições numéricas e, por fim, o resultado.\
	Como o `handcalcs.jl` mostra a substituição numérica, os cálculos tornam-se significativamente mais fáceis de verificar.
"""), v_offset=100)

# ╔═╡ 5bd6c690-c2e9-4353-b262-fafb845a0aec
md"""
## 2A.2 - Dimensionamento: enrolamento imbricado simples
"""

# ╔═╡ 2923d3f5-c427-44a9-9b7e-8e34458b4fb4
@handcalcs begin	
	s = c
	yₚ = (2*s) / (2*p)
end

# ╔═╡ 9f176d1f-39e4-4e4a-83dd-09751c92b91a


# ╔═╡ 0476d46a-b9d3-4f52-a461-5f997df6696d
md"""
O enrolamento com coletor tem de fechar sobre si. No caso do enrolamento imbricado simples, o enrolamento fecha sempre desde que o passo resultante, $y$, tome os valores: 

$\begin{align}
y&=+2\quad\quad  \Rightarrow \quad\quad \text{imbricado simples do tipo progressivo}\\
y&=-2\quad\quad  \Rightarrow \quad\quad \enclose{horizontalstrike}{\text{imbricado simples do tipo retrógrado ou cruzado}}
\end{align}$

Na prática, na realização do enrolamento induzido, apenas a solução do tipo progressivo é utilizada, pois as ligações das secções às lâminas do coletor vão avançando progressivamente, utilizando assim menos cobre, tornando esta opção mais económica. 
"""

# ╔═╡ d90c4748-0ae2-4c2b-b795-face64b7e4d6
md"""
Assim:
"""

# ╔═╡ e24f3b48-56c4-4869-bc53-64af098f6182
md"""
$y=2=y_1+y_2$
"""

# ╔═╡ 873c12b0-8115-4fc4-998d-07ba25883df6
md"""
Considerando valores de passo posterior $$y_1$$, próximos do passo polar, $$y_p$$ e  número ímpar:

$$y_1 \approx y_p$$
"""

# ╔═╡ b2cd7ec8-5ee9-4523-8e84-7ad92f9a76c3
if isodd(yₚ) 					# Is this an odd number?
	@handcalcs begin 			# if true (odd number)
		y₁=[yₚ yₚ+2 yₚ-2] 		#adjust the sum and difference to get odd number (integer)
		y₂=2 .- y₁
	end
else 							# if false (even number)
	@handcalcs begin
		y₁=[yₚ+1 yₚ+3 yₚ-1] 	#adjust the sum and difference to get odd number (integer)
		y₂=2 .- y₁
	end
end

# ╔═╡ 5131e8fb-3de1-4c1b-9a8c-a35e2e352ad2


# ╔═╡ f5cf82e8-1aaa-452b-85da-28503108c97b
md"""
Das possibilidades encontradas testa-se o par de valores de $(y_1, y_2)$ mais próximo de $y_p$.\
No entanto, não é prático a colocação das secções nas cavas do induzido, contando os lados ativos correspondentes a $(y_1, y_2)$. \
Na prática, torna-se mais conveniente transpor a contagem em lados ativos para uma contagem em número de cavas.\
Assim, definem-se os parâmetros:\
\
 $\quad\quad u$: Número de lados ativos por cava;\
 $\quad\quad y_{1k}$: Passo da secção ou passo posterior em número de cavas;\
 $\quad\quad y_{2k}$: Passo da ligação ou passo anterior em número de cavas.
"""

# ╔═╡ 169cd52b-44ef-46c1-a9c9-a36e14f0c44c


# ╔═╡ 1ebad95b-da33-4c73-9091-72419ab236f6
md"""
Transpondo as soluções de  $\:y_1,\: y_2\:$, para $\:y_{1k}, \:y_{2k}\:$, tém-se:
"""

# ╔═╡ 0ffc2616-077b-4fc2-bc17-c987f6f470de
@handcalcs begin
	la = 2s 
	u = la / k
	y₁ₖ = (y₁ .- 1) / u
	y₂ₖ = (y₂ .+ 1) / u
end

# ╔═╡ 2b7e69e3-270e-488d-a120-5b2029ce48b7
md"""
Considerando as soluções encontradas, a opção para realização do enrolamento imbricado deve recair num passo de secção, medido em número de cavas, $y_{1k}$, que seja um número inteiro. Tal é importante, porque significa que o enrolamento induzido será constituído por secções (bobinas) iguais em dimensão.
"""

# ╔═╡ 0b8f9c31-f74d-4021-9b13-1b565da3918e
md"""
**Cálculos auxiliares para extrair os passos inteiros:**
"""

# ╔═╡ b7e964ea-ed6e-42cd-a9ce-6ee1f12caedb
begin
	c_int1=isinteger.(y₁ₖ)
	x=findfirst(isequal(1), c_int1)
	index=getindex(x, 2)	
	c_int1, x, index
end;

# ╔═╡ af20c2ea-26f0-4def-aa47-c09d255cece8
begin
	y₁ₖ_sol = y₁ₖ[index]
	y₂ₖ_sol = round(y₂ₖ[index], digits=3)
	y₁ₖ_sol, y₂ₖ_sol
end

# ╔═╡ 9fb13e92-41bc-4948-8e5e-7db1e0fd4571


# ╔═╡ b432b0a5-1333-46c7-b616-657dcc5c9bb7
md"""
### **Solução: Imbricado simples**
"""

# ╔═╡ 84d93def-10b6-4108-9b32-9ae6199f3c06
md"""
Verifica-se que para realizar o enrolamento induzido do tipo **imbricado simples** no modelo de rotor n.º $(modelo), são necessários os seguintes passos, em número de cavas:

| melhores passos | número de cavas |
|:---:|:---:|
| $$y_{1k}$$ | $(y₁ₖ_sol[1]) |
| $$y_{2k}$$ | $(y₂ₖ_sol[1]) |
| | |
"""

# ╔═╡ 069d947f-261b-4ac6-a679-345d5e3d4879
md"""
## 2A.3 - Dimensionamento: enrolamento ondulado simples
"""

# ╔═╡ 04ae7282-aaef-44b3-928c-105b905b39b1
md"""
Considerando o mesmo modelo de rotor em madeira, para a execução do enrolamento ondulado, **é necessário garantir um passo de coletor, $y_c$, que seja um número inteiro**, garantindo assim que o enrolamento ondulado se feche sobre si.

O passo de coletor, $y_c$ para um enrolamento ondulado simples é obtido:

$\begin{align}
y_c&=\frac{s-1}{p}\quad\quad  \Rightarrow \quad\quad \text{ondulado simples do tipo retrógrado (1ª opção)}\\
y_c&=\frac{s+1}{p}\quad\quad  \Rightarrow \quad\quad \text{ondulado simples do tipo progressivo ou cruzado (2ª opção)}
\end{align}$
"""

# ╔═╡ 413f497a-8917-448c-923d-f89938bb75ea
md"""
Calculando os valores para o passo de coletor, $y_c$, tém-se:
"""

# ╔═╡ 7919291c-85f2-43b1-8a6a-486d98a1f8ca
@handcalcs begin	
	yc = [(s-1)/p ; (s+1)/p]
end

# ╔═╡ 01e85628-c172-45ff-a959-447fb536a046
begin 
	x1=findfirst(isinteger.(yc))
	if x1==1
		sᴹ = 0
		md"""**Enrolamento ondulado simples do tipo retrógrado**, com: $$\quad y_c=$$ $(yc[1]) lâminas"""
	elseif x1==2
		sᴹ = 0
		md"""**Enrolamento ondulado simples do tipo cruzado**, com: $$\quad y_c=$$ $(yc[2]) lâminas"""
	else
		md"""O enrolamento do induzido do tipo ondulado **não fecha**!\
		Definir quantidade de **secções mortas**, $\: sᴹ=$ $(@bind sᴹ Slider(1:4, default=1, show_value=true))"""
	end
end

# ╔═╡ b2681f86-0941-460b-9364-83e84d96e771


# ╔═╡ c332fd77-2c8d-407b-9b26-61ed97bb7d02
md"""
Caso o enrolamento não feche é necessário considerar 1 ou mais "secções mortas" (secções que são colocadas nas cavas, mas não são ligadas eletricamente) e repetir o cálculo de $y_c$: 
"""

# ╔═╡ 8fc1994c-9dc7-48aa-aaa6-0d30accf77c0
@handcalcs begin	
	sᴹ
	sₑₗ = s - sᴹ
	ycᴹ = [(sₑₗ-1)/p ; (sₑₗ+1)/p]
end

# ╔═╡ f7676f1c-afe7-4b0a-bd1b-95253749444c
md"""
Definem-se os passos de secção, $y_1$, e de ligação, $y_2$, em número ímpar e de modo que a transposição destes passos para número de cavas, permita obter no $y_{1k}$ um número inteiro, ou seja, significando tamanho das secções iguais.
""" 

# ╔═╡ db42fc9a-128a-4cce-bf2e-d4aff43d52aa
md"""
Como $y_c=y$ em número de lados ativos e como $c=\dfrac{la}{2}$, tém-se $y_c=\dfrac{y}{2}$ em número de lâminas.
"""

# ╔═╡ 3b315cdc-0e3c-4201-9f48-0ddebdd56f22
begin 
	i=findfirst(isinteger.(ycᴹ))

	if isodd(ycᴹ[i]) 
		@handcalcs begin
			i
			Y₁ = ycᴹ[i]+0 			# adjust the subtraction until get Y1k integer
			Y₂ = ycᴹ[i]*2 - Y₁
		end
	elseif iseven(ycᴹ[i]) 
		@handcalcs begin
			i
			Y₁ = ycᴹ[i]-1 			# adjust the subtraction until get Y1k integer
			Y₂ = ycᴹ[i]*2 - Y₁
		end
	end
end

# ╔═╡ 359a134c-f8cc-4308-8a18-ed0d1392ea9f
md"""
Transpondo as soluções de  $\:Y_1,\: Y_2\:$, para $\:Y_{1k}, \:Y_{2k}\:$, tém-se:
"""

# ╔═╡ 8b226a7b-bc4b-4197-93fc-99d16946b71e
@handcalcs begin
	Y₁ₖ = (Y₁ - 1) / u
	Y₂ₖ = (Y₂ + 1) / u
end

# ╔═╡ 827e892e-1630-44ce-b25c-42c280d97816
if isinteger.(Y₁ₖ)==true
	md" $y_{1k}$ é número inteiro. **Cálculo concluído!**"
else
	md" $y_{1k}$ não é número inteiro. **Ajustar $y_1$!**"
end

# ╔═╡ 422f584a-0775-4514-8356-8425475fea74


# ╔═╡ b1dcbdaf-0d8f-4b2a-bc21-06b1c5541c1a
md"""
### **Solução: Ondulado simples**
"""

# ╔═╡ 8d8f8e8d-3ecd-4f30-8a9c-0b6a82dc85c9
md"""
Verifica-se que para realizar o enrolamento induzido do tipo **ondulado simples** no modelo de rotor n.º $(modelo), são necessários os seguintes passos, em número de cavas:

| melhores passos | número de cavas |
|:---:|:---:|
| $$y_{1k}$$ | $(Y₁ₖ) |
| $$y_{2k}$$ | $(Y₂ₖ) |
| $$y_{c}$$ | $(ycᴹ[i]) |
| | |
"""

# ╔═╡ 73035108-ce5a-4bca-8fb3-6e6c097ea4e0


# ╔═╡ ef757caa-cc6f-4934-be18-bcb292c92fc9
md"""
# 2B - Procedimento de ensaio (Reação magnética do induzido e comutação)
"""

# ╔═╡ 2140af27-202a-40e4-800e-f5d08c9ccfca
md"""
## 2B.1 - Esquema de ligações

\
\
\
\
\
\
\
\
\
\
\
\
\
\
"""

# ╔═╡ f79caae4-82b6-4917-b3b4-fc180d2f188f


# ╔═╡ b5ded038-cd25-4da6-8429-0c162dae4477
md"""
## 2B.2 - Material utilizado
\
\
\
\
\
\
\
\
\
\
\
\
\
"""

# ╔═╡ 3c04f72e-06be-4ed1-b0d8-ce32b8723b29


# ╔═╡ f3beefea-a678-4e9c-8dcd-2059767a97c4
md"""
## 2B.3 - Condução do trabalho
"""

# ╔═╡ 5cd1e0c4-2eec-4470-bcf1-21298b29fb6d
md"""
1. Ligar a rede de corrente contínua do lab. e proceder à manobra de arranque do motor CC;\
1. Ligar o circuito de excitação do gerador CC;
No gerador:
3. Observar o valor da força eletromotriz induzida, para diferentes posições do plano das escovas;
1. Retirar o valor da Linha Neutra Geométrica ou Linha Neutra Magnética em vazio;
1. Ligar o circuito de carga no valor máximo de corrente;
1. Observar o valor da força eletromotriz induzida para diferentes posições do plano das escovas;
1. Observar o faiscamento no processo de comutação;
1. Procurar a Linha Neutra Magnética em carga;
1. Desligar as máquinas por ordem inversa;
1. Fim do ensaio.

"""

# ╔═╡ 312645a8-7098-474d-b3b3-1499b96606d8


# ╔═╡ 12519278-2cd1-42a3-8b24-eae19910649a
md"""
# 3 - Resultados experimentais
"""

# ╔═╡ 7412c059-dd62-4c77-919f-be095b5664f2
md"""
## 3.1 - Observações sobre enrolamentos do induzido
"""

# ╔═╡ 16933177-1655-4d68-b2be-6a2d26d02280
md"""
- **Enrolamento imbricado:**
\
\
\
\
\
\
\

- **Enrolamento ondulado:**
\
\
\
\
\
\
\
"""

# ╔═╡ feda8823-b422-43f2-969b-c4becc9c3cb7


# ╔═╡ 37256831-071a-4f90-937d-c9bad69ad643
md"""
## 3.2 - Observações sobre: reação magnética do induzido e comutação
"""

# ╔═╡ ab9cc707-2ce2-4eb2-987f-c27755dd9d85
md"""
- **Linha Neutra Geométrica (LNG) ou Linha Neutra Magnética (LNM) em vazio:**
\
Ângulo LNG = _____°
\
\
\
\
\

- **Linha Neutra Magnética em carga ou Linha Neutra Real:**
\
Ângulo de calagem das escovas = _____°
\
\
\
\
\
\

- **Comutação:**
\
\
\
\
\
\
\
"""

# ╔═╡ a9de66ab-deab-4e4c-a5f9-a672805a24a4


# ╔═╡ c003b9a6-7d8b-4b49-ad41-1661618522b4
md"""
# 4 - Conclusões
\
\
\
\
\
\
\
\
\
\
\
\
\
\
\
"""

# ╔═╡ 06ae56ec-52d0-46d1-96da-3613ecc56df2
md"""
# Bibliografia
\
**Créditos da imagens:**\
[^Kennedy_1903]: Rankin Kennedy, Electrical Installations, vol. III, London: Caxton, 1903. 

[^Audel_1917]: Theo. Audel & Co., Hawkins Electrical Guide, Volume 1, Chapter 20: Commutation and the Commutator, Page 286, USA, 1917.

[^Kral_2022]:  Christian Kral, [Commutator and brushes DC motor](https://commons.wikimedia.org/w/index.php?curid=122251615), Own work, CC BY 4.0, 2022. 

\
**Leitura recomendada:**\

José Carvalho (2018). Máquinas Elétricas de Corrente Contínua: Reação Magnética do Induzido e Comutação. Revista técnico-científica “Neutro-à-Terra”, ISEP\Departamento de Engenharia Eletrotécnica.\

DOI: [https://doi.org/10.34630/neutroaterra.vi21.4393](https://doi.org/10.34630/neutroaterra.vi21.4393)
"""

# ╔═╡ bc2a479e-a961-43ef-b430-afd69b496ac0
# to adjust the notebook margins and used font-family/size on text content
html"""<style>
@media screen {
	main {
		margin: auto;
		max-width: 1920px;
		padding-left: 5%;
		padding-right: 25.9%; 
		}
	}
pluto-output {
    font-family: system-ui;
	font-size:  100%;
	text-align: justify
}
</style>
"""

# ╔═╡ b467ed22-2892-4875-a2b7-173efafa5a8d
md"""
# Notebook
"""

# ╔═╡ 68fff8eb-4988-4c68-a543-2ddef8e4c428
md"""
Documentação das bibliotecas Julia utilizadas: [PlutoUI](https://juliahub.com/docs/PlutoUI/abXFp/0.7.6/), [PlutoTeachingTools](https://juliapluto.github.io/PlutoTeachingTools.jl/example.html), [Handcalcs](https://co1emi11er2.github.io/Handcalcs.jl/stable/).
"""

# ╔═╡ 0cc7f332-f41a-4822-bcad-f06ee56d110f
TableOfContents(title="Índice")

# ╔═╡ a916e2c4-ef39-4bd0-8c96-732ae356a8b1
aside((md"""
!!! info
	No índice deste *notebook*, o tópico assinalado com "💻" requer a participação do estudante.
"""), v_offset=-170)

# ╔═╡ bb928631-6cf1-4f9a-ac8b-1fa072d19f69
md"""
|  |  |
|:--:|:--|
|  | This notebook, [MaqDCinduzido.jl](https://ricardo-luis.github.io/isel-me2/Fall23/week0/MaqDCinduzido/), is part of the collection "[_Notebooks_ Reativos de Apoio a Máquinas Elétricas II](https://ricardo-luis.github.io/isel-me2/)" by Ricardo Luís. |
| **Terms of Use** | This work is licensed under the Creative Commons Attribution-ShareAlike 4.0 International License ([CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)) for text content and under the [MIT License](https://www.tldrlegal.com/license/mit-license) for Julia code snippets.|
|  | $©$ 2022-2024 [Ricardo Luís](https://ricardo-luis.github.io/) |
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Handcalcs = "e8a07092-c156-4455-ab8e-ed8bc81edefb"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
Handcalcs = "~0.4.0"
PlutoTeachingTools = "~0.2.15"
PlutoUI = "~0.7.59"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.5"
manifest_format = "2.0"
project_hash = "27cf797b69630582b7f1eb3eab30bafa60b24ff0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.AbstractTrees]]
git-tree-sha1 = "2d9c9a55f9c93e8887ad391fbae72f8ef55e1177"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.4.5"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "7eee164f122511d3e4e1ebadb7956939ea7e1c77"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "1.3.6"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.Handcalcs]]
deps = ["AbstractTrees", "CodeTracking", "InteractiveUtils", "LaTeXStrings", "Latexify", "MacroTools", "PrecompileTools", "Revise", "TestHandcalcFunctions"]
git-tree-sha1 = "45c525ec676c684464fbf391bdc6352258b6fae8"
uuid = "e8a07092-c156-4455-ab8e-ed8bc81edefb"
version = "0.4.0"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JuliaInterpreter]]
deps = ["CodeTracking", "InteractiveUtils", "Random", "UUIDs"]
git-tree-sha1 = "5d3a5a206297af3868151bb4a2cf27ebce46f16d"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.9.33"

[[deps.LaTeXStrings]]
git-tree-sha1 = "50901ebc375ed41dbf8058da26f9de442febbbec"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.1"

[[deps.Latexify]]
deps = ["Format", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "5b0d630f3020b82c0775a51d05895852f8506f50"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.4"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.4.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.6.4+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoweredCodeUtils]]
deps = ["JuliaInterpreter"]
git-tree-sha1 = "1ce1834f9644a8f7c011eb0592b7fd6c42c90653"
uuid = "6f1432cf-f94c-5a45-995e-cdbf5db27b0b"
version = "3.0.1"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "2fa9ee3e63fd3a4f7a9a4f4744a52f4856de82df"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.13"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PlutoHooks]]
deps = ["InteractiveUtils", "Markdown", "UUIDs"]
git-tree-sha1 = "072cdf20c9b0507fdd977d7d246d90030609674b"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0774"
version = "0.0.5"

[[deps.PlutoLinks]]
deps = ["FileWatching", "InteractiveUtils", "Markdown", "PlutoHooks", "Revise", "UUIDs"]
git-tree-sha1 = "8f5fa7056e6dcfb23ac5211de38e6c03f6367794"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0420"
version = "0.1.6"

[[deps.PlutoTeachingTools]]
deps = ["Downloads", "HypertextLiteral", "LaTeXStrings", "Latexify", "Markdown", "PlutoLinks", "PlutoUI", "Random"]
git-tree-sha1 = "5d9ab1a4faf25a62bb9d07ef0003396ac258ef1c"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.2.15"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "ab55ee1510ad2af0ff674dbcced5e94921f867a9"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.59"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Revise]]
deps = ["CodeTracking", "Distributed", "FileWatching", "JuliaInterpreter", "LibGit2", "LoweredCodeUtils", "OrderedCollections", "REPL", "Requires", "UUIDs", "Unicode"]
git-tree-sha1 = "7b7850bb94f75762d567834d7e9802fc22d62f9c"
uuid = "295af30f-e4ad-537b-8983-00126c2a3abe"
version = "3.5.18"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TestHandcalcFunctions]]
git-tree-sha1 = "1e4ebeb8d7d78f9974c0153321e80fa66487d3bf"
uuid = "6ba57fb7-81df-4b24-8e8e-a3885b6fcae7"
version = "0.2.0"

[[deps.Tricks]]
git-tree-sha1 = "7822b97e99a1672bfb1b49b668a6d46d58d8cbcb"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.9"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╟─91180300-0b49-4211-9ad3-12fd0785f518
# ╟─4e3917b0-4458-11ef-2b69-bd55e90578e0
# ╟─2239ebd6-bb9c-4e48-bf2b-78557cd8f7e6
# ╟─14c7e7d9-5e3f-4680-a625-cfa81ba48e69
# ╟─9ef12029-565b-4a7c-8075-da777a76159d
# ╟─dfa3294f-a708-4ce8-afcd-b75d02ade322
# ╟─951470b1-3506-4d92-898d-5b3f996e0bab
# ╟─09eb0bd2-d889-4969-a426-5d76b394dd4b
# ╟─f5802767-8a84-4a79-a949-2c873e47af28
# ╟─ff0e1c6b-6c1a-4d27-b986-a2c003b27ab3
# ╟─de94ef0e-5ff7-4233-b38b-ad6ad6ec8171
# ╟─eaef98e4-c79f-4932-8b7c-32a90fa664db
# ╟─3571ba78-44b7-489a-a2bd-c4841c931879
# ╟─2b9ef51e-bfe4-4a77-9e04-f1eea7320f99
# ╟─173f214d-6a15-44e4-abec-3b336d6bb6db
# ╟─0d4b1a9b-de84-4e60-8256-ab48dbde4ccc
# ╟─689c4341-3ff8-4a3f-b913-8b196fde0a0f
# ╟─17402250-5f39-4343-9dcb-a30a0d5a361f
# ╟─fe8c05b9-e4fe-4f43-91a4-90c150992a83
# ╟─4f237e49-6ff8-4539-a73d-8847d14d4696
# ╟─d51cf305-b047-4f54-8875-c161edc12cd1
# ╟─8cc2adb9-6748-4859-92cc-f9014c42392e
# ╟─2c807192-20d8-4bbd-9d6e-496f592b404a
# ╟─b8ce899e-dc76-4b98-b563-703f6fb296d7
# ╟─5bd6c690-c2e9-4353-b262-fafb845a0aec
# ╠═2923d3f5-c427-44a9-9b7e-8e34458b4fb4
# ╟─9f176d1f-39e4-4e4a-83dd-09751c92b91a
# ╟─0476d46a-b9d3-4f52-a461-5f997df6696d
# ╟─d90c4748-0ae2-4c2b-b795-face64b7e4d6
# ╟─e24f3b48-56c4-4869-bc53-64af098f6182
# ╟─873c12b0-8115-4fc4-998d-07ba25883df6
# ╠═b2cd7ec8-5ee9-4523-8e84-7ad92f9a76c3
# ╟─5131e8fb-3de1-4c1b-9a8c-a35e2e352ad2
# ╟─f5cf82e8-1aaa-452b-85da-28503108c97b
# ╟─169cd52b-44ef-46c1-a9c9-a36e14f0c44c
# ╟─1ebad95b-da33-4c73-9091-72419ab236f6
# ╠═0ffc2616-077b-4fc2-bc17-c987f6f470de
# ╟─2b7e69e3-270e-488d-a120-5b2029ce48b7
# ╟─0b8f9c31-f74d-4021-9b13-1b565da3918e
# ╠═b7e964ea-ed6e-42cd-a9ce-6ee1f12caedb
# ╠═af20c2ea-26f0-4def-aa47-c09d255cece8
# ╟─9fb13e92-41bc-4948-8e5e-7db1e0fd4571
# ╟─b432b0a5-1333-46c7-b616-657dcc5c9bb7
# ╟─84d93def-10b6-4108-9b32-9ae6199f3c06
# ╟─069d947f-261b-4ac6-a679-345d5e3d4879
# ╟─04ae7282-aaef-44b3-928c-105b905b39b1
# ╟─413f497a-8917-448c-923d-f89938bb75ea
# ╠═7919291c-85f2-43b1-8a6a-486d98a1f8ca
# ╟─01e85628-c172-45ff-a959-447fb536a046
# ╟─b2681f86-0941-460b-9364-83e84d96e771
# ╟─c332fd77-2c8d-407b-9b26-61ed97bb7d02
# ╠═8fc1994c-9dc7-48aa-aaa6-0d30accf77c0
# ╟─f7676f1c-afe7-4b0a-bd1b-95253749444c
# ╟─db42fc9a-128a-4cce-bf2e-d4aff43d52aa
# ╠═3b315cdc-0e3c-4201-9f48-0ddebdd56f22
# ╟─359a134c-f8cc-4308-8a18-ed0d1392ea9f
# ╠═8b226a7b-bc4b-4197-93fc-99d16946b71e
# ╟─827e892e-1630-44ce-b25c-42c280d97816
# ╟─422f584a-0775-4514-8356-8425475fea74
# ╟─b1dcbdaf-0d8f-4b2a-bc21-06b1c5541c1a
# ╟─8d8f8e8d-3ecd-4f30-8a9c-0b6a82dc85c9
# ╟─73035108-ce5a-4bca-8fb3-6e6c097ea4e0
# ╟─ef757caa-cc6f-4934-be18-bcb292c92fc9
# ╟─2140af27-202a-40e4-800e-f5d08c9ccfca
# ╟─f79caae4-82b6-4917-b3b4-fc180d2f188f
# ╟─b5ded038-cd25-4da6-8429-0c162dae4477
# ╟─3c04f72e-06be-4ed1-b0d8-ce32b8723b29
# ╟─f3beefea-a678-4e9c-8dcd-2059767a97c4
# ╟─5cd1e0c4-2eec-4470-bcf1-21298b29fb6d
# ╟─312645a8-7098-474d-b3b3-1499b96606d8
# ╟─12519278-2cd1-42a3-8b24-eae19910649a
# ╟─7412c059-dd62-4c77-919f-be095b5664f2
# ╟─16933177-1655-4d68-b2be-6a2d26d02280
# ╟─feda8823-b422-43f2-969b-c4becc9c3cb7
# ╟─37256831-071a-4f90-937d-c9bad69ad643
# ╟─ab9cc707-2ce2-4eb2-987f-c27755dd9d85
# ╟─a9de66ab-deab-4e4c-a5f9-a672805a24a4
# ╟─c003b9a6-7d8b-4b49-ad41-1661618522b4
# ╟─06ae56ec-52d0-46d1-96da-3613ecc56df2
# ╟─bc2a479e-a961-43ef-b430-afd69b496ac0
# ╟─b467ed22-2892-4875-a2b7-173efafa5a8d
# ╟─68fff8eb-4988-4c68-a543-2ddef8e4c428
# ╠═3b461ddf-3b4b-457b-9f9c-f606d8b260aa
# ╠═0cc7f332-f41a-4822-bcad-f06ee56d110f
# ╟─a916e2c4-ef39-4bd0-8c96-732ae356a8b1
# ╟─bb928631-6cf1-4f9a-ac8b-1fa072d19f69
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
