### A Pluto.jl notebook ###
# v0.19.46

#> [frontmatter]
#> chapter = 1
#> section = 6
#> order = 6
#> title = "✏️ Motor série"
#> layout = "layout.jlhtml"
#> tags = ["lecture", "module2"]
#> date = "2024-09-09"
#> 
#>     [[frontmatter.author]]
#>     name = "Ricardo Luís"
#>     url = "https://ricardo-luis.github.io/"

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

# ╔═╡ eb4f8227-3010-445a-bc26-1fee616643b6
using PlutoUI, PlutoTeachingTools, Plots, Dierckx
#= 
Brief description of the used Julia packages:
  - PlutoUI.jl, to add interactivity objects
  - PlutoTeachingTools.jl, to enhance the notebook
  - Plots.jl, visualization interface and toolset to build graphics
  - Dierckx.jl, tool for data interpolation
=#

# ╔═╡ ef7d6793-a4a7-41b6-82ce-0bd3157d19e8
TwoColumnWideLeft(md"`SeriesMotor.jl`", md"`Last update: 09·09·2024`")

# ╔═╡ 37ef79eb-cef5-458e-8994-14bdcc885478
md"""
---
$\textbf{MÁQUINAS ELÉTRICAS DE CORRENTE CONTÍNUA}$

$\text{EXERCÍCIO 11}$ 

$\textbf{Motor série}$
---
"""

# ╔═╡ 3963c379-c74e-48a3-97e3-7a1352422a8e
md"""
# Exercício 11. Dados:
"""

# ╔═╡ 8cf2189b-a1fb-454f-a5bb-8c2caa1b6532
(Pᵤₙ, Uₙ, nₙ, ηₙ, nₘₐₓ, nmag) = (12e3, 250, 1400, 80, 2400, 1500);

# ╔═╡ 7b358be8-59b1-4494-8c48-d842b10c5912
md"""
**Um motor série de $(Pᵤₙ/1000)kW, $(Uₙ)V, $(nₙ)rpm, $(ηₙ)% de rendimento, velocidade máxima
$(nₘₐₓ)rpm, tem a seguinte característica magnética obtida a $(nmag)rpm:**
"""

# ╔═╡ b099a590-b481-4748-bf4b-b6be08e958ea
begin
	Iₑₓ = [10, 20, 30, 40, 50, 60, 70, 80]
	E₀ = [80.0, 140, 190, 225, 250, 270, 285, 295]
	Iₑₓ, E₀
end;

# ╔═╡ aa89c8da-459e-4c4f-852b-55373d9c8fa1
(Rᵢ, Rₛ)=(0.35, 0.1);

# ╔═╡ 415a598c-3eaa-4a9a-b2c8-43e6ef34d0a2
md"""
**Sabendo que a resistência do induzido é $(Rᵢ)Ω, do indutor é $(Rₛ)Ω, calcular:**
"""

# ╔═╡ bcf9e628-959c-4c4d-bb00-9e683413d3f9


# ╔═╡ 8e3c4cdd-a4ea-4ab6-82d2-2bb01f176680
md"""
# a) $$p_{(mec+Fe)}$$
**As perdas mecânicas e no ferro, $$p_{(mec+Fe)}$$, em carga;**
"""

# ╔═╡ 58ab2478-3e28-461a-97fb-5e50c1248931
md"""
As perdas mecânicas e magnéticas de uma máquina de corrente contínua,  $$p_{(mec+Fe)}$$, também designadas como perdas rotacionais, $$p_{rot}$$, têm um comportamento aproximadamente constante, considerando tensão de alimentação constante  e variações de velocidade não muito expressivas.\
Assim, genericamente, pode obter-se o resultado das perdas rotacionais a partir de ensaio em vazio do motor, ou usando os dados nominais da chapa de características.\

No caso concreto do motor série, o ensaio em vazio apenas seria possível operando a máquina como gerador série, pois como poderá constatar adiante neste exercício, o motor série não pode perder a carga mecânica aplicada ao veio de rotação.
"""

# ╔═╡ fa13e734-4453-4bfe-910c-71c4734bd07b
Iₙ = Pᵤₙ / (Uₙ * ηₙ / 100)

# ╔═╡ 8ca57c4e-c674-4899-ae77-c03ceaa7c691
begin
	pᵣₒₜ = Pᵤₙ / (ηₙ / 100) - Pᵤₙ -(Rᵢ + Rₛ)Iₙ^2
	pᵣₒₜ = round(pᵣₒₜ, digits=0)
end;

# ╔═╡ 9a478bbc-1984-436c-8558-53376fc48a04
md"""
Assim, as perdas rotacionais obtêm-se do balanço de potência do motor série em regime nominal:

$$p_{rot}=P_{ab}-P_{un}-p_J$$

ou seja, 

$$p_{rot}=\frac{P_{un}}{\eta}-P_{un}-(Rᵢ+Rₛ)Iₙ^2$$

onde,

$$I_n=\frac{P_{ab}}{U_n}$$   

Calculando, obtém-se: $$p_{rot}=$$ $(pᵣₒₜ)W
"""

# ╔═╡ 73c7adad-e494-4566-8ecb-51d657819f30


# ╔═╡ 656b989f-f988-4eb5-b464-e1326104a9d6
md"""
# b) $$I_{min}$$
**O valor mínimo da corrente que o motor pode absorver;**
"""

# ╔═╡ d1664dac-d1c1-491a-b92e-f28470ac4f01
md"""
A velocidade é inversamente proporcional ao fluxo magnético, por conseguinte, se o fluxo reduzir acentuadamente, conduz a velocidades de funcionamento perigosas, situação comummente designada por **embalamento do motor de corrente contínua**.

O motor série tem na sua chapa de características uma de duas indicações para prevenir o seu embalamento do motor:
- velocidade máxima
- corrente mínima

Assim, para pontos de funcionamento ($$I$$, $$n$$) da característica de velocidade relativos a binários de carga reduzidos, a curva de velocidade tende a tornar-se assimptótica e por conseguinte, o motor ter um funcionamento instável.
"""

# ╔═╡ e4b2a383-b37e-4b82-ad57-7ae8b743c340
md"""
A obtenção da característica de velocidade do motor série permite encontrar a corrente mínima, $$I_{min}$$, observando o ponto de funcionamento correspondente à velocidade máxima, $$n_{max}$$.
"""

# ╔═╡ 77c74f69-5033-4ba9-b0d8-8c17110f477d
md"""
Este exercício não traz informação sobre a q.d.t. devido à reação magnética do induzido, com excepção em regime nominal (como se verá adiante), pelo que se considera nula para os diversos valores de corrente considerados na determinação da característica de velocidade: $$\Delta E=0$$V.

Assim, a característica de velocidade obedece a:

$$n=\frac{U-(R_i+R_s)I}{kϕ}$$ com $$n$$ em rpm, $$kϕ=f(I)$$, em V/rpm:
"""

# ╔═╡ c2d9b1c5-4330-426e-9b60-e0e37476121d
begin
	I = 0:1:Iₙ*1.25
	# computational method of querying the E₀(Iₑₓ) curve, by interpolating the data using Pkg Dierckx.jl:
	E_int = Spline1D(Iₑₓ,E₀, k=1, bc="extrapolate")  
	E₀ᵢ = E_int(I)
	kϕ =E₀ᵢ / nmag
end

# ╔═╡ 781ddebe-67b7-4a52-bb9d-154f40a1fd28
n= (Uₙ .- (Rᵢ + Rₛ)I) ./ kϕ

# ╔═╡ ee722749-602d-4f89-8dd9-fcb1d673f554
begin
	# computational method of querying the n(I) curve, by interpolating the data using Pkg Dierckx.jl:
	n_int = Spline1D(-n,I)  
	Iₘᵢₙ = n_int(-nₘₐₓ)
	Iₘᵢₙ = round(Iₘᵢₙ, digits=1)
end;

# ╔═╡ d215327c-a380-471a-a761-faade0c2020d
md"""
Consultando a característica de velocidade obtida verifica-se para $$n_{max}=$$ $(nₘₐₓ)rpm uma corrente mínima: $$I_{min}=$$ $(Iₘᵢₙ)A
"""

# ╔═╡ 16259eea-b205-4887-a09c-decba225f381
begin
	plot(I, n, title="n=f(I)", xlabel = "I (A)", ylabel="n (rpm)", xlims=(0,Iₙ*1.25), ylims=(0,n[10]), framestyle = :origin, minorticks=5, label=:none, linewidth=2)
	plot!([nₘₐₓ], seriestype = :hline, label=:none, linewidth=1, linestyle=:dash, linecolor=:red)
	plot!([Iₘᵢₙ], seriestype = :vline, label="Iₘᵢₙ(nₘₐₓ)=$(Iₘᵢₙ)A", linewidth=1, linestyle=:dash, linecolor=:red)
end

# ╔═╡ 024d8f06-f459-4431-9d46-b0e1b904b19c


# ╔═╡ e348ff8f-16cd-40ca-8f15-057158b5dad2
md"""
# c) $$ΔE$$
**A queda de tensão devida à reação magnética do induzido a plena carga;**
"""

# ╔═╡ de95a620-19dc-4f7f-8cce-7cf5a4c47d14
md"""
Nas condições nominais, dado que se tem o conhecimento da velocidade pela leitura da chapa de caracteríticas do motor série, é possível aferir o valor da velocidade, conhecidas as quedas de tensão da máquina devido aos enrolamentos indutor e induzido e valor das FCEM da máquina na situação nominal.
Assim, tém-se:
"""

# ╔═╡ c5408a8d-8ed4-43cd-b712-65806e55c0da
md"""
$$ΔE=E_{0}^{'}-E^{'}$$
$$E^{'}=U_n-(R_i+R_s)I_n$$
$$E_{0}^{'}=kϕ_0*n_n$$
$$kϕ_0=\frac{E_{0} (I_n)} {n_{mag}}$$
"""

# ╔═╡ 4f617818-ea32-4f00-a9dc-8f0e2c38525d
begin
	E₀ₙ = E_int(Iₙ)			# EMF for Iₙ. Querying the no-load curve
	kϕ₀ = E₀ₙ / nmag   		# kϕ₀ for Iₙ
	Eʼ₀ = kϕ₀ * nₙ     		# Back-EMF for Iₙ
	Eʼ = Uₙ - (Rᵢ + Rₛ)Iₙ  	# Efective back-EMF for Iₙ
	ΔE = Eʼ₀ - Eʼ
end;

# ╔═╡ 04c1c186-d018-4f27-9632-005e4dd4271e
md"""
Alternativamente, a conjugação das expressões anteriores conduz à expressão da velocidade que permite também o cálculo de $$ΔE$$:

$$n=\frac{U-R_iI_i+\Delta E}{k\phi_0}$$

Obtendo-se, $$ΔE=$$ $(ΔE)V
"""

# ╔═╡ 2f428692-91f9-4d6c-a860-07c36a43c939


# ╔═╡ 2eef0ec0-6878-479f-b27f-e00795704e61
md"""
# d) $$\eta_{max}$$
**A potência do motor que corresponde ao rendimento máximo;**
"""

# ╔═╡ 3b1aeb22-712d-429e-a76d-f2d3692af16a
md"""
A situação de rendimento máximo corresponde corresponde à igualdade entre perdas variáveis, $$p_v$$, e perdas constantes, $$p_c$$, na máquina:

$$ηₘₐₓ\Rightarrow p_v=p_c$$

No caso presente, tém-se:

$$p_v=(R_i+R_s)I^2$$
$$p_c=p_{rot}$$

Por conseguinte, a condição de rendimento máximo verifica-se quando:

$$I=\sqrt{\frac{p_{rot}}{R_i+R_s}}$$
"""

# ╔═╡ 765bc8ab-0c8e-482a-b6fb-4020d7813b3c
begin
	Iᵣₘ = √(pᵣₒₜ / (Rᵢ + Rₛ))   # Iᵣₘ, current relative to maximum motor efficiency
	Iᵣₘ = round(Iᵣₘ, digits=1)
end

# ╔═╡ ddcaf382-9f44-48e1-a44d-747910505e36
Pᵤ = Uₙ * Iᵣₘ - 2pᵣₒₜ;

# ╔═╡ cbfdf1f5-dd00-4796-87ea-529be3934620
md"""
Tendo em conta o balanço de potências na situação de rendimento máximo, resulta a potência útil: $$P_u=$$ $(Pᵤ/1000)kW"""

# ╔═╡ 5931d230-68e9-4003-bf94-800fbda03e79


# ╔═╡ 21baaeb1-a64e-4931-abd8-2efb4ec6583d
md"""
# e) 💻 $$\:n=f(I)$$ com ⇅ de $$R_{cs}$$ 

**Explicite qualitativamente a influência do reóstato de campo sobre a característica de velocidade do motor série.**
"""

# ╔═╡ 2ffca9f8-0fe3-47e7-9b26-e0a5c62514a6
md"""
Numa máquina DC série o reostato de campo é colocado em paralelo com o enrolamento de excitação, criando um divisor de corrente que permite regular o fluxo magnético indutor:
"""

# ╔═╡ 8964d631-c3c8-4e15-a2f6-272877e7e250
html"""
<iframe frameborder="0" style="width:100%;height:450px;" src="https://viewer.diagrams.net/?tags=%7B%7D&highlight=0000ff&edit=_blank&layers=1&nav=1&title=C%C3%B3pia%20do%20Diagrama%20sem%20nome.drawio#R7Vxbc5s4FP41ntl9MAMSNz%2FWuTQ7m%2B60aZrt9iVDjGzTYOQF7Dj99SuBwOhiLjZ2k22cmdYciYOk851zPh2UDODZYvM%2B9pbzD9hH4QDo%2FmYAzwcAjIBO%2FqWC51xgmUYumMWBn4sqgs%2FBD8SE7L7ZKvBRwnVMMQ7TYMkLJziK0CTlZF4c4ye%2B2xSH%2FFOX3gxJgs8TL5Slfwd%2BOs%2BlLnC28isUzObFkw17lLcsvKIzm0ky93z8VBHBiwE8izFO82%2BLzRkK6doV65Lfd7mjtRxYjKK0zQ1evP5y7YZJ%2FMn9Nvp%2Bc4Hx3fnQYPNYe%2BGKzZiNNn0uliDGq8hHVIsxgOOneZCiz0tvQlufiM2JbJ4uQtY8xVF66S2CkNr7NlgQ2wH9L%2FRE%2Fr3BCy9iXZihgUuukzTGj%2BXqknUZxzj10gCTzudDSLtMgzA8wyGOsxFBx6I%2FRD6LPT8g86%2B0TbNPpe08iAkwcm1U5IXlMyu3uZf0h7Y8onQyZ7MpbaZThaGXJOy7vPjMHmsUp2hTETFjvEd4gdL4mXRhrabOgME8wwRWfv20xRko%2BswrGCsA5TFoz0rVW%2BuTLwwAO8CgP97cfbq3%2F7wab2Don5nP3y6GUDI98okzsEscp3M8w5EXXmyl4y046LJs%2B1xjvGSL%2BB2l6TMzuLdKMQ8YtAnSr5Xv%2F1BVmm1a7Pp8w3RnF8%2BVi48oJvhKUcxkFVxld%2B%2B0UYJX8YTN8OLp6vbu%2Bia%2Bu72Pp%2Fpk8WF6uxoarCOdfq0pYxQSoK75WKGyC7v1Iw7IWEoIwJGrAdOAzggaOjTNEQcI2zI1p9Js8epTL56hlGkULF8OsRUYategLjIs6cNRfLEmK5wwG1IHCEj8vPYeUPgRJwFzvQecpngh%2BpTvJfMSPV4YzGjXCYoyq1ZhUqh9x%2FqkFF5U15KOZbGZ0eyjoZC4ekz7aUHkryYpjpPy270lBRsoBJtRT74NgcmZ0inSWcW3DVPh27AH31aaE1rN5kSR%2F46mTHIV4QjxBpAXTu25DX4bkcmUN9ELzt%2BpYHtjdsXdKbr8%2Fi5eJPDci%2FqIBRXTWgrLFrKDQwaPLGskICafuRQWJEWm3aDoyPHF1psBWYVf%2B6ghhopF4PtZrhKjRc4Pgba6XcURQ%2F44I6pQMygPyTpcIY8%2BCpgaHYe%2FAXREpkaCtYJG6NlHSWoEDnOZffj4Yxi1easDt3B548LRSJPZhWHKMLVtzdqNyYNCkK3imnaYstRN2bnHfNb%2Bd0Vp8VhFIMtGipViv1DIjGqzPWP%2FZ88IOGwVveiTh7mad6QDcJcbWUVU6CDzDkS9RJYPvxALICYmS1WhtMACC7VVeDBRe2SrSDnPzEqXMfpBmGUI7NW2JXypElwf5FWJLsfslODwOtsH1Ce4yL8MwpKoRsX21CjS2tdKimuT%2FXiTHJ68XkhOEncy0NwzJ4EmRTtyEjGq91zplvHSpPuAt%2FjLNfaa8ECnrbbevNVum3ygnHzKnpXk0xv3hXzuMV1DzjxQgUbR2L2FBuC2CA1hGCyTXbG0supesszrTNNgQy11iBlKDtDHspugyNzFwpuKlK%2FK%2BaWw%2F5UfSSv%2F4YUmyNbVgw4mcUaiSRS%2BcNIsCUGzK8zIwizbT7%2BsvXoPhQa9YVmgsCwWkJfFAgqgHm1ZWmxG5N0xx6lqmYS8mrXWeSF5HXBGEhe%2FbVK36tUceZsJW5SxOtY9XpkxO9vraAZSvoFQmOMERWdpI1DL9XfXvnRNzyoF1cp1cd2%2Bcr0z2L6kSjXnxa4OWqFEocjRXDjafji1jktaLam1AcK9QbHbFvIhxJPH23kQ8diSacVB78PkjaiScNbTyJ8dg0qO6mqmXjGvw1nfHlmt7N1Vr2MJIz12SGssdE1K421LTZkZp9PaAlYu%2BKOQJKuHQpZUylEV8SGFKwqa7C2OsAFqTbpjlAQ%2FGCukvsC25US5NR5Y5wrot%2FAWGeP1vnwwXR3qGgQjuxcHMGwOmENBAZ5OE3QcSLbg%2FW%2Bh7RCuLO31oPgur300E3fykqpjBzBVwWRXEOJDy6uIIbRLO5DVO9PBsUXXgOXy%2ByPYCxyHYqBxTxVp2lQY%2BqzDt6ypv5AwIVaeJR69b6m8LSHvWioHtvo5fZXK1RiymwhU5xd5nd8t7uBeNwruNTkC%2BXoZRdHe3xoKR5ycotBZ8T7nlEfeXvkhJ5odk%2ByQ09qLA5p17gvRPVAUtVucfpqGwfKuP4ubNm%2Fxco9XfSmhOuVoH8vkr7vg1Omw1b6lpjpXOXWlyW5Zj5RTrWVrhqWXH4NXW7ylbEi8XfOlZYiHOPXaUe6abm%2F5VWXKbnWuLmcBdU0H9oEQ3eOUxEGAPQ3zE4HhOM5%2BzK%2BRQvbE%2FMQB9878VDZrcUr17VDgvuTLgJxBoWOf9FCgei8NO8Wit8JU17hjQiHB7Hs4yxQzVcvDWb0VpeSzJHJRanhwbfyXKGAVTtdDAcsEwlnjgmAfWsESa%2BVAIGz9lLBUSeh1VR%2Feig97%2FsLdTy8%2B7A5orXFmNuHsDsW%2BF3kytn4bgPHvvzYgDFc4BmzJgDjW6Tz1jkV1DO10iBjuxgOLOksapXYNYspyFh0GafIW1IKsw7p8KCemPfNR1s%2BiGIZejOQhVsS0fHi%2FFoQd%2Fk2hY8mMXkUuTasXRq8EMWgCcU%2FJcK%2BknN0maL5VZNVVY1ZVOchbst1W%2BoXfDzJ%2FdmyVN5pfKOO29Lv%2FHenv7ai2%2BJbRcmuihsDjS97ewyEXcrn9Qxl59%2B1fG4EX%2FwE%3D"></iframe>
"""

# ╔═╡ 83e8d548-d212-49ec-89f4-d794c9d26c85
md"""
Assim, a corrente do enrolamento série, $$I_s$$, vem dado por:

$$I_s=\frac{R_{cs}}{R_{cs}+R_s}I$$

Consultando a característica magnética da máquina série para $$I_s$$ obtém-se o valor do fluxo magnético, traduzido no valor de $$kϕ$$ em (V/rpm):

$$kϕ(I_s)=\frac{E_0(I_s)}{n_{mag}}$$
"""

# ╔═╡ fb887b2d-9639-499b-9f1a-9cb3a4afaf73
md"""
Assim, a expressão da velocidade do motor terá a sua q.d.t. modificada pelo paralelo das resistências relativas ao enrolamento de excitação série e ao reóstato de campo:

$$n=\frac{U-[R_i+(R_s // R_{cs})]I}{kϕ(I_s)}$$

"""

# ╔═╡ a9bab890-8171-41cc-ae1d-80fc64d7196a
begin
	H4=("Rcs", @bind Rcs PlutoUI.Slider(0.05:0.01:4, default=4, show_value=true)) 
	H4
end

# ╔═╡ 0d9375fb-4b18-4c41-8f51-3e2c85af382c
begin
	Iₛ = (Rcs) .* I / (Rcs + Rₛ)
	E₀₁ = E_int(Iₛ)
	kϕ₁ = E₀₁/nmag
end;

# ╔═╡ 86f9c718-dd8d-46dd-930e-aff35147f214
begin
	R₁ = (Rcs * Rₛ) / (Rcs + Rₛ)  			# R1 = Rs // Rcs
	n₁ = (Uₙ .- (Rᵢ + R₁)I) ./ kϕ₁
end;

# ╔═╡ adedad68-149d-45e7-8a89-4e9c93c7f08a
plot(I, n₁, title="n=f(I), efeito de Rcs", xlabel = "I (A)", ylabel="n (rpm)", xlims=(0,Iₙ*1.25), ylims=(0,n[10]), framestyle = :origin, minorticks=5, label=:none, linewidth=2)

# ╔═╡ af4d65db-95bd-4552-acd7-52e218c17d60


# ╔═╡ e83a8a1a-512b-4dc9-acf1-1aeff19129c8
md"""
# f) 💻$$\:T=f(I)$$ com ⇅ de $$R_{cs}$$

**Explicite qualitativamente a influência do reóstato de campo sobre a característica de binário do motor série.**
"""

# ╔═╡ 577bfb9d-0c76-45cd-904c-f4a92f51cbec
md"""
Genericamente, a expressão do binário desenvolvido, $$T_d$$, é obtida por: 
$$T_d=kϕI$$  

No entanto, os valores de $$kϕ$$ têm estado a ser apresentados em V/rpm. Embora as "rotações por minuto" sejam uma unidade de uso generalizado, a velocidade angular é medida em rad/s no Sistema Internacional de Unidades. Assim, mantendo  $$kϕ$$ em V/rpm, a expressão do binário desenvolvido vem dada por:

$$T_d=kϕ\frac{60}{2π}I$$  
"""

# ╔═╡ d4f4837f-0d2f-4062-b943-74cfb2803bb7
Td = kϕ₁ * (60 / (2π)) .* I;

# ╔═╡ 6de1a6c2-11c8-497d-9a28-5dd19d6255c0
plot(I, Td, title="Td=f(I), efeito de Rcs", xlabel = "I (A)", ylabel="Td (Nm)", xlims=(0,Iₙ*1.25), ylims=(0,150), framestyle = :origin, minorticks=5, label=:none, linewidth=2)

# ╔═╡ ca47feed-7bce-4804-bc88-cce163bbc9c2
md"""
> Procure analisar o efeito da variação do reóstato de campo no comportamento das características de velocidade e binário do motor série, justificando.
"""

# ╔═╡ a5718dd1-fa17-4d7e-9afa-775cdcc06c53
# to adjust the notebook margins and used font-family/size on text content
html"""<style>
main {
    max-width: 60%;
    margin-left: 5%;
    margin-right: 35%;
}
pluto-output {
    font-family: system-ui;
	font-size:  100%
}
</style>
"""

# ╔═╡ 9506d40e-5910-4fec-afbf-88467deb306b
md"""
# *Notebook*
"""

# ╔═╡ 1f9a1b1c-6aea-4f1b-b526-8b9e53a72269
md"""
Documentação das bibliotecas Julia utilizadas:  [Dierckx](https://github.com/kbarbary/Dierckx.jl), [Plots](http://docs.juliaplots.org/latest/), [PlutoUI](https://juliahub.com/docs/PlutoUI/abXFp/0.7.6/), [PlutoTeachingTools](https://juliapluto.github.io/PlutoTeachingTools.jl/example.html).
"""

# ╔═╡ 30dbbbea-aec6-416e-b7f1-216613a153a5
begin
	version=VERSION
	md"""
*Notebook* realizado em linguagem de computação científica Julia versão $(version).
"""
end

# ╔═╡ deda94fe-5bba-4dea-a92d-3d4b7a46c76c
TableOfContents(title="Índice")

# ╔═╡ ca7a3b31-d96d-42a4-b02d-7e620f1043f3
md"""
!!! info "Informação"
	No índice deste *notebook*, os tópicos assinalados com "💻" requerem a participação do estudante.
"""

# ╔═╡ 67f64140-dfe4-461e-a20a-7d5f3169c115
md"""
|  |  |
|:--:|:--|
|  | This notebook, [SeriesMotor.jl](https://ricardo-luis.github.io/isel-me2/Fall23/data_science/SeriesMotor/), is part of the collection "[_Notebooks_ Reativos de Apoio a Máquinas Elétricas II](https://ricardo-luis.github.io/isel-me2/)" by Ricardo Luís. |
| **Terms of Use** | This work is licensed under the Creative Commons Attribution-ShareAlike 4.0 International License ([CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)) for text content and under the [MIT License](https://www.tldrlegal.com/license/mit-license) for Julia code snippets.|
|  | $©$ 2022-2024 [Ricardo Luís](https://ricardo-luis.github.io/) |
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Dierckx = "39dd38d3-220a-591b-8e3c-4c3a8c710a94"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
Dierckx = "~0.5.3"
Plots = "~1.40.3"
PlutoTeachingTools = "~0.2.15"
PlutoUI = "~0.7.59"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.5"
manifest_format = "2.0"
project_hash = "c3bd0cf14c4f4d701094d29d675a102452b14a1f"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BitFlags]]
git-tree-sha1 = "2dc09997850d68179b69dafb58ae806167a32b1b"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.8"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9e2a6b69137e6969bab0152632dcb3bc108c8bdd"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+1"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "7eee164f122511d3e4e1ebadb7956939ea7e1c77"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "1.3.6"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "b8fe8546d52ca154ac556809e10c75e6e7430ac8"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.5"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "67c1f244b991cad9b0aa4b7540fb758c2488b129"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.24.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "a1f44953f2382ebb937d60dafbe2deea4bd23249"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.10.0"

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.ColorVectorSpace.weakdeps]
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "fc08e5930ee9a4e03f84bfb5211cb54e7769758a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.10"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "b1c55339b7c6c350ee89f2c1604299660525b248"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.15.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "6cbbd4d241d7e6579ab354737f4dd95ca43946e1"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.4.1"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "1d0a14036acb104d9e89698bd408f63ab58cdc82"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.20"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.Dierckx]]
deps = ["Dierckx_jll"]
git-tree-sha1 = "d1ea9f433781bb6ff504f7d3cb70c4782c504a3a"
uuid = "39dd38d3-220a-591b-8e3c-4c3a8c710a94"
version = "0.5.3"

[[deps.Dierckx_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6596b96fe1caff3db36415eeb6e9d3b50bfe40ee"
uuid = "cd4c43a9-7502-52ba-aa6d-59fb2a88580b"
version = "0.1.0+0"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8e9441ee83492030ace98f9789a654a6d0b1f643"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+0"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "dcb08a0d93ec0b1cdc4af184b26b591e9695423a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.10"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "4558ab818dcceaab612d1bb8c19cee87eda2b83c"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.5.0+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "466d45dc38e15794ec7d5d63ec03d776a9aff36e"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.4+1"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "d8db6a5a2fe1381c1ea4ef2cab7c69c2de7f9ea0"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.1+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "ff38ba61beff76b8f4acad8ab0c97ef73bb670cb"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.9+0"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Preferences", "Printf", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "UUIDs", "p7zip_jll"]
git-tree-sha1 = "3437ade7073682993e092ca570ad68a2aba26983"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.73.3"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "a96d5c713e6aa28c242b0d25c1347e258d6541ab"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.73.3+0"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "359a1ba2e320790ddbe4ee8b4d54a305c0ea2aff"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.80.0+0"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "8e59b47b9dc525b70550ca082ce85bcd7f5477cd"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.5"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

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

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "a53ebe394b71470c7f97c2e7e170d51df21b17af"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.7"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "7e5d6779a1e09a36db2a7b6cff50942a0a7d0fca"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.5.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "3336abae9a713d2210bb57ab484b1e065edd7d23"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.0.2+0"

[[deps.JuliaInterpreter]]
deps = ["CodeTracking", "InteractiveUtils", "Random", "UUIDs"]
git-tree-sha1 = "5d3a5a206297af3868151bb4a2cf27ebce46f16d"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.9.33"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d986ce2d884d49126836ea94ed5bfb0f12679713"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "15.0.7+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

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

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "f9557a255370125b405568f9767d6d195822a175"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.17.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "dae976433497a2f841baadea93d27e68f1a12a97"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.39.3+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "2da088d113af58221c52828a80378e16be7d037a"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.5.1+1"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "0a04a1318df1bf510beb2562cf90fb0c386f58c4"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.39.3+1"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "a2d09619db4e765091ee5c6ffe8872849de0feea"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.28"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "c1dd6d7978c12545b4179fb6153b9250c96b0075"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.3"

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

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "c067a280ddc25f196b5e7df3877c6b226d390aaf"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.9"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "af81a32750ebc831ee28bdaaba6e1067decef51e"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.2"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "3da7367955dcc5c54c1ba4d402ccdc09a1a3e046"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.0.13+1"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+1"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "64779bc4c9784fee475689a1752ef4d5747c5e87"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.42.2+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "1f03a2d339f42dca4a4da149c7e15e9b896ad899"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.1.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "7b1a9df27f072ac4c9c7cbe5efb198489258d1f5"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.1"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "3bdfa4fa528ef21287ef659a89d686e8a1bcb1a9"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.40.3"

    [deps.Plots.extensions]
    FileIOExt = "FileIO"
    GeometryBasicsExt = "GeometryBasics"
    IJuliaExt = "IJulia"
    ImageInTerminalExt = "ImageInTerminal"
    UnitfulExt = "Unitful"

    [deps.Plots.weakdeps]
    FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"
    ImageInTerminal = "d8c32880-2388-543b-8c61-d9f865259254"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

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

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "37b7bb7aabf9a085e0044307e1717436117f2b3b"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.5.3+1"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "ffdaf70d81cf6ff22c2b6e733c900c3321cab864"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.1"

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

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "3bac05bc7e74a75fd9cba4295cde4045d9fe2386"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "66e0a8e672a0bdfca2c3f5937efb8538b9ddc085"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1ff449ad350c9c4cbc756624d6f8a8c3ef56d3ed"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "5cf7606d6cef84b543b483848d4ae08ad9832b21"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.3"

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

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
git-tree-sha1 = "96612ac5365777520c3c5396314c8cf7408f436a"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.11.1"
weakdeps = ["Random", "Test"]

    [deps.TranscodingStreams.extensions]
    TestExt = ["Test", "Random"]

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

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "3c793be6df9dd77a0cf49d80984ef9ff996948fa"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.19.0"

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    InverseFunctionsUnitfulExt = "InverseFunctions"

    [deps.Unitful.weakdeps]
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "e2d817cc500e960fdbafcf988ac8436ba3208bfd"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.6.3"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Vulkan_Loader_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Wayland_jll", "Xorg_libX11_jll", "Xorg_libXrandr_jll", "xkbcommon_jll"]
git-tree-sha1 = "2f0486047a07670caad3a81a075d2e518acc5c59"
uuid = "a44049a8-05dd-5a78-86c9-5fde0876e88c"
version = "1.3.243+0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "7558e29847e99bc3f04d6569e82d0f5c54460703"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.21.0+1"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "93f43ab61b16ddfb2fd3bb13b3ce241cafb0e6c9"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.31.0+0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "532e22cf7be8462035d092ff21fada7527e2c488"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.12.6+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "ac88fb95ae6447c8dda6a5503f3bafd496ae8632"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.4.6+0"

[[deps.Xorg_libICE_jll]]
deps = ["Libdl", "Pkg"]
git-tree-sha1 = "e5becd4411063bdcac16be8b66fc2f9f6f1e8fe5"
uuid = "f67eecfb-183a-506d-b269-f58e52b52d7c"
version = "1.0.10+1"

[[deps.Xorg_libSM_jll]]
deps = ["Libdl", "Pkg", "Xorg_libICE_jll"]
git-tree-sha1 = "4a9d9e4c180e1e8119b5ffc224a7b59d3a7f7e18"
uuid = "c834827a-8449-5923-a945-d239c165b7dd"
version = "1.2.3+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "afead5aba5aa507ad5a3bf01f58f82c8d1403495"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.6+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6035850dcc70518ca32f012e46015b9beeda49d8"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.11+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "34d526d318358a859d7de23da945578e8e8727b7"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.4+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8fdda4c692503d44d04a0603d9ac0982054635f9"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.1+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "b4bfde5d5b652e22b9c790ad00af08b6d042b97d"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.15.0+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "730eeca102434283c50ccf7d1ecdadf521a765a4"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.2+0"

[[deps.Xorg_xcb_util_cursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_jll", "Xorg_xcb_util_renderutil_jll"]
git-tree-sha1 = "04341cb870f29dcd5e39055f895c39d016e18ccd"
uuid = "e920d4aa-a673-5f3a-b3d7-f755a4d47c43"
version = "0.1.4+0"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "330f955bc41bb8f5270a369c473fc4a5a4e4d3cb"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.6+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "691634e5453ad362044e2ad653e79f3ee3bb98c3"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.39.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e92a1a012a10506618f10b7047e478403a046c77"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.5.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e678132f07ddb5bfa46857f0d7620fb9be675d3b"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.6+0"

[[deps.eudev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "gperf_jll"]
git-tree-sha1 = "431b678a28ebb559d224c0b6b6d01afce87c51ba"
uuid = "35ca27e7-8b34-5b7f-bca9-bdc33f59eb06"
version = "3.2.9+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a68c9655fbe6dfcab3d972808f1aafec151ce3f8"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.43.0+0"

[[deps.gperf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3516a5630f741c9eecb3720b1ec9d8edc3ecc033"
uuid = "1a1c6b14-54f6-533d-8383-74cd7377aa70"
version = "3.1.1+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3a2ea60308f0996d26f1e5354e10c24e9ef905d4"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.4.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.libevdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "141fe65dc3efabb0b1d5ba74e91f6ad26f84cc22"
uuid = "2db6ffa8-e38f-5e21-84af-90c45d0032cc"
version = "1.11.0+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libinput_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "eudev_jll", "libevdev_jll", "mtdev_jll"]
git-tree-sha1 = "ad50e5b90f222cfe78aa3d5183a20a12de1322ce"
uuid = "36db933b-70db-51c0-b978-0f229ee0e533"
version = "1.18.0+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "d7015d2e18a5fd9a4f47de711837e980519781a4"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.43+1"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "814e154bdb7be91d78b6802843f76b6ece642f11"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.6+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "9c304562909ab2bab0262639bd4f444d7bc2be37"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+1"
"""

# ╔═╡ Cell order:
# ╟─ef7d6793-a4a7-41b6-82ce-0bd3157d19e8
# ╟─37ef79eb-cef5-458e-8994-14bdcc885478
# ╟─3963c379-c74e-48a3-97e3-7a1352422a8e
# ╟─7b358be8-59b1-4494-8c48-d842b10c5912
# ╠═8cf2189b-a1fb-454f-a5bb-8c2caa1b6532
# ╠═b099a590-b481-4748-bf4b-b6be08e958ea
# ╟─415a598c-3eaa-4a9a-b2c8-43e6ef34d0a2
# ╠═aa89c8da-459e-4c4f-852b-55373d9c8fa1
# ╟─bcf9e628-959c-4c4d-bb00-9e683413d3f9
# ╟─8e3c4cdd-a4ea-4ab6-82d2-2bb01f176680
# ╟─58ab2478-3e28-461a-97fb-5e50c1248931
# ╟─9a478bbc-1984-436c-8558-53376fc48a04
# ╠═fa13e734-4453-4bfe-910c-71c4734bd07b
# ╠═8ca57c4e-c674-4899-ae77-c03ceaa7c691
# ╟─73c7adad-e494-4566-8ecb-51d657819f30
# ╟─656b989f-f988-4eb5-b464-e1326104a9d6
# ╟─d1664dac-d1c1-491a-b92e-f28470ac4f01
# ╟─e4b2a383-b37e-4b82-ad57-7ae8b743c340
# ╟─77c74f69-5033-4ba9-b0d8-8c17110f477d
# ╠═c2d9b1c5-4330-426e-9b60-e0e37476121d
# ╠═781ddebe-67b7-4a52-bb9d-154f40a1fd28
# ╟─d215327c-a380-471a-a761-faade0c2020d
# ╠═ee722749-602d-4f89-8dd9-fcb1d673f554
# ╟─16259eea-b205-4887-a09c-decba225f381
# ╟─024d8f06-f459-4431-9d46-b0e1b904b19c
# ╟─e348ff8f-16cd-40ca-8f15-057158b5dad2
# ╟─de95a620-19dc-4f7f-8cce-7cf5a4c47d14
# ╟─c5408a8d-8ed4-43cd-b712-65806e55c0da
# ╠═4f617818-ea32-4f00-a9dc-8f0e2c38525d
# ╟─04c1c186-d018-4f27-9632-005e4dd4271e
# ╟─2f428692-91f9-4d6c-a860-07c36a43c939
# ╟─2eef0ec0-6878-479f-b27f-e00795704e61
# ╟─3b1aeb22-712d-429e-a76d-f2d3692af16a
# ╠═765bc8ab-0c8e-482a-b6fb-4020d7813b3c
# ╟─cbfdf1f5-dd00-4796-87ea-529be3934620
# ╠═ddcaf382-9f44-48e1-a44d-747910505e36
# ╟─5931d230-68e9-4003-bf94-800fbda03e79
# ╟─21baaeb1-a64e-4931-abd8-2efb4ec6583d
# ╟─2ffca9f8-0fe3-47e7-9b26-e0a5c62514a6
# ╟─8964d631-c3c8-4e15-a2f6-272877e7e250
# ╟─83e8d548-d212-49ec-89f4-d794c9d26c85
# ╠═0d9375fb-4b18-4c41-8f51-3e2c85af382c
# ╟─fb887b2d-9639-499b-9f1a-9cb3a4afaf73
# ╠═86f9c718-dd8d-46dd-930e-aff35147f214
# ╟─a9bab890-8171-41cc-ae1d-80fc64d7196a
# ╟─adedad68-149d-45e7-8a89-4e9c93c7f08a
# ╟─af4d65db-95bd-4552-acd7-52e218c17d60
# ╟─e83a8a1a-512b-4dc9-acf1-1aeff19129c8
# ╟─577bfb9d-0c76-45cd-904c-f4a92f51cbec
# ╠═d4f4837f-0d2f-4062-b943-74cfb2803bb7
# ╟─6de1a6c2-11c8-497d-9a28-5dd19d6255c0
# ╟─ca47feed-7bce-4804-bc88-cce163bbc9c2
# ╟─a5718dd1-fa17-4d7e-9afa-775cdcc06c53
# ╟─9506d40e-5910-4fec-afbf-88467deb306b
# ╟─1f9a1b1c-6aea-4f1b-b526-8b9e53a72269
# ╠═eb4f8227-3010-445a-bc26-1fee616643b6
# ╟─30dbbbea-aec6-416e-b7f1-216613a153a5
# ╠═deda94fe-5bba-4dea-a92d-3d4b7a46c76c
# ╟─ca7a3b31-d96d-42a4-b02d-7e620f1043f3
# ╟─67f64140-dfe4-461e-a20a-7d5f3169c115
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002