### A Pluto.jl notebook ###
# v0.19.46

#> [frontmatter]
#> chapter = 1
#> section = 5
#> order = 5
#> title = "📈 Ensaio back-to-back"
#> layout = "layout.jlhtml"
#> tags = ["lecture", "module2"]

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

# ╔═╡ e89303b7-3dbb-452c-bd71-ddaac5d22dc4
using PlutoUI, PlutoTeachingTools, Plots, EasyFit, PrettyTables, Statistics, BasicInterpolators, SankeyPlots
#= 
Brief description of the used Julia packages:
  - PlutoUI.jl, to add interactivity objects
  - PlutoTeachingTools.jl, to enhance the notebook
  - Plots.jl, visualization interface and toolset to build graphics
  - EasyFit.jl, interface for obtaining fits of 2D data
  - PrettyTables.jl, print data in matrices in a human-readable format (tables)
  - Statistics.jl, for basic statistics functionality
  - BasicInterpolators.jl, provides interpolation methods
  - SankeyPlots.jl, provides a Plots.jl recipe for Sankey diagrams
=#

# ╔═╡ 1aceb22f-57fe-4428-bbd7-3410a10e269e
TwoColumnWideLeft(md"`back2backlab.jl`", md"`Last update: 09·09·2024`")

# ╔═╡ c064e55c-6924-49b7-abbc-385a081c57b2
md"""
---
$\text{RELATÓRIO}$ 
$\textbf{Ensaio \emph{back-to-back} :}$
$\textbf{Análise de potências, perdas e rendimento de máquinas DC}$
---
"""

# ╔═╡ 01d6ccf1-a046-4386-95b9-7a8437e6bc48
md"""
# 1 - Introdução
"""

# ╔═╡ aa438d59-98d7-41b6-b34d-aa55220cf04f
md"""
## 1.1 - Objetivos
"""

# ╔═╡ 57972b14-d0eb-49f2-a8fe-fbfa25eb2f43
md"""
- Compreender o ensaio *back-to-back*;
- Ligar eletricamente máquinas DC em paralelo;
- Estabelecer o balanço de potências de uma máquina de corrente contínua (gerador e motor);
- Determinar curvas de rendimento das máquinas DC.
"""

# ╔═╡ dcfb10ac-3a34-477f-ae1e-6a4b42fdc0d2
md"""
## 1.2 - Ensaio *back-to-back*
"""

# ╔═╡ 5d618284-7f40-4d33-94a1-829407bd5f47
md"""
O ensaio *back-to-back* de máquinas elétricas de corrente contínua (DC) consiste em associar em paralelo um grupo motor-gerador (mecanicamente acoplados), ligados eletricamente a uma rede DC, como apresentado no esquema de ligações, [^Fig_2_1].

O funcionamento do grupo DC motor-gerador no ensaio *back-to-back* pode resumir-se nos seguintes passos:
- Após o arranque do motor este alimentará mecanicamente o gerador;
- O gerador é ligado à rede DC, após verificação das condições de paralelo;
- A regulação da corrente de excitação do gerador, $I_{ex}^G$, permite regular a potência elétrica que o gerador fornece à rede DC, carregando mecanicamente o motor;
- Em simultâneo, o motor absorve a potência elétrica produzida pelo gerador;
- Como os processos de conversão eletromecânica de energia nas máquinas têm perdas, a potência absorvida pela rede DC corresponderá ao somatório das perdas existentes no grupo motor-gerador.
"""

# ╔═╡ 07eeed4a-6a40-4585-b04f-26da0157fe2e
Foldable("Listagem das grandezas utilizadas neste relatório:",md"
-  $$U, I$$: tensão, corrente da rede DC\
-  $$p_t$$: perdas totais do sistema *back-to-back*\
-  $$R_i^M, R_i^G$$: resistências rotórica do motor e gerador, velocidade do grupo motor-gerador\
-  $$I_l^M, I_l^G$$: correntes de linha do motor e gerador\
-  $$P_{ab}^M, P_{ab}^G$$: potências absorvidas do motor e gerador\
-  $$I_{ex}^M, I_{ex}^G$$: correntes de campo do motor e gerador\
-  $$p_J^M, p_J^G$$:  perdas de Joule no induzido do motor e gerador\
-  $$p_{ex}^M, p_{ex}^G$$:  perdas de excitação (em derivação) do motor e gerador\
-  $$p_{ele}^M, p_{ele}^G$$:  perdas elétricas do motor e gerador\
-  $$p_{C}^M, p_{C}^G$$:  perdas constantes do motor e gerador\
-  $$P_d^M, P_d^G$$: potências desenvolvidas do motor e gerador\
-  $$T_d^M, T_d^G$$: binários desenvolvidos do motor e gerador\
-  $$p^M_{(mec+Fe)}=p^G_{(mec+Fe)}=p_{(mec+Fe)}$$: as perdas mecânicas e magnéticas, ou perdas rotacionais, $$p_{rot}$$, das máquinas consideram-se iguais, dado que as máquinas têm dimensões/características semelhantes\
-  $$T_d^M=T_d^G=T_d$$: também se conclui que os binários desenvolvidos são iguais, $$T_d=T_u+\frac{p_{rot}}{ω_m}$$ \
-  $$T_u, ω_m$$ ou $$n$$: binário mecânico, velocidade angular mecânica do grupo motor-gerador em $$\rm rads^{-1}\:$$ ou $$\:\rm rpm$$, respetivamente\
-  $$P_{u}^M, P_{u}^G$$: potências úteis do motor e gerador\
-  $$E^{'},E$$: força contra-eletromotriz do motor, força eletromotriz do gerador\
")

# ╔═╡ 1eb4379f-2d29-4dea-b6c5-cd2f81ed8381
aside((md"""
!!! info "Informação"
	👈 clicar em ▶ / ▼ para expandir/comprimir
"""), v_offset=-110)

# ╔═╡ 184d5409-76fa-4970-9da7-6d8c8bd79713
md"""
Seguindo o raciocício sobre o princípio de funcionamento do sistema *back-to-back*, a potência mecânica absorvida pelo gerador, $P_{ab}^G$, corresponde à potência útil do motor, $P_{u}^M$, $(1.2)$.   

Em $(1.1)$ e $(1.3)$ estabelecem-se os balanços de potências para o motor e gerador, respetivamente.

Substituindo $(1.1)$ em $(1.2)$ e recombinando com $(1.3)$ obtém-se $(1.4)$, mostrando que a diferença entre $P_{ab}^M$ e $P_{u}^G$, corresponde ao somatório das perdas do grupo motor-gerador.

Assim, o somatório das perdas corresponde à potência absorvida da rede DC, traduzida em $(1.5)$ e $(1.6)$.

As perdas elétricas do motor e gerador, $P_{el}^M$ e $P_{el}^G$, respetivamente, são determinadas pelo conhecimento dos seus circuitos induzidos e indutores (resistências, tensões e correntes).

Sobram as perdas mecânicas e do ferro, ou perdas rotacionais, de cada máquina DC. Se as máquinas a ensaiar tiverem dimensões e potências semelhantes, então assume-se os mesmo valor de $p_{rot}$ para ambas, $(1.7)$, resultando $(1.8)$. 

Caso tal não se verifique, uma possibilidade consiste em tomar uma ponderação que relacione a potência nominal de cada uma das máquinas DC, atribuindo um peso correnpondente, para o cálculo da perdas rotacionais.

Determinadas todas as perdas é exequível a análise de potências, perdas e rendimento das máquinas DC ensaiadas.
"""

# ╔═╡ f8de4a5c-64a2-49c4-88e2-c26c843b1fc1
md"""
$\begin{align}
\tag{1.1}
P_{ab}^M - p_J^M - p_{ex}^M - p_{rot}^M &= P_{u}^M \\

\tag{1.2}
P_{u}^M &= P_{ab}^G \\

\tag{1.3}
P_{ab}^G &= P_{u}^G + p_J^G + p_{ex}^G + p_{rot}^G \\

\tag{1.4}
P_{ab}^M - P_{u}^G &= p_J^M + p_{ex}^M + p_{rot}^M + p_J^G + p_{ex}^G + p_{rot}^G \\

\tag{1.5}
p_t &= p_{el}^M + p_{el}^G + p_{rot}^M + p_{rot}^G \\

\tag{1.6}
P_{ab}^M - P_{u}^G &= p_t = U I \\

\tag{1.7}
p_{rot}^M &\approx  p_{rot}^G \\

\tag{1.8}
p_{rot} &= \frac{1}{2} (p_t - p_{el}^M - p_{el}^G) \\
\end{align}$
"""

# ╔═╡ 39721ee5-b4f8-47ed-ae4f-0865952ebd28


# ╔═╡ 3010fa73-fdb8-4ad9-94dc-45db49ae7fcf
md"""
# 2 - Procedimento de ensaio
"""

# ╔═╡ f60d6cdd-7ff4-4a00-b2aa-a1440234ec6d
md"""
## 2.1 - Esquema de ligações
"""

# ╔═╡ cb2b0eb9-2037-4b45-9038-b2f6cd7a16cd
html"""
<iframe frameborder="0" style="width:100%;height:600px;" src="https://viewer.diagrams.net/?tags=%7B%7D&highlight=0000ff&edit=_blank&layers=1&nav=1&title=back2backlab.drawio#R7V1Zc6O4Fv41rpp5iAtJrI9ZOknP7dzpSXLTfeclRQxOmLaNG%2BMs%2FetHYISREItBApw4XdWJZSywzndWnXM0Qqfz14vAXj5d%2BY47G0HFeR2hsxGE0EAI%2F4pG3jYjAGj6ZuQx8JxkbDtw4%2F1yk0ElGV17jruiLgx9fxZ6S3pw4i8W7iSkxuwg8F%2Foy6b%2BjL7r0n50cwM3E3uWH%2F3mOeET%2BRq6tX3j0vUen5Jbm9DYvDG304s3A6sn2%2FFfNkPxl0OfRug08P1w89f89dSdRatH1mWzAucF76YPFriLsM4HPr1c3t59uQ7ubu%2BDqTKZX01v10fkazzbs3XyjZOnDd%2FIErgL5zhaSfxq4S%2Fw4Iljr57caFqAXzyF81ny5yoM%2FB%2FpOiE8gp8tePuOXyhj1UoH%2Fh8PaAiQgbMIMEr66i376qsbeHM3dINkMP%2B9CS7s4NFNhv64UO%2FOb%2Byv%2BvLbG7h98mZn352jhDKuQ5E8Wa0L18d3Cd7wBS9bQmsJDJ8yJCZjgTuzQ%2B%2BZBoqd4O0xnS69w1ffw08MlYQ5jqCRrHXCG5qpjQ1mmpW%2FDiZu8skscdnJgFY92WaBcpPhPzJffzsU44ePJe7yAg508FLfJC%2F9IHzyH%2F2FPfu0HT0J%2FPXCibEU0XZ7zRffXyao%2BscNw7dEMtjr0Kcx57564ffM3xts6aqWvN5CK3rxlnnBAmuF1yckSPcxR5Cxc2%2B2RTh%2BnTwL2ECUZQ48knwgeT97eZ5DCuG8IX0J74KacG6K0zci0UxZMCr7WmUSaRnd2w0%2BPeM1WyWUeXaD0MNy%2B4v94M6%2B%2Bisv9PwFfu%2FBD0N%2FHi09kb9KVoJFL%2ByZ9xhdOnEXMRqy8CLTHifXhBEso7mW0bPMXx8jvTd2Z1j3BNF1Y2%2FhrCehH6zSv%2B41LuGxxgptb1Et16JHcF9LSZxKAUOnpIBlJrIqI9KAypFpSCmGBUXgXamp9ykTsI7JSAWws0TIMHciD7bMXaTvKHZvztxQMnNvlZBCI0ZnkFDA7Xhd7LfMZTFLrkpuhAD%2FRltwbaYUKkvgfsuSwF15q1iWLP0QT%2Bj5MTrv%2BdgL%2FNBOHvQImIokEYN0ho4GR8QoHBGjyhIxWjWRaYny8uSF7s3SjhnwBS96lRW7GTn1Z34Qz4fO4x9JKwwNg%2BEUM7fCkLPALOcKW%2BDdfIREUpYuKE2PrZNAOwiJEberg0DZcYlRlrXjlJwcryu1sx5GK5OsMw%2BjQrjXdy9Mi5oJc7gkPZHKCb6eqPEBy5KvWFRdNk80MWEIHwGaj2AjNiplER6P1TJ2oBNe%2Bz9ens%2BDv6enn39%2Bv7v%2Fzz9HRJpV8lddq6gj%2FkIqzRU5V6k2fyGdnimV%2BaLZS1VobkkZWS67NAoz7aRCSp3uDFgfZv7kB0cjUJ69VsJNjZiplkq5vvryy7%2F838ufcHF3cqMtll9ubeJADQbyFqLwo5Mg1s6QhwzzpLFi4RrFMLmPLBXxJBxHIV6fYWqcTP348bbQ13%2BuffLG0SqG4DG%2BAKrL1%2B2beGBqT%2BgP3LmBYy%2Fs7EX6Y%2FQ7JPfCz7653WY8x3TYJg15nEZs3YQTp5hPmKGco8N6N3PPcWJ3nmdu09xLxZOlOC0ma1SoI9ak5oVFoDSfRe0THqsDPGiPywI0PGDf8OD5tJ3B4%2FQADzqqajFR1d6lh9EnPM4O8KDgobHo0PpFB7HIBBrbVVtjOQMalq3tUGxZlQmPqKihLasrFRNJ3jIz0IHizShuiaI4O5FsitcIeu8YfyqN9zQJRwmOEQ0s9qMCxn2FDaGUC8mYXUsPXixzo%2BEd77mJMUHsgXYmyWaWa9dxCw2OdDh%2BUHp0AM9%2BllrSDwHnoet8l49pUukaHWVKFWqGuS0OcxvSbCqzkEfaQeS3ETwBQLn7%2FWBU00a1Sm%2BCqsRc7s2q5oWwhSDg6EB%2FHv1pr0o18xJAFv25cXjxThW9onWyD7dGmc6a36Xr3rfNlBo2TbefVdZCkrT5DJDFvZHcJCVeNIeBVoMElky6ihL%2FcEGYlRPZK6WEWUlkhKyuYuV4GiAO%2FqSlDkGeWme5ejbzlqsisZhZdnu13FQgTL3XiFRt6CA3wUjTxzQlDBJByFICqHlKpIPiSdFev6oaT79e7ZdmlUJwYI2rWa%2FbELZ4g3qHEPbF8X6BQv4GKaAdLsPsGx%2Fize0d8HFZ7KZ%2FTHwAqPeGD36xkZJX1B0WFoyyxUYtS40KUlQ5CUnl1QhiSo1aJSG1T1g1x5oBVGgm%2FzNOoLzIaNnX3tfygbm3muBvaS9cf70aT9cr9x5ygeF4Af7Q5iExFqJxOXaISVshms4xOxHH%2FtclSZEaTv2QCbytDyF%2FxQTmkZPjcWC35k6iylBJPWhakZqP4EAOsQEokRutqG0dVIYUldGq2LqtygDYt6E0BhM3lrcxy7dLQJ8gA12DDNAgk1gC3QvIdtyR3T3eyGwiM6nJuQcRnbpctqj7qhRbWT2ZGkpZwRjWlerdCCIhvffQA6TvnY5t4xvG9jEat%2FZQoTZWLCM3n26YCvnpuNGHNhwd17rRxx5oOdCR%2B63p3WyzsfcRXbFZuoj7qtb67CuCTJUmWJdtRbjU1AYjgnbvKtJW%2FHTtydXWrS3Fj6rBMdC3PwYNuq49Oa3f1jW9QqxrDdcVxPIaTo5jpzLd2Ar9uoLn6sTPS%2FXAnmrEzZ%2F%2B0dydPNmLeCjy9vjBzoL0iqwPuIjYVY4CVSGNB43k%2FGQUKC%2FxBUjbPyMFqAcF2oEChd1IN9brlLhdVvo9DwJFukDBtB2YQIG71aC16BK1d91t1Jrs301sCjDlRobJSIm6gSm2LFpaTyhQEJcofDDmeuE9bvgM0GtR9qFmn45Y6EzEosOSfT46es13PDugI4sOTWHR0V3JPhcdqIYrJrKct6T0pErdDUSLsa0NG%2FehyisXOSEB9j6duPio0dZet1VLTfusFSK08hwApA0KyvmgVMOdQg2ozEQKSfvvyANEcnrxDq6UCVpMOQVJ%2B%2Bmikom%2F8nUakr63SiakoFwhU16Tyytk4lOivR%2FAL2S62C8jTga9VYWtY%2BIwXqeWm8qz3A51TD0Z9pDpGmBYfcODFxI9lDH1BA8VqcOCR7%2BN%2FK7JvVbrBzJmB0EGM5k3DkiiqxuYPHOd2FsdQOn15x9%2Fv329%2FHWif%2Fvx15%2FTv7zbk%2BVRr%2FGlz%2BfwgA9K0jCtDjQjvz%2FTKTxAr5Lm8zk44IPOAicF%2BIMBiJkjxeGkrhG9vcdfuISQ0nf3LTpMJOukrjSsxT%2BApXWgsnQR9zV1YIAndUFmn7fTg7q4RCay672c1MWWM3d5UBd%2FgcVvI%2B3pSV0DCe1Xyuy6of1cBr5ljZFqbX%2BkqAIES1VB9fWCCzv4oO81xHI4aYUSiaDHg1b46OClpR0OWukpPMuectbhOSvc1DwBwXutMTjS2H0mypZ1kxsE35rv8EXTnttzbxaR5hZraQxd5b%2FuC%2F7%2F2p%2Fbi5xxAAshksMDBzXFjjFiSl1VJR9Y0yUZVVyMVAqQ%2BhRPCb7EC9oAXJtZ7rIYiWf6eCChtYxGarX6wkilCXLASClGuPkFsdsWTccbl4AqMDRU9VKA2E9xTTEARjx%2FrmEiPp%2F8bfPpmfStulU3nInYLq1pVUeFu9g2F5E8sig%2FjW9r9dKxsU6C4hDhLBymbJZh3XLq2rWqokFa9MByQcoJmA1f5jYr1y5Xutlb9QZaQNpEk0oeYCnNUAsrZxIlW4tuJBe3QryUtqcl1bZZubPgB%2FKm3sQenaLRsRH%2Fj3x8tWNHWPNnduA5dnQYlOJEw49uYDsYulDZHrPU0NodYPSlyO7NsCZU5djB0ICMHQIAzKfVYuuEXEYl1oro%2BcLHeC871P3Yw%2Fx98XQrnLsvLtBSRmKleWPLOPXE6pkYwqRpL51ih4S08gyMwSMtZ5PW9sGYEIDeLfC4O%2BS9BqTRhw9IqyhXdEBMx97Cjbvt8%2B9e1teoaXXp%2BbHbHqBppkCq0SqL%2FOpImmzVXwlv9ZUJkD%2F8qulh0%2FnzYtkGDqK6E%2BcPpgXyPRkC5eGIQHgQgTkRaJBASW8iUPyR5%2FUOwN5FInISVZuZTmWHV1QLvoK4d1cHZSsseHQLiRJ98jpc8ZeyRm%2F0YSlegXjbFHf3l0rH6s%2BGVfLiGz4IRxmva0OvKlD76CqQ3Rvu3QVAPE%2BxY%2F23e5kGLexE6sJedRzbeFFX6%2B3b1m4SI7zGg31gwc1o%2BGJNwJGOYsWa%2BuHFGmTq5fs26w%2BB11KZ%2Bo7SZJqHaNmJVGYicTFarqoxa2jeLSRBtXSodzLRY2A7nkttCk7jn1Gu5c7JcfQv85kzTlNaO5gk%2BNS4yErKSqhiNUtSqdoRJEm%2BacdOM18OyyulgopWDMRWrRkMnhFeSObaxWrtWll1QQtk0joBAJK130VzK24RR41YT3ah65d8Fu7Ws6WediTqV3C8vl0Hi0TunzjRCqljS43ZCY9dunZ0K6SOzYhznFcYvUJjbA7WoHLKthkqA1is%2BVsWoDOVOgCAeiwH2NOmhJGZ1zyupxyWZOz0fBQddJ0zHOeVhuM7SUPp4Dy8VISnst%2FKVwUZJc6b%2BFYINbbX3qXox2q3R9HPj3PU6WA6wL6GLetbDIshBAlSdtLXkE%2BJSvHcsK%2Fh1X7JRyn0Jj7MlvHyrQQ6rYxENRpyvD%2B%2BY89GGALfqTx%2F89BPVAi9dTQaFtuplVs%2FMm3gi2C9jFKr537oB0dpgvXm%2Fg9Bxp615xGBFg%2Br6Ndv9sRfzuw5XvX40%2B4kTt6GC2%2Fi%2F75fIKvKwY5lVAc52HkLID3%2FOXvCD7mIlkQCwPnp5fL27st1cHd7H0yVyfxqertuuOdU%2F6DoQhN2IN1cjvCKs6mAGtN5pXYqAzAq5xKXzMAnp%2Fgswj2goMauutqcgpVzyW63X8dIe8cMiZDOUkBvmBWCzMqpJBOTa%2Be9b3ZESM3JwMb0q5xKcm4Yt%2B%2B%2FcGZsUoTZkWxFKnMeHCQVWzuLVsgeLZebSjYxee2URTDjoOnHRP%2Bg0px%2BVVNJph%2B37%2F5HYkamPXkLXgRVM8kmpfhM7%2BFTj3X%2BGnMiqJpJMvW03aya3VuSCuohOlwwIDYmqbDRp9rngxWdiyq8b2jukSsah%2BafTHDTaT42d3OAH%2ByVe4Y1RAt8Fp%2BQV9y4Yw%2Fx2bC8g53Jqtnsoz08IRzrmpL%2BdFDmRira%2B%2BlL%2BnOPo7ISoq3FIravfQCtfdtaFMEjJnnLbi2FE1HNSt9HvgsLrhqJ2pndAKSS18mXLErB2GkrADtTTGgDkd5d4uGJXwZ%2BROWtsIsS4K58x42u%2BBc%3D"></iframe>
"""

# ╔═╡ 127a7dbf-88fe-4b28-a265-7bf315850497
md"""
[^Fig_2_1]: Esquema de ligações do ensaio *back-to-back*.
"""

# ╔═╡ c387e50c-5aac-4901-b1f3-51b690c38a56
md"""
## 2.2 - Material utilizado
"""

# ╔═╡ dfa54345-bcae-4350-aa43-72cd62b83d65
md"""
**Bancada n.º3**

Máquinas DC de excitação composta (utilizadas em excitação derivação): Elektromotoren Werke Kaiser (fabricante) 

- Motor DC n.º 951 (5.5kW; 1500rpm; 220V; 29A):

| **V** | **A** | **kW** | **rpm** |
|:-----:|:-----:|:------:|:-------:|
|  178  |   29  |   4.4  |   1200  |
|  220  |   29  |   5.5  |   1500  |
|  220  |   29  |   5.5  |   2000  |
|       |       |        |         |
|  220  | 0.59 ... 0.35A | (excit.) |

		
- Gerador DC n.º 942 (4.0kW; 250V; 16A; 1500rpm):

| **V** | **A** | **kW** | **rpm** |
|:-----:|:-----:|:------:|:-------:|
|  195  |   16  |   3.1  |   1200  |
|  250  |   16  |   4.0  |   1500  |
|  345  |   16  |   5.5  |   2000  |
|       |       |        |         |
|  250  | 0.3 | (excit.) |


**Reostatos**
- Reóstato de arranque: 7.5Ω
- Reóstato de campo (motor DC): 750Ω
- Reostáto de campo (gerador DC): 1100Ω


**Equipamento de medida**

- 2 amperímetros (circ. de excitação): Chauvin Arnoux C.A 401; Calibre: 1A
- 3 pinças amperimétricas: Chauvin Arnoux F03
- 3 voltímetros: Chauvin Arnoux C.A 402; Calibre: 300V
- taquímetro: Chauvin Arnoux C.A 25
- ponte de Wheatstone: Cropico Test


"""

# ╔═╡ 59b3486d-61cd-43ac-ae1c-4bd04ab5dd40


# ╔═╡ eb5f4190-17a0-4bac-b2a2-1d35622f3d2c
md"""
## 2.3 - Condução do trabalho
"""

# ╔═╡ fce78f7b-dcdc-4ae3-918d-622db2f27269
md"""
**Tempo de realização da montagem e execução do ensaio:** cerca de 75 minutos. 
\
1. Realizar a montagem elétrica de acordo com o esquema de ligações, [^Fig_2_1], com:

  - reóstato de arranque no valor máximo ⟹ corrente de arranque baixa;
  - reóstato de campo do motor no valor mínimo ⟹ velocidade baixa;
  - reóstato de campo do gerador no valor máximo ⟹ tensão baixa;
  - interruptores da montagem elétrica desligados inicialmente.
\
2. Ligar rede DC do Lab. de Máq. Elétricas e na bancada de ensaio $(U_{rede}=220\rm{V})$. Ligar o interruptor, $\rm IF1$, fazendo arrancar o motor DC;
\
3. Diminuir suavemente o reóstato de arranque até ao valor mínimo, $(0\Omega)$;
\
4. Ajustar a velocidade do grupo motor-gerador DC através do reostato de campo do motor para a velocidade nominal, $(n=1500\rm{rpm})$;
\
5. Ajustar a tensão do gerador DC, $(U_{ger}=220\rm{V})$, através do seu reóstato de campo. Confirmar a correta polaridade dos terminais gerador DC, relativamente aos terminais da rede DC. Fechar o interruptor, $\rm IF2$. Poderá verificar-se uma corrente de linha do gerador DC residual, devido a diferença de aferição entre o voltímetro do gerador *vs.* voltímetro na entrada da rede DC da bancada;
\
6. Dá-se início ao registo de valores do ensaio *back-to-back*:

   - Para regular a carga das máquinas, de modo a criar vários pontos de funcionamento do grupo motor-gerador com potências em jogo sucessivamente crescentes, diminui-se progressivamente o reóstato de campo do gerador DC e reajusta-se a velocidade para o valor nominal, através do reóstato de campo do motor DC;

   - Registam-se sucessivamente os valores das correntes de linha e de exitação de cada máquina DC, a corrente na entrada da rede DC e a velocidade, para os diferentes pontos de funcionamento do grupo motor-gerador. A tensão será constante. 
\
7. Repetir ponto 5 (exceto a condição de polaridade). Desligar os interruptores por ordem inversa. Fim de ensaio.\

"""

# ╔═╡ 6fef9e1c-e321-4ef8-9140-dc4dbfe49936


# ╔═╡ 349d542f-024d-4982-867c-afa9e105db27
md"""
# 3 - Resultados experimentais
"""

# ╔═╡ f1b48849-a61f-4825-bcc8-ff12d3c09987
md"""
## 3.1 - Leituras realizadas
"""

# ╔═╡ e05493c5-1231-4fda-821c-65420c221551
md"""
Tensão da rede de corrente contínua:
"""

# ╔═╡ 5bb9b54a-56f3-431c-b47c-75a58bff7d22
U = 220; 			# DC grid voltage, V

# ╔═╡ 494278aa-f24d-4168-8615-f7803495fafd
md"""
Medição dos enrolamentos induzidos das máquinas DC:
"""

# ╔═╡ 080ba59a-6a4a-424e-8741-9b59332c2f86
begin
	Rᵢᴹ = 1.22 		# Armature resistance of the motor, Ω
	Rᵢᴳ = 2.02 		# Armature resistance of the generator, Ω
end;

# ╔═╡ 60cc12ac-6fe6-439b-a149-39ffa704ba8b
md"""
Dados registados ao longo do ensaio *back-to-back*:
"""

# ╔═╡ a41a8eeb-c2bf-4025-8a91-a5654ba69ca7
# test data:
begin
	I = [2.95, 3.15, 3.63, 4.71, 5.40, 6.91, 7.82, 8.64, 8.75, 10.70]  					# A₁ amperemeter data
	Iₗᴹ = [3.86, 6.00, 9.13, 14.10, 16.10, 20.83, 23.34, 24.79, 25.33, 29.30] 			# A₂ amperemeter data
	Iₑₓᴹ = [0.660, 0.660, 0.630, 0.580, 0.580, 0.580, 0.580, 0.605, 0.570, 0.600] 		# A₃ amperemeter data
	Iₗᴳ = [1.69, 3.57, 6.02, 9.91, 11.43, 14.42, 16.18, 16.95, 17.16, 19.38] 			# A₄ amperemeter data
	Iₑₓᴳ = [0.280, 0.275, 0.280, 0.285, 0.295, 0.320, 0.330, 0.370, 0.360, 0.390] 		# A₅ amperemeter data
	n = [1497, 1491, 1490, 1518, 1512, 1510, 1510, 1490, 1522, 1491] 					# Tachometer data
	I, Iₗᴹ, Iₑₓᴹ, Iₗᴳ, Iₑₓᴳ, n 
end;

# ╔═╡ d37297d1-3e7d-4a17-9169-6d9fe268f2c5


# ╔═╡ df5bc5cc-9d9d-41d7-9956-a5f9af31c4cf
md"""
## 3.2 - Apresentação dos dados
"""

# ╔═╡ 13d6e0d9-2cb9-4125-a406-c4caa0d63719
md"""
Nesta secção definem-se e preparam-se as grandezas a utilizar para a análise de resultados, obtidas das leituras realizadas.
"""

# ╔═╡ fdb1a1d4-fb0f-45ae-96ef-5c3b5bec7f69
header_b2b = (["Irede", "Imot", "Iₑₓmot", "Iger", "Iₑₓger", "n"],["(A)", "(A)", "(A)", "(A)", "(A)", "(rpm)"]);  				# header of the table 1

# ╔═╡ f202a1bf-aaf8-4115-98e9-eba0da1666e4
coluna = (["tensão da rede DC", "resistência rotórica do motor", "resistência rotórica do gerador" ], ["(V)", "(Ω)", "(Ω)"]); 	# header of the table 2

# ╔═╡ bba03ae4-313e-4e3a-a367-73b1d28e733e
 dados_b2b = [I Iₗᴹ Iₑₓᴹ Iₗᴳ Iₑₓᴳ n]; 		# data of the table 1

# ╔═╡ 22e2b92e-d1e2-4f4b-b61c-f4776976f216
dados1 = [U Rᵢᴹ Rᵢᴳ]; 						# data of the table 2

# ╔═╡ 216e6f77-0b5a-4a38-aa82-6fc429147f23
pretty_table(HTML, dados_b2b, header = header_b2b, alignment=:c, title = "Tabela 1: Leituras realizadas no ensaio back-to-back")

# ╔═╡ b74e6eae-d059-4409-b0cb-ba19475a53a0
pretty_table(HTML, dados1, header = coluna, alignment=:c, title = "Tabela 2: Outros dados registados")

# ╔═╡ 7becf999-5f11-4a47-8e3f-2b775f52bd27


# ╔═╡ f0132080-ad3c-47d1-b0e3-c9c7994c072f
begin
	n_media = median(n)  			# arithmetic mean calculation
	n_media = round(Int, n_media)   # rounding to integer number 

	n_desvio = std(n)    			# standard deviation calculation
	n_desvio = round(Int, n_desvio)
	
	n_media, n_desvio   			# show statistical results
end

# ╔═╡ b32d55d7-80b2-45f1-abaf-ef8f6958e980
md"""
Por análise dos dados estatísticos da velocidade constata-se que o ensaio *back-to-back* foi realizado com uma velocidade aproximadamente constante, rondando o valor nominal de $$1500\rm rpm$$:

- **Média aritmética** = $(n_media) rpm

- **Desvio padrão** = $(n_desvio) rpm

"""

# ╔═╡ 71a60d6f-1527-4537-952d-b490af18a935
md"""
Assim, como a tensão das máquinas é contante (ambas ligadas à rede DC de $$220\rm V$$) e a velocidade é aproximadamente constante, perspectiva-se que as perdas rotacionais, $$p_{rot}$$, das máquinas sejam também aproximadamente constantes.
"""

# ╔═╡ 5bcefcd9-f30e-4b40-a1f0-b66ff862d963
begin
	Kirchhoff = I + Iₗᴳ - Iₗᴹ 				 
	Kirchhoffₘₐₓ = maximum(Kirchhoff)
	Kirchhoffₘₐₓ = round(Kirchhoffₘₐₓ, digits=1)
	
	Kirchhoff, Kirchhoffₘₐₓ
end

# ╔═╡ 6a7b7432-cb54-445a-aa39-33a13fb958ba
md"""
Aplicando a lei dos nós, ao nó $\textbf 1$ apresentado no esquema de ligações, [^Fig_2_1], verifica-se que as correntes medidas: $I$, $I_l^G$ e $I_l^M$, não verificam plenamente a 1ª lei de Kirchhoff, devido a diferenças de aferição entre os amperímetros utilizados, sendo o erro absoluto máximo das correntes medidas nesse nó de $(Kirchhoffₘₐₓ)A, ao longo do ensaio. 
"""

# ╔═╡ 81298eb8-b548-42aa-9fea-fa502482578b


# ╔═╡ 1931180b-424d-43ba-af25-61e84faf0eaf
md"""
# 4 - Análise de resultados
"""

# ╔═╡ 7e48b1e0-b66c-4773-9189-b72e931b8520
md"""
## 4.1 - Balanço de potências
"""

# ╔═╡ df08b5c7-d63b-430d-8869-a994ed85b73c
md"""
Na figura  [^Fig_2_2] apresenta-se o diagrama representativo do balanço de potências do ensaio *back-to-back*, com as relações de potências e perdas desta associação de máquinas elétricas de corrente contínua.
"""

# ╔═╡ 8358d4e1-09c2-4467-b0fa-26fc9a882e9c
html"""
<iframe frameborder="0" style="width:100%;height:573px;" src="https://viewer.diagrams.net/?tags=%7B%7D&highlight=0000ff&edit=_blank&layers=1&nav=1#R7VpZb6M6FP416HYeRgLMkj5OlnJHupU67Wz3KXLBIVYdHDlOk86vHxtswtokI0I1FXlInWP7ePm%2Bs3CKASarfcDgenlLI0QM24z2Bpgatu2PbPEtBS%2BZwPHMTBAzHGUi6yB4wL%2BQEuphWxyhTWkgp5RwvC4LQ5okKOQlGWSM7srDFpSUV13DGNUEDyEkdekPHPGlklqmeej4F%2BF4qZYeuarjEYZPMaPbRK1n2GCRfrLuFcx1ZYLNEkZ0l4lSFWBmgAmjlGet1X6CiLxafW3ZOjctvfm%2BGUr4KRP8%2B%2F%2B%2FXCf4Kfi%2BAT8XyPlv9nD%2FESj0niHZIn2OdLf8Rd%2BQ2PhaNhcE7T%2FJGzfAGCWRak5DAjcbHArhkq%2BIEFiiueGMPuUXCoRkgQmZUEJZqlRfFRjXj6FOhqIScOpQAaIrxNmLGLA7wKUxWRaA0jKGCOT4uQw3VKyJc3X5CncUi53YpiL4tSaq4ren9WoVG7plIVKzivdfUeR6RxRxyGLEa4pEo3DsgyiF9xyorQHqnqCuKvKdfqG2rweoz4MaeB1B7bnWSVCLe4YvhWFrOWDTvmERj5p33Lax2gS9swPXsj10yzxvYN65zHO7YZ7tVxRd2skM8eQI1NWI35mTqSm6MNSWP0DdE9RVRU7PWeLgv48gbbkdIQ3sNzbqwX8fgfooQn9q1L1DPTzlH%2FPfbjVZ7tmqz30eqK6jN3zR7N5yGngkZM56bvhjbvhTIfz2OZPVGMbRnjfxR%2FMloQmqUEiJIMFxIkko2IOEfPyMGMchJJ9UxwpHkVxmvFtijh7WMJRr7hhcC1lao0PyXKZUTxOuqpC2%2FJ2X5azXaCoXRPtXiap7nQoBTJD9LhDZ8huYXCVKkbQlh3A2am4LanfzreHOghSzOUmbfxNyEWYo5JhKNQhu0h1Shn%2BJYZCoOR0Aaldcg2O7NUBHDXjmFe7uAW1K0jJAhRnCR2mH7uz2gOvtu8K1I0MFNUM139pQR6%2B5VySuMwf2fo5l60rh%2B%2FFzOmKvBnwQX2Lq%2BFtZbNgekbf5yEQr5uk1Dryo8sIBFXt36rzIo28%2FvGgq50rgtHWDae6%2Fx39X9D0FUzmnkFOa4nNzcyEf4L21D7DbUqy7eaSwnom%2Fwqz%2FEVbdav9g%2BlWNdydiZzGU%2FSsUygHvjR8d8MD1jydteXzohwdNJbc0FkhUJZpXEk57fIM%2BDKA2gjqqPHXrf5CXjNvqE1QdWY4E%2BCAP8MFVwbEXTTxoDvHBEOJPCvGVerrbkPqBpmrD5ZgBGpgxVGjOeX3iT4txbs%2FFONBaRJEGPHj2Uzx75ZHcB2%2Fu2dtrLJHy6LNXfLlO14IhXTsFf6%2F6akND2m73mraD9pLMVqXtX2Wrhi6Yloo2768CxyiHaog16qgk1%2FoyTJEAXgP%2B9vX5BBA%2FDy9pZkHg8CIsmP0G"></iframe>
"""

# ╔═╡ bc95d83c-fb07-4f24-b08a-b461d871c79e
md"""
[^Fig_2_2]: Balanço de potências do ensaio *back-to-back*.
"""

# ╔═╡ 404e5b4b-0ddc-45b0-a4af-e29618a501be
md"""
O diagrama do balanço de potências da [^Fig_2_2] permite perceber as conversões de potências que ocorrem no funcionamento das máquinas envolvidas, mas ainda não quantifica o valor de cada parcela relativa a potências e perdas de cada máquina.
"""

# ╔═╡ 2f7931fa-262f-4f76-8f4b-f28e26989a2b


# ╔═╡ 66ada8ac-6556-4d18-9cf3-cbdbf3f9bc69
md"""
## 4.2 - Cálculo de potências e perdas
"""

# ╔═╡ 01e08f32-9f91-41f9-b022-ad877864a784
md"""
**Perdas das máquinas DC:**
"""

# ╔═╡ d12d08d6-4c4c-4afc-b4e5-970f86a440e5
md"""
- Cálculo das perdas totais do grupo motor-gerador:
"""

# ╔═╡ 2b7754b3-44b3-4a09-99e2-4827afbacc64
pₜ = U * I

# ╔═╡ d777bcfb-ffad-4061-b86b-cf3f2709576d
pₜ[6]


# ╔═╡ 9c117644-13d3-4de3-a30b-e626df7d6815
md"""
- Cálculo das perdas por efeito de Joule no circuito **induzido** de cada máquina:
"""

# ╔═╡ fc62b652-0d92-49e4-ae27-fd04a6b1d8bd
begin
	pⱼᴹ = Rᵢᴹ * Iₗᴹ.^2
	pⱼᴳ = Rᵢᴳ * Iₗᴳ.^2
	pⱼᴹ, pⱼᴳ
end

# ╔═╡ dff17723-bba8-491f-af37-9119e4ff4445
md"""
- Cálculo das perdas por efeito de Joule no circuito **indutor** de cada máquina:
"""

# ╔═╡ 1c048c68-2a41-4710-9d5d-e092abbfc7d9
begin
	pₑₓᴹ = U * Iₑₓᴹ
	pₑₓᴳ = U * Iₑₓᴳ
	pₑₓᴹ, pₑₓᴳ
end

# ╔═╡ 55483f43-ca65-4775-a4b7-b824295ad34d
md"""
- Cálculo das perdas rotacionais (consideradas igualmente repartidas pelas máquinas DC):
"""

# ╔═╡ 4cda0d79-6a76-4529-b70e-4eb0bf9c2451
pᵣₒₜ = 0.5 * (pₜ - pₑₓᴹ - pⱼᴹ - pₑₓᴳ - pⱼᴳ)

# ╔═╡ 0865009d-6d80-452b-b9e5-74b424f9b3c3
begin
	pᵣₒₜᵃᵛᵍ = median(pᵣₒₜ)				# arithmetic mean
	pᵣₒₜᵈᵉᵛ = std(n)					# standard deviation
	pᵣₒₜᵛᵃʳ = pᵣₒₜᵈᵉᵛ * 100 / pᵣₒₜᵃᵛᵍ 	# percentage change
	(pᵣₒₜᵃᵛᵍ, pᵣₒₜᵈᵉᵛ, pᵣₒₜᵛᵃʳ) = round.((pᵣₒₜᵃᵛᵍ, pᵣₒₜᵈᵉᵛ, pᵣₒₜᵛᵃʳ), digits=1) # rounding of statistical results
end

# ╔═╡ 4643e926-67e5-4ac5-a332-1895b992b981
md"""
Como esperado as perdas rotacionais são aproximadamente constantes, apresentando uma pequena variação de $(pᵣₒₜᵛᵃʳ)%, ao longo do ensaio *back-to-back*, em relação ao valor médio de $(pᵣₒₜᵃᵛᵍ)W:
"""

# ╔═╡ 361b5bbe-2fcd-4f96-8488-c52d9b2dbea5
md"""
- Cálulo das perdas constantes do motor e do gerador:
"""

# ╔═╡ 863fe345-3a98-46d6-9112-78ee18635ffe
begin
	pcᴹ = pᵣₒₜ + pₑₓᴹ
	pcᴳ = pᵣₒₜ + pₑₓᴳ
	pcᴹ, pcᴳ
end

# ╔═╡ bf4807d5-6fbb-43bc-9be3-475b2ad6e0f6
md"""
- Cálulo da potência útil do motor:
"""

# ╔═╡ f7e7769e-9be0-41bb-900b-9034db833a5b
md"""
A potência útil do motor pode ser calculada vista do lado gerador, correspondendo à sua potência mecânica (potência absorvida):
"""

# ╔═╡ ad8fdc0f-4059-4bec-98a5-8b38b5a17fd0
Pᵤᴹ¹ = U * Iₗᴳ + pₑₓᴳ + pⱼᴳ + pᵣₒₜ

# ╔═╡ 7c45e9f8-de6b-4bf8-aa91-5b23a47f5d02
md"""
Visto do lado do motor:
"""

# ╔═╡ 5d25244c-7d05-43af-a6a5-69fdb52a253e
Pᵤᴹ² = U * Iₗᴹ - pₑₓᴹ - pⱼᴹ - pᵣₒₜ

# ╔═╡ 901eaef2-2cff-4131-b19c-b43a88b35b34
begin
	dif = Pᵤᴹ¹ - Pᵤᴹ² 			# difference in calculation formula
	difₘₐₓ = maximum(dif)		# maximum difference
	difₘₐₓ = round(difₘₐₓ, digits=1)
end;

# ╔═╡ 29c9a3a5-73a1-4daa-b492-178b97917258
md"""
A diferença de resultados deve-se a diferenças de aferição da aparelhagem de medida. A difereça absoluta no cálculo da potência útil do motor, não excede os $(difₘₐₓ) W, o que é bastante aceitável, considerando a potência nominal do motor ensaiado.
"""

# ╔═╡ 99f6a01a-4a46-43dd-8ef9-a614302e29af
aside((md"""
!!! tip "Proposta de atividade"
	Para os objetivos definidos neste relatório não é necessário, mas adicionalmente poderá determinar-se a evolução de outras potências e binários de ambas as máquinas no ensaio *back-to-back*.
	
	Assim, utilizando a célula para código Julia inicada (com as potências e binários em comentário), calcule e represente graficamente as seguintes potências e binários:

	- potência absorvidas do motor e gerador, $$P_{ab}^M$$ e $$P_{ab}^G$$
	- potências desenvolvidas do motor e gerador, $$P_d^M$$ e $$P_d^G$$
	- binários desenvolvidos do motor e gerador, $$T_d^M$$ e $$T_d^G$$
	- binário mecânico, $$T_u$$
	
	No final, analise comparativamente os resultados das potências e binários obtidos entre as máquinas DC.
"""), v_offset=20)

# ╔═╡ 076bd182-885d-4808-ba4a-9d125cd09957
md"""
### 4.2.1 - 💻 Exercício: potências e binários
"""

# ╔═╡ c4fd1d3b-9b18-48b3-a0fd-466fcb3e17ee
md"""
**Cálculos:**
"""

# ╔═╡ d780fb54-2677-481e-a228-478845fba613
#begin
	#Pabᴹ = 
	#Pabᴳ =  
	#
	#Pdᴹ = 
	#Pdᴳ = 
	#
	#Tdᴹ = 
	#Tdᴳ = 
	#
	#Tᵤ = 
#end

# ╔═╡ d65460a3-a703-44f6-aa42-a3dd47ae3034
md"""
**Gráficos:**
"""

# ╔═╡ 7bcd562e-970f-4614-94d0-41b8f47a5ff2
begin
	# Left plot:
	h1=plot(                  ylabel="Potências (kW)", xlabel="Corrente (A)",
			title="Motor vs Gerador")

	# Right plot:
	h2=plot(                  ylabel="Binários (Nm)", xlabel="Corrente (A)", 
			title="Motor vs Gerador")
	
	#Plot layout:
	plot(h1, h2, layout = (1, 2), size=(750,500))
end

# ╔═╡ 18159d33-d61e-44cc-9966-801f15b7f5d5


# ╔═╡ 51f8e7ee-868e-47d9-bfa5-4ac06f37d942
md"""
**Análise:**
      
    
    
    
    
.
"""

# ╔═╡ 95fdbbc4-b612-4512-9069-6110e41f9e9d


# ╔═╡ c771cef0-8fb8-4414-af8a-3e6512832d90
md"""
### 4.2.2 - 💻 Diagrama de Sankey
"""

# ╔═╡ 46273cec-629b-4a2f-ba2c-e354e5003adc
md"""
Um diagrama de Sankey permite visualizar o fluxo de dados entre dois ou mais estados ou dimensões num dado processo. A largura das barras/setas de cada estado é proporcional à taxa de fluxo nessa fase do processo. O diagrama de Sankey é especialmente útil para a visualização global de fluxos de energia ou de potência em processos industriais ou numa rede elétrica com diferentes fontes de energia com os fluxos energéticos dirigidos a diferentes categorias de utilizadores de energia.

Em geral os diagramas de Sankey são grafos acíclicos dirigidos, ou seja, nenhuma das partes forma um ciclo. O que à partida inviabilizaria a sua utilização para análise do balanço de potência neste ensaio, pois pela [^Fig_2_2], o balanço de potências do ensaio _back-to-back_ forma um ciclo.

No entanto, abrindo o ciclo, a sua representação em ferramenta computacional permite visualizar a evolução do diagrama de Sankey ao longo do ensaio _back-to-back_.\
Assim, verifica-se que:

$P_u^G(k)=P_{ab}^M(k)-p_T(k)$

com: $k \in \{1,2,3,...,10,\}$, correspondendo à ordem de ensaio na Tabela 1.

Ou seja, em qualquer momento do ensaio _back-to-back_, a potência útil do gerador, $P_u^G(k)$, é entregue ao motor.
"""

# ╔═╡ 50f9ef55-ec4d-4801-a7df-b755fcc9cdef
aside((md"""
!!! tip "Atividade interativa"
	👈 Através do _slider_ selecione o momento do ensaio realizado, $k$, e viasualize interativamente a evolução relativa das perdas e potências das máquinas elétricas de corrente contínua, ao longo do ensaio _back-to-back_.
"""), v_offset=10)

# ╔═╡ 80d0dbc9-9e4c-4270-9395-baec8974bdf2
md"""
Linha dos dados no ensaio _back-to-back_ (Tabela 1): $\quad k=$ $(@bind k PlutoUI.Slider(1:1:10, default=6, show_value=true))
"""

# ╔═╡ 994319d8-2e54-4edd-a6fb-cd8df9f9fcd7
md"""
**Matrizes de construção do diagrama de Sankey:**
"""

# ╔═╡ a11a242c-4672-4639-ad54-faa63d0a1cd1
names = ["pₜ", "Pabᴹ", "Pdᴹ", "Pᵤᴹ=Pabᴳ", "Pdᴳ", "Pᵤᴳ", "Pₑₗₑᴹ", "pᵣₒₜᴹ", "pᵣₒₜᴳ", "Pₑₗₑᴳ", "Pabᴹ-pₜ"];  # state names in the Sankey chart

# ╔═╡ 6873136d-76b9-41ee-a61f-2dd473ac8aca
src = [1, 2, 2, 3, 3, 4, 4, 5, 5, 6]; # sources (order number of state names) in the Sankey chart

# ╔═╡ b6d6d602-03f6-4d11-be10-631a3502ea40
dst = [2, 3, 7, 8, 4, 9, 5, 10, 6, 11];  # destiny of the flow in the Sankey chart

# ╔═╡ e8e790c5-fd10-4797-8dbf-74cde9ac20a2
colors = palette(:seaborn_bright);  	# palette colors used in the Sankey chart
# from color schemes: https://docs.juliaplots.org/latest/generated/colorschemes/

# ╔═╡ f5d3be1c-ccb1-43ec-8d5b-5afc631cb54b
weights = [pₜ[k], U * Iₗᴹ[k] - pₑₓᴹ[k] - pⱼᴹ[k], pₑₓᴹ[k] + pⱼᴹ[k], pᵣₒₜ[k], Pᵤᴹ²[k], pᵣₒₜ[k], Pᵤᴹ²[k]-pᵣₒₜ[k], pⱼᴳ[k]+pₑₓᴳ[k], Pᵤᴹ²[k]-pₑₓᴳ[k]-pⱼᴳ[k]-pᵣₒₜ[k],Pᵤᴹ²[k]-pₑₓᴳ[k]-pⱼᴳ[k]-pᵣₒₜ[k]] 		# flow weights on Sankey chart (from previous loss and power calculations)

# ╔═╡ fbb2ce7b-3a81-4c4e-b271-0f33819837a7
sankey(src, dst, weights; node_labels=names, label_position=:bottom, label_size=12, edge_color=:gradient, compact=:true, node_colors=colors, size=(1100,500))

# ╔═╡ 469dd7f7-dc57-4743-a844-714fa3952c8c


# ╔═╡ bbdfee6a-fd4d-4220-aadf-9ceba2415a75
md"""
## 4.3 - Curvas de rendimento
"""

# ╔═╡ 884beeaf-d196-4d9a-9088-a3b88ff5670e
md"""
Cálculo dos pontos de rendimento do motor DC:
"""

# ╔═╡ 69892e4e-821b-4efa-b7f5-26bdbb5d0f8a
begin
	ηᴹ = Pᵤᴹ¹./(U*Iₗᴹ)
	ηᴹ = round.(ηᴹ*100, digits=1)		# percentage and rounding
end

# ╔═╡ 1658f96c-7d15-4ed2-9f58-a161bc8b635f
md"""
Cálculo dos pontos de rendimento do gerador DC:
"""

# ╔═╡ 3ad1607a-66c4-42e2-a088-db1832fd1f32
begin
	#ηᴳ=(U*Iₗᴳ)./(U*Iₗᴹ-pⱼᴹ-pₑₓᴹ-pᵣₒₜ) 	# other option!
	ηᴳ = (U*Iₗᴳ)./(Pᵤᴹ¹)
	ηᴳ = round.(ηᴳ*100, digits=1) 		# percentage and rounding
end

# ╔═╡ 49e3234a-c066-42bc-bc90-bf7699309286


# ╔═╡ 065d2711-a5b6-4fcd-8e99-919296af78cb
md"""
Cálculos auxiliares para determinação das linhas de tendência para o traçado das curvas de rendimento, perdas constantes e perdas variáveis calculadas, do motor e gerador, determinadas a partir dos dados de ensaio:
"""

# ╔═╡ 45757ac2-7db2-4ffa-bc5c-fb993eb6a991
begin
	# Calculation of the trend line for the motor efficiency curve:
	Iₗᴹ_m = hcat(Iₗᴹ)						# convert data vector to matrix
	ηᴹ_m = hcat(ηᴹ)							# convert data vector to matrix
	FIT_ηᴹ = fitexp(Iₗᴹ_m, ηᴹ_m, n=2)		# exponential trend line

	pcᴹ_m = hcat(pcᴹ)						# convert data vector to matrix
	FIT_pcᴹ = fitlinear(Iₗᴹ_m, pcᴹ_m)		# linear trend line

	pⱼᴹ_m = hcat(pⱼᴹ)						# convert data vector to matrix
	FIT_pⱼᴹ = fitquad(Iₗᴹ_m, pⱼᴹ_m)			# quadratic trend line

	# Calculation of the trend line for the generator efficiency curve: 
	Iₗᴳ_m = hcat(Iₗᴳ)						# convert data vector to matrix
	ηᴳ_m = hcat(ηᴳ)							# convert data vector to matrix
	FIT_ηᴳ = fitexp(Iₗᴳ_m, ηᴳ_m, n=2)		# exponential trend line

	pcᴳ_m = hcat(pcᴳ)						# convert data vector to matrix
	FIT_pcᴳ = fitlinear(Iₗᴳ_m, pcᴳ_m)		# linear trend line

	pⱼᴳ_m = hcat(pⱼᴳ)						# convert data vector to matrix
	FIT_pⱼᴳ = fitquad(Iₗᴳ_m, pⱼᴳ_m)			# quadratic trend line
end;

# ╔═╡ debd87f9-13ee-4177-8245-c9cc4df1d157


# ╔═╡ 2a0e3a6a-0fd0-4f9e-ab54-2377d0761ba3
md"""
**Gráfico de curva de rendimento do motor DC, $$\:\eta^M=f(I_l^M)$$, e relação com as perdas "constantes", $$\:p_C^M=f(I_l^M)$$ e as perdas variáveis, $$\:p_J^M=f(I_l^M)$$:**
"""

# ╔═╡ 7ced39d8-26a1-497f-94fc-96d725ea6287
begin
	scatter(Iₗᴹ, ηᴹ, ylims=(70,90), ylabel="rendimento (%)", 
			right_margin = 5Plots.mm, bottom_margin = 5Plots.mm, mc=:orange, 
			legend=:topleft, label="ηᴹ, ensaio", size=(700,500))				# calculated efficiency points
	plot!(FIT_ηᴹ.x, FIT_ηᴹ.y, title="Motor DC", label="ηᴹ", lw=2) 				# trend line
	
	scatter!(twinx(), Iₗᴹ, pcᴹ, ylims=(0,800), xlabel="corrente de linha (A)", label=:none)
	plot!(twinx(), FIT_pcᴹ.x, FIT_pcᴹ.y, ylims=(0,800), legend=:bottomright,
			ylabel="perdas (W)", label="pcᴹ", ls=:dash, lw=2)
	
	scatter!(twinx(), Iₗᴹ, pⱼᴹ, ylims=(0,800), mc=:green, 
			xlabel="corrente de linha (A)", label=:none)
	plot!(twinx(), FIT_pⱼᴹ.x, FIT_pⱼᴹ.y, ylims=(0,800), legend=:topright,
			ylabel="perdas (W)", label="pⱼᴹ", ls=:dash, lw=2, lc=:green)
end

# ╔═╡ e9e3afa0-0b4d-4367-a7f9-acd8992a88a5


# ╔═╡ 1ee60c29-bb29-4d9c-a2d9-20fac192f89f
md"""
**Gráfico de curva de rendimento do gerador DC, $$\:\eta^G=f(I_l^G)$$, e relação com as perdas "constantes", $$\:p_C^G=f(I_l^G)$$ e as perdas variáveis, $$\:p_J^G=f(I_l^G)$$:**
"""

# ╔═╡ cd62422c-abd3-493d-a563-16520b237537
begin
	scatter(Iₗᴳ, ηᴳ, ylims=(50,90), ylabel="rendimento (%)", 
			right_margin = 15Plots.mm, bottom_margin = 5Plots.mm, mc=:orange, 
			legend=:topleft, label="ηᴳ, ensaio", size=(700,500))			# calculated efficiency points
	plot!(FIT_ηᴳ.x, FIT_ηᴳ.y, title="Gerador DC", label="ηᴳ", lw=2) 		# trend line
	
	scatter!(twinx(), Iₗᴳ, pcᴳ, ylims=(0,800), xlabel="corrente de linha (A)", label=:none)
	plot!(twinx(), FIT_pcᴳ.x, FIT_pcᴳ.y, ylims=(0,800), legend=:bottomright,
			ylabel="perdas (W)", label="pcᴳ", ls=:dash, lw=2)
	
	scatter!(twinx(), Iₗᴳ, pⱼᴳ, ylims=(0,800), mc=:green, 
			xlabel="corrente de linha (A)", label=:none)
	plot!(twinx(), FIT_pⱼᴳ.x, FIT_pⱼᴳ.y, ylims=(0,800), legend=:topright,
			ylabel="perdas (W)", label="pⱼᴳ", ls=:dash, lw=2, lc=:green)
end

# ╔═╡ 6c2bab0b-4785-413b-a851-0c0ab06c73a4


# ╔═╡ 830796ba-f8d6-4843-9297-e76492589d49
begin
	(pcᴹᵃᵛᵍ, pcᴳᵃᵛᵍ) = median.((pcᴹ, pcᴳ))				# arithmetic mean
	(pcᴹᵈᵉᵛ, pcᴳᵈᵉᵛ) = std.((pcᴹ, pcᴳ))					# standard deviation
	# rounding of statistical results:
	(pcᴹᵃᵛᵍ, pcᴳᵃᵛᵍ, pcᴹᵈᵉᵛ, pcᴳᵈᵉᵛ) = round.((pcᴹᵃᵛᵍ, pcᴳᵃᵛᵍ, pcᴹᵈᵉᵛ, pcᴳᵈᵉᵛ), digits=1) 

	# Percent variation:
	pcᴹᵥₐᵣ = pcᴹᵈᵉᵛ * 100 / pcᴹᵃᵛᵍ
	pcᴳᵥₐᵣ = pcᴳᵈᵉᵛ * 100 / pcᴳᵃᵛᵍ
	(pcᴹᵥₐᵣ, pcᴳᵥₐᵣ) = round.((pcᴹᵥₐᵣ, pcᴳᵥₐᵣ), digits=1)
	
	# Presentation of results:
	Text("Perdas constantes do motor DC, (média aritmética, desvio padrão) W:"), (pcᴹᵃᵛᵍ, pcᴹᵈᵉᵛ),  Text("Perdas constantes do gerador DC, (média aritmética, desvio padrão) W:"), (pcᴳᵃᵛᵍ, pcᴳᵈᵉᵛ) 
end

# ╔═╡ 1e3c4060-5d78-4159-bb2d-caf158d9a32d
md"""
Verifica-se apesar dos ligeiros declives, que as perdas "constantes" do motor e do gerador são efetivamente aproximadamente constantes, apresentando uma variação em relação ao valor médio, de $(pcᴹᵥₐᵣ)% e $(pcᴳᵥₐᵣ)%, respetivamente. 
"""

# ╔═╡ 5ea61cf4-4f87-43ef-8556-f37ea60d2515


# ╔═╡ c870e56a-cc10-4f85-9767-af46d9845b6a
md"""
### 4.4.1 - Rendimento nominal
"""

# ╔═╡ d9063387-a1d9-44e5-81e8-9dd4111ad72a
md"""
Consultando as curvas de rendimento do motor e do gerador, para as respectivas correntes nominais, obtêm-se os seguintes rendimentos nominais:
"""

# ╔═╡ 24331be7-d705-41e9-925a-ec76b80fa38f
# Computational way to read nominal efficiencies:
begin
	(Iₙᴹ, Iₙᴳ) = (29, 16)							# rated current, A
	
	ηᴹ_I = LinearInterpolator(FIT_ηᴹ.x,FIT_ηᴹ.y)  	# trend line linear interpolation
	ηₙᴹ = ηᴹ_I(Iₙᴹ)									# rated efficiency, motor
	ηₙᴹ = round(ηₙᴹ, digits=1)

	ηᴳ_I = LinearInterpolator(FIT_ηᴳ.x,FIT_ηᴳ.y)
	ηₙᴳ = ηᴳ_I(Iₙᴳ)
	ηₙᴳ = round(ηₙᴳ, digits=1)

	Text("ηₙᴹ = $(ηₙᴹ)%"), Text(" 	ηₙᴳ = $(ηₙᴳ)%")	# presentation of results
end

# ╔═╡ 36ce1f19-59f6-4595-a75a-22f519e326d9


# ╔═╡ c674d531-be5a-45b6-b5be-480753f0135f
md"""
### 4.4.2 - Rendimento máximo
"""

# ╔═╡ 28563a65-dfbd-4143-a0ec-772e553a3fb9
md"""
Forma computacional para obtenção dos pontos de rendimento máximo, nas curvas, $$\:\eta^M=f(I_l^M)$$ e $$\:\eta^G=f(I_l^G)$$, (optativo em relação a uma leitura direta dos gráficos obtidos): 
"""

# ╔═╡ e12e7cc3-abe6-4f51-a8b0-9254dbade011
begin
	index1=argmax(FIT_ηᴹ.y) 	# find the position in the vector where the value is maximum
	ηₘₐₓᴹ=FIT_ηᴹ.y[index1]		# get maximum efficiency
	ηₘₐₓᴹ=round(ηₘₐₓᴹ, digits=1)
	I1=FIT_ηᴹ.x[index1]			# current value corresponding to maximum efficiency
	I1=round(I1, digits=1)
	
	index2=argmax(FIT_ηᴳ.y) 	# find the position in the vector where the value is maximum
	ηₘₐₓᴳ=FIT_ηᴳ.y[index2]		# get maximum efficiency
	ηₘₐₓᴳ=round(ηₘₐₓᴳ, digits=1)
	I2=FIT_ηᴳ.x[index2]			# current value corresponding to maximum efficiency
	I2=round(I2, digits=1)
	
	Text("Ponto de rendimento máximo do motor DC: $(ηₘₐₓᴹ)% @ $(I1)A"),
	Text("Ponto de rendimento máximo do gerador DC: $(ηₘₐₓᴳ)% @ $(I2)A")
end

# ╔═╡ e40a1b59-ed60-4081-afbf-661373b8b3fa
md"""
Da análise às curvas de rendimento das máquinas DC, verificam-se os seguintes pontos de rendimento máximo:

- Gerador: $$\:\:I_l^G(\eta_{max}^G) =$$ $(I2) $$\rm A; \it \quad\eta_{max}^G =$$ $(ηₘₐₓᴳ) $$\rm\%$$
- Motor: $$\quad I_l^M(\eta_{max}^M) =$$ $(I1) $$\rm A; \it \quad\eta_{max}^M =$$ $(ηₘₐₓᴹ) $$\rm\%$$
"""

# ╔═╡ 291e034f-a119-4c9b-8a50-4a35cd54e055
md"""
Comparando os pontos de rendimento máximo obtidos, do motor e do gerador, relativamente às respetivas perdas, verifica-se uma boa aproximação ao esperado dos conceitos teóricos sobre análise de rendimento de máquinas elétricas, em que o rendimento máximo se verifica quando as perdas variáveis são iguais às perdas contantes. 

Alguma divergência nos valores encontrados, como apontado anteriormente, podem ser justificadas pela  diferença de aferição dos aparelhos de leitura utilizados, as pequenas variações de velocidade do grupo motor-gerador ao longo do ensaio e as perdas "constantes" na prática, apresentarem algum declive, ainda que pouco acentuado.
"""

# ╔═╡ c53871d4-c739-4dcf-ad6d-c5dced86c208


# ╔═╡ 83d8e64c-e9ab-4065-a056-f189e30e149c
md"""
# 5 - Conclusões
"""

# ╔═╡ 5ab45915-9446-4583-a7b0-2ff97a5808f4
md"""
## 5.1 - Considerações finais
"""

# ╔═╡ 0ec4b965-80c4-4b40-925a-f3dcb2fd0115
md"""
No ensaio *back-to-back* verifica-se que o mesmo consome pouca potência elétrica da rede DC, comparativamente com a potência nominal das máquinas ensaiadas.\
Após o arranque do motor DC e ajuste à velocidade nominal, este alimenta mecanicamente o gerador DC. Após ligar o gerador DC em paralelo com a rede DC (verificadas as condições para essa manobra), o gerador alimentará eletricamente o motor DC.\
Por conseguinte, a potência consumida da rede elétrica corresponde ao somatório das perdas do grupo motor-gerador.  Este fato é muito importante e permite concluir que o ensaio *back-to-back* pode possibilitar o ensaio em carga de máquinas elétricas de elevada potência, comparativamente com a potência disponível da rede DC para a realização do ensaio, desde que a mesma suporte o arranque reostático do motor DC.
"""

# ╔═╡ e7aae6a9-1fa7-48a1-9b11-8e60c69cf9c9
md"""
O funcionamento do ensaio *back-to-back* utiliza a regulação dos circuitos de excitação de ambas as máquinas DC. Por um lado, o reóstato de campo do gerador DC ajusta a potência de saída do gerador (pois encontra-se ligado a uma rede DC de tensão constante), que por sua vez solicita mais potência mecânica ao motor DC (alimentado da mesma rede DC). Neste ajuste a velocidade poderá sofrer alguma variação significativa, sendo corrigida por atuação do reóstato de campo do motor DC.

Estas variações nos reostato de campo e consequentes variações nas correntes de excitação das máquinas provocam pequenas variações nas perdas constantes, contudo aceitáveis.
"""

# ╔═╡ 5dded0ab-c093-4e14-a2f2-de5d3506d171
md"""
Como conclusão final, o ensaio *back-to-back* permite a análise de potências, cálculo das perdas e rendimento de 2 máquinas elétricas em simultâneo e com baixo consumo de energia.
"""

# ╔═╡ 0b42e250-90d9-4b97-8fb6-0a7a896b92e5


# ╔═╡ e4d17d82-b7f0-4070-9177-e6a1cebb4c24
md"""
## 5.2 - Perspetivas de desenvolvimento futuro
"""

# ╔═╡ 7787b512-37e0-4c2e-8d43-88433ce6c764
md"""
O ensaio *back-to-back* pode ser também aproveitado para se analisar a reversibilidade de funcionamento das máquinas do grupo motor-gerador.

Assim, com o sistema em funcionamento, o aumento do reóstato de campo do circuito de excitação do gerador pode fazer baixar a sua força-eletromotriz, tal que esta seja menor que a tensão da rede DC, invertendo o sentido da corrente de linha nesta máquina, passando a regime motor:

$R_c 	\nearrow \quad \Rightarrow \quad I_{ex} \searrow\quad \Rightarrow \quad \phi \searrow \quad \Rightarrow \quad E \searrow$

$\text{Se:} \quad E<U \quad \Rightarrow \quad I_l < 0 \quad \text{, então:} \quad \rm gerador \triangleright motor$
"""

# ╔═╡ 4cbd2235-074d-4374-99c8-f290215b1640
md"""
Do lado do motor DC estabelece-se um raciocínio semelhante, para que este passe para o regime de funcionamento gerador:

$R_c 	\searrow \quad \Rightarrow \quad I_{ex} \nearrow\quad \Rightarrow \quad \phi \nearrow \quad \Rightarrow \quad E \nearrow$

$\text{Se:} \quad E>U \quad \Rightarrow \quad I_l > 0 \quad \text{, então:} \quad \rm motor \triangleright gerador$

"""

# ╔═╡ 46a23d85-70f0-4f15-9a76-8a3701a82183
md"""
O teste de reversibilidade com o grupo motor-gerador deve ser realizado com especial cuidado por causa do reostato de campo com o terminal $\textbf q$ (reostato de campo do gerador DC) estar em funcionamento. Assim, quando a máquina DC muda o regime de funcionamento de gerador para motor, tendo em conta a possibilidade do circuito de excitação ficar acidentalmente em aberto, e consequentemente, provocar o embalamento do motor DC.
"""

# ╔═╡ 8495592a-9619-4e2c-97fb-ef9f55f29f4d
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
	font-size:  100%
}
</style>
"""

# ╔═╡ 7ec2f5b9-5779-4f95-979d-96e23e742d5a
md"""
# *Notebook*
"""

# ╔═╡ 6bd294df-005b-4979-b2ee-39922b9223b7
md"""
Documentação das bibliotecas Julia utilizadas: \
[Plots](http://docs.juliaplots.org/latest/), [EasyFit](https://github.com/m3g/EasyFit.jl), [PrettyTables](https://ronisbr.github.io/PrettyTables.jl/stable/), [Statistics](https://docs.julialang.org/en/v1/stdlib/Statistics/), [BasicInterpolators](https://markmbaum.github.io/BasicInterpolators.jl/dev/), [SankeyPlots](https://github.com/daschw/SankeyPlots.jl), [PlutoUI](https://juliahub.com/docs/PlutoUI/abXFp/0.7.6/), [PlutoTeachingTools](https://juliapluto.github.io/PlutoTeachingTools.jl/example.html).
"""

# ╔═╡ 42b2d4f0-4d76-4e42-bd2a-f2ed48a4e4a4
begin
	version=VERSION
	md"""
*Notebook* realizado em linguagem de computação científica Julia versão $(version).
"""
end

# ╔═╡ aa0f3953-c4e8-4735-831c-9129e893ca05
TableOfContents(title="Índice")

# ╔═╡ 75189e15-e7bd-4dcc-9d41-27f83687b966
aside((md"""
!!! info "Informação"
	No índice deste *notebook*, o tópico assinalado com "💻" requer a participação do estudante.
"""), v_offset=-170)

# ╔═╡ 61d8b963-5ad7-4f64-8b5f-46e3b40346a0
md"""
|  |  |
|:--:|:--|
|  | This notebook, [back2backlab.jl](https://ricardo-luis.github.io/isel-me2/Fall23/data_science/back2backlab/), is part of the collection "[_Notebooks_ Reativos de Apoio a Máquinas Elétricas II](https://ricardo-luis.github.io/isel-me2/)" by Ricardo Luís. |
| **Terms of Use** | This work is licensed under the Creative Commons Attribution-ShareAlike 4.0 International License ([CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)) for text content and under the [MIT License](https://www.tldrlegal.com/license/mit-license) for Julia code snippets.|
|  | $©$ 2022-2024 [Ricardo Luís](https://ricardo-luis.github.io/) |
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BasicInterpolators = "26cce99e-4866-4b6d-ab74-862489e035e0"
EasyFit = "fde71243-0cda-4261-b7c7-4845bd106b21"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
PrettyTables = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
SankeyPlots = "8fd88ec8-d95c-41fc-b299-05f2225f2cc5"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[compat]
BasicInterpolators = "~0.7.1"
EasyFit = "~0.6.6"
Plots = "~1.40.3"
PlutoTeachingTools = "~0.2.15"
PlutoUI = "~0.7.59"
PrettyTables = "~2.3.1"
SankeyPlots = "~0.2.2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.5"
manifest_format = "2.0"
project_hash = "bd506864be93cfea37a28ed5f78ef861d4190c49"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "6a55b747d1812e699320963ffde36f1ebdda4099"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "4.0.4"
weakdeps = ["StaticArrays"]

    [deps.Adapt.extensions]
    AdaptStaticArraysExt = "StaticArrays"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.ArnoldiMethod]]
deps = ["LinearAlgebra", "Random", "StaticArrays"]
git-tree-sha1 = "d57bd3762d308bded22c3b82d033bff85f6195c6"
uuid = "ec485272-7323-5ecc-a04f-4719b315124d"
version = "0.4.0"

[[deps.ArrayInterface]]
deps = ["Adapt", "LinearAlgebra"]
git-tree-sha1 = "f54c23a5d304fb87110de62bace7777d59088c34"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "7.15.0"

    [deps.ArrayInterface.extensions]
    ArrayInterfaceBandedMatricesExt = "BandedMatrices"
    ArrayInterfaceBlockBandedMatricesExt = "BlockBandedMatrices"
    ArrayInterfaceCUDAExt = "CUDA"
    ArrayInterfaceCUDSSExt = "CUDSS"
    ArrayInterfaceChainRulesExt = "ChainRules"
    ArrayInterfaceGPUArraysCoreExt = "GPUArraysCore"
    ArrayInterfaceReverseDiffExt = "ReverseDiff"
    ArrayInterfaceSparseArraysExt = "SparseArrays"
    ArrayInterfaceStaticArraysCoreExt = "StaticArraysCore"
    ArrayInterfaceTrackerExt = "Tracker"

    [deps.ArrayInterface.weakdeps]
    BandedMatrices = "aae01518-5342-5314-be14-df237901396f"
    BlockBandedMatrices = "ffab5731-97b5-5995-9138-79e8c1846df0"
    CUDA = "052768ef-5323-5732-b1bb-66c8b64840ba"
    CUDSS = "45b445bb-4962-46a0-9369-b4df9d0f772e"
    ChainRules = "082447d4-558c-5d27-93f4-14fc19e9eca2"
    GPUArraysCore = "46192b85-c4d5-4398-a991-12ede77f4527"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    StaticArraysCore = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BasicInterpolators]]
deps = ["LinearAlgebra", "Memoize", "Random"]
git-tree-sha1 = "3f7be532673fc4a22825e7884e9e0e876236b12a"
uuid = "26cce99e-4866-4b6d-ab74-862489e035e0"
version = "0.7.1"

[[deps.BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Profile", "Statistics", "UUIDs"]
git-tree-sha1 = "f1dff6729bc61f4d49e140da1af55dcd1ac97b2f"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.5.0"

[[deps.BitFlags]]
git-tree-sha1 = "2dc09997850d68179b69dafb58ae806167a32b1b"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.8"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9e2a6b69137e6969bab0152632dcb3bc108c8bdd"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+1"

[[deps.CEnum]]
git-tree-sha1 = "389ad5c84de1ae7cf0e28e381131c98ea87d54fc"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.5.0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "7eee164f122511d3e4e1ebadb7956939ea7e1c77"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "1.3.6"

[[deps.CodecBzip2]]
deps = ["Bzip2_jll", "TranscodingStreams"]
git-tree-sha1 = "e7c529cc31bb85b97631b922fa2e6baf246f5905"
uuid = "523fee87-0ab8-5b00-afb7-3ecf72e48cfd"
version = "0.8.4"

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
weakdeps = ["SpecialFunctions"]

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "fc08e5930ee9a4e03f84bfb5211cb54e7769758a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.10"

[[deps.CommonSubexpressions]]
deps = ["MacroTools", "Test"]
git-tree-sha1 = "7b8a93dba8af7e3b42fecabf646260105ac373f7"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.0"

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

[[deps.ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "d8a9c0b6ac2d9081bf76324b39c78ca3ce4f0c98"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.5.6"

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseStaticArraysExt = "StaticArrays"

    [deps.ConstructionBase.weakdeps]
    IntervalSets = "8197267c-284f-5f27-9208-e0e47529a953"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "1d0a14036acb104d9e89698bd408f63ab58cdc82"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.20"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.DiffResults]]
deps = ["StaticArraysCore"]
git-tree-sha1 = "782dd5f4561f5d267313f23853baaaa4c52ea621"
uuid = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
version = "1.1.0"

[[deps.DiffRules]]
deps = ["IrrationalConstants", "LogExpFunctions", "NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "23163d55f885173722d1e4cf0f6110cdbaf7e272"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.15.1"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Distributions]]
deps = ["AliasTables", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns"]
git-tree-sha1 = "9c405847cc7ecda2dc921ccf18b47ca150d7317e"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.109"

    [deps.Distributions.extensions]
    DistributionsChainRulesCoreExt = "ChainRulesCore"
    DistributionsDensityInterfaceExt = "DensityInterface"
    DistributionsTestExt = "Test"

    [deps.Distributions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    DensityInterface = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
    Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.DualNumbers]]
deps = ["Calculus", "NaNMath", "SpecialFunctions"]
git-tree-sha1 = "5837a837389fccf076445fce071c8ddaea35a566"
uuid = "fa6b7ba4-c1ee-5f82-b5fc-ecf0adba8f74"
version = "0.6.8"

[[deps.ECOS]]
deps = ["CEnum", "ECOS_jll", "MathOptInterface"]
git-tree-sha1 = "ea9f95d78d94af14e0f50973267c9c2209338079"
uuid = "e2685f51-7e38-5353-a97d-a921fd2c8199"
version = "1.1.2"

[[deps.ECOS_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "5f84034ddd642cf595e57d46ea2f085321c260e4"
uuid = "c2c64177-6a8e-5dca-99a7-64895ad7445f"
version = "200.0.800+0"

[[deps.EasyFit]]
deps = ["LsqFit", "Parameters", "Statistics", "TestItems"]
git-tree-sha1 = "861981a1edab282ff101e9f393cf961375f6be27"
uuid = "fde71243-0cda-4261-b7c7-4845bd106b21"
version = "0.6.6"

    [deps.EasyFit.extensions]
    SplineFitExt = "Interpolations"

    [deps.EasyFit.weakdeps]
    Interpolations = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"

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

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "82d8afa92ecf4b52d78d869f038ebfb881267322"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.16.3"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FillArrays]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "0653c0a2396a6da5bc4766c43041ef5fd3efbe57"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "1.11.0"
weakdeps = ["PDMats", "SparseArrays", "Statistics"]

    [deps.FillArrays.extensions]
    FillArraysPDMatsExt = "PDMats"
    FillArraysSparseArraysExt = "SparseArrays"
    FillArraysStatisticsExt = "Statistics"

[[deps.FiniteDiff]]
deps = ["ArrayInterface", "LinearAlgebra", "Requires", "Setfield", "SparseArrays"]
git-tree-sha1 = "bc0c5092d6caaea112d3c8e3b238d61563c58d5f"
uuid = "6a86dc24-6348-571c-b903-95158fe2bd41"
version = "2.23.0"

    [deps.FiniteDiff.extensions]
    FiniteDiffBandedMatricesExt = "BandedMatrices"
    FiniteDiffBlockBandedMatricesExt = "BlockBandedMatrices"
    FiniteDiffStaticArraysExt = "StaticArrays"

    [deps.FiniteDiff.weakdeps]
    BandedMatrices = "aae01518-5342-5314-be14-df237901396f"
    BlockBandedMatrices = "ffab5731-97b5-5995-9138-79e8c1846df0"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

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

[[deps.ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "LogExpFunctions", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions"]
git-tree-sha1 = "cf0fe81336da9fb90944683b8c41984b08793dad"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "0.10.36"
weakdeps = ["StaticArrays"]

    [deps.ForwardDiff.extensions]
    ForwardDiffStaticArraysExt = "StaticArrays"

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

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

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

[[deps.Graphs]]
deps = ["ArnoldiMethod", "Compat", "DataStructures", "Distributed", "Inflate", "LinearAlgebra", "Random", "SharedArrays", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "ebd18c326fa6cee1efb7da9a3b45cf69da2ed4d9"
uuid = "86223c79-3864-5bf0-83f7-82e725a168b6"
version = "1.11.2"

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

[[deps.HiGHS]]
deps = ["HiGHS_jll", "MathOptInterface", "PrecompileTools", "SparseArrays"]
git-tree-sha1 = "477bde3ee57657239b38d3bacafcb20082d9a1b2"
uuid = "87dc4568-4c63-4d18-b0c0-bb2238e4078b"
version = "1.9.2"

[[deps.HiGHS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "1f240e0fb1c4cdf39bca5d3881d1758263931ccb"
uuid = "8fd58aa0-07eb-5a78-9b36-339c94fd15ea"
version = "1.7.2+0"

[[deps.HypergeometricFunctions]]
deps = ["DualNumbers", "LinearAlgebra", "OpenLibm_jll", "SpecialFunctions"]
git-tree-sha1 = "f218fe3736ddf977e0e772bc9a586b2383da2685"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.23"

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

[[deps.Inflate]]
git-tree-sha1 = "d1b1b796e47d94588b3757fe84fbf65a5ec4a80d"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.5"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.IterTools]]
git-tree-sha1 = "42d5f897009e7ff2cf88db414a389e5ed1bdd023"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.10.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLD2]]
deps = ["FileIO", "MacroTools", "Mmap", "OrderedCollections", "PrecompileTools", "Requires", "TranscodingStreams"]
git-tree-sha1 = "049950edff105ff73918d29dbf109220ff364157"
uuid = "033835bb-8acc-5ee8-8aae-3f567f8a3819"
version = "0.4.52"

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

[[deps.JuMP]]
deps = ["LinearAlgebra", "MacroTools", "MathOptInterface", "MutableArithmetics", "OrderedCollections", "PrecompileTools", "Printf", "SparseArrays"]
git-tree-sha1 = "82bc707a67639be45ec9abf3a7640af19c4172fe"
uuid = "4076af6c-e467-56ae-b986-b466b2749572"
version = "1.23.1"

    [deps.JuMP.extensions]
    JuMPDimensionalDataExt = "DimensionalData"

    [deps.JuMP.weakdeps]
    DimensionalData = "0703355e-b756-11e9-17c0-8b28908087d0"

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

[[deps.LayeredLayouts]]
deps = ["Dates", "ECOS", "Graphs", "HiGHS", "IterTools", "JuMP", "Random"]
git-tree-sha1 = "a5bcf4f600cc57e99ce5aa4b579fbef804987b02"
uuid = "f4a74d36-062a-4d48-97cd-1356bad1de4e"
version = "0.2.10"

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

[[deps.LsqFit]]
deps = ["Distributions", "ForwardDiff", "LinearAlgebra", "NLSolversBase", "Printf", "StatsAPI"]
git-tree-sha1 = "40acc20cfb253cf061c1a2a2ea28de85235eeee1"
uuid = "2fda8390-95c7-5789-9bda-21331edee243"
version = "0.15.0"

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

[[deps.MathOptInterface]]
deps = ["BenchmarkTools", "CodecBzip2", "CodecZlib", "DataStructures", "ForwardDiff", "JSON", "LinearAlgebra", "MutableArithmetics", "NaNMath", "OrderedCollections", "PrecompileTools", "Printf", "SparseArrays", "SpecialFunctions", "Test", "Unicode"]
git-tree-sha1 = "5b246fca5420ae176d65ed43a2d0ee5897775216"
uuid = "b8f27783-ece8-5eb3-8dc8-9495eed66fee"
version = "1.31.2"

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

[[deps.Memoize]]
deps = ["MacroTools"]
git-tree-sha1 = "2b1dfcba103de714d31c033b5dacc2e4a12c7caa"
uuid = "c03570c3-d221-55d1-a50c-7939bbd78826"
version = "0.4.4"

[[deps.MetaGraphs]]
deps = ["Graphs", "JLD2", "Random"]
git-tree-sha1 = "1130dbe1d5276cb656f6e1094ce97466ed700e5a"
uuid = "626554b9-1ddb-594c-aa3c-2596fe9399a5"
version = "0.7.2"

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

[[deps.MutableArithmetics]]
deps = ["LinearAlgebra", "SparseArrays", "Test"]
git-tree-sha1 = "d0a6b1096b584a2b88efb70a92f8cb8c881eb38a"
uuid = "d8a4904e-b15c-11e9-3269-09a3773c0cb0"
version = "1.4.6"

[[deps.NLSolversBase]]
deps = ["DiffResults", "Distributed", "FiniteDiff", "ForwardDiff"]
git-tree-sha1 = "a0b464d183da839699f4c79e7606d9d186ec172c"
uuid = "d41bc354-129a-5804-8e4c-c37616107c6c"
version = "7.8.3"

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

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

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

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "949347156c25054de2db3b166c52ac4728cbad65"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.31"

[[deps.Parameters]]
deps = ["OrderedCollections", "UnPack"]
git-tree-sha1 = "34c0e9ad262e5f7fc75b10a9952ca7692cfc5fbe"
uuid = "d96e819e-fc66-5662-9728-84c9c7592b0a"
version = "0.12.3"

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

[[deps.PrettyTables]]
deps = ["Crayons", "LaTeXStrings", "Markdown", "PrecompileTools", "Printf", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "88b895d13d53b5577fd53379d913b9ab9ac82660"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "2.3.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Profile]]
deps = ["Printf"]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"

[[deps.PtrArrays]]
git-tree-sha1 = "f011fbb92c4d401059b2212c05c0601b70f8b759"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.2.0"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "37b7bb7aabf9a085e0044307e1717436117f2b3b"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.5.3+1"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "e237232771fdafbae3db5c31275303e056afaa9f"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.10.1"

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

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "f65dcb5fa46aee0cf9ed6274ccbd597adc49aa7b"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.7.1"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d483cd324ce5cf5d61b77930f0bbd6cb61927d21"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.4.2+0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.SankeyPlots]]
deps = ["Graphs", "LayeredLayouts", "MetaGraphs", "Plots", "RecipesBase", "SparseArrays"]
git-tree-sha1 = "0281823a940768f3d8828f292ec64a51039e2ccf"
uuid = "8fd88ec8-d95c-41fc-b299-05f2225f2cc5"
version = "0.2.2"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "3bac05bc7e74a75fd9cba4295cde4045d9fe2386"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Setfield]]
deps = ["ConstructionBase", "Future", "MacroTools", "StaticArraysCore"]
git-tree-sha1 = "e2cc6d8c88613c05e1defb55170bf5ff211fbeac"
uuid = "efcf1570-3423-57d1-acb7-fd33fddbac46"
version = "1.1.1"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "5d7e3f4e11935503d3ecaf7186eac40602e7d231"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.4"

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

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "2f5d4697f21388cbe1ff299430dd169ef97d7e14"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.4.0"

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

    [deps.SpecialFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "PrecompileTools", "Random", "StaticArraysCore"]
git-tree-sha1 = "eeafab08ae20c62c44c8399ccb9354a04b80db50"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.7"

    [deps.StaticArrays.extensions]
    StaticArraysChainRulesCoreExt = "ChainRulesCore"
    StaticArraysStatisticsExt = "Statistics"

    [deps.StaticArrays.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StaticArraysCore]]
git-tree-sha1 = "192954ef1208c7019899fbf8049e717f92959682"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.3"

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

[[deps.StatsFuns]]
deps = ["HypergeometricFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "cef0472124fab0695b58ca35a77c6fb942fdab8a"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.3.1"

    [deps.StatsFuns.extensions]
    StatsFunsChainRulesCoreExt = "ChainRulesCore"
    StatsFunsInverseFunctionsExt = "InverseFunctions"

    [deps.StatsFuns.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.StringManipulation]]
deps = ["PrecompileTools"]
git-tree-sha1 = "a04cabe79c5f01f4d723cc6704070ada0b9d46d5"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.3.4"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "OrderedCollections", "TableTraits"]
git-tree-sha1 = "598cd7c1f68d1e205689b1c2fe65a9f85846f297"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.12.0"

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

[[deps.TestItems]]
git-tree-sha1 = "8621ba2637b49748e2dc43ba3d84340be2938022"
uuid = "1c621080-faea-4a02-84b6-bbd5e436b8fe"
version = "0.1.1"

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

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

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
# ╟─1aceb22f-57fe-4428-bbd7-3410a10e269e
# ╟─c064e55c-6924-49b7-abbc-385a081c57b2
# ╟─01d6ccf1-a046-4386-95b9-7a8437e6bc48
# ╟─aa438d59-98d7-41b6-b34d-aa55220cf04f
# ╟─57972b14-d0eb-49f2-a8fe-fbfa25eb2f43
# ╟─dcfb10ac-3a34-477f-ae1e-6a4b42fdc0d2
# ╟─5d618284-7f40-4d33-94a1-829407bd5f47
# ╟─07eeed4a-6a40-4585-b04f-26da0157fe2e
# ╟─1eb4379f-2d29-4dea-b6c5-cd2f81ed8381
# ╟─184d5409-76fa-4970-9da7-6d8c8bd79713
# ╟─f8de4a5c-64a2-49c4-88e2-c26c843b1fc1
# ╟─39721ee5-b4f8-47ed-ae4f-0865952ebd28
# ╟─3010fa73-fdb8-4ad9-94dc-45db49ae7fcf
# ╟─f60d6cdd-7ff4-4a00-b2aa-a1440234ec6d
# ╟─cb2b0eb9-2037-4b45-9038-b2f6cd7a16cd
# ╟─127a7dbf-88fe-4b28-a265-7bf315850497
# ╟─c387e50c-5aac-4901-b1f3-51b690c38a56
# ╟─dfa54345-bcae-4350-aa43-72cd62b83d65
# ╟─59b3486d-61cd-43ac-ae1c-4bd04ab5dd40
# ╟─eb5f4190-17a0-4bac-b2a2-1d35622f3d2c
# ╟─fce78f7b-dcdc-4ae3-918d-622db2f27269
# ╟─6fef9e1c-e321-4ef8-9140-dc4dbfe49936
# ╟─349d542f-024d-4982-867c-afa9e105db27
# ╟─f1b48849-a61f-4825-bcc8-ff12d3c09987
# ╟─e05493c5-1231-4fda-821c-65420c221551
# ╠═5bb9b54a-56f3-431c-b47c-75a58bff7d22
# ╟─494278aa-f24d-4168-8615-f7803495fafd
# ╠═080ba59a-6a4a-424e-8741-9b59332c2f86
# ╟─60cc12ac-6fe6-439b-a149-39ffa704ba8b
# ╠═a41a8eeb-c2bf-4025-8a91-a5654ba69ca7
# ╟─d37297d1-3e7d-4a17-9169-6d9fe268f2c5
# ╟─df5bc5cc-9d9d-41d7-9956-a5f9af31c4cf
# ╟─13d6e0d9-2cb9-4125-a406-c4caa0d63719
# ╠═fdb1a1d4-fb0f-45ae-96ef-5c3b5bec7f69
# ╠═f202a1bf-aaf8-4115-98e9-eba0da1666e4
# ╠═bba03ae4-313e-4e3a-a367-73b1d28e733e
# ╠═22e2b92e-d1e2-4f4b-b61c-f4776976f216
# ╟─216e6f77-0b5a-4a38-aa82-6fc429147f23
# ╟─b74e6eae-d059-4409-b0cb-ba19475a53a0
# ╟─7becf999-5f11-4a47-8e3f-2b775f52bd27
# ╟─b32d55d7-80b2-45f1-abaf-ef8f6958e980
# ╠═f0132080-ad3c-47d1-b0e3-c9c7994c072f
# ╟─71a60d6f-1527-4537-952d-b490af18a935
# ╟─6a7b7432-cb54-445a-aa39-33a13fb958ba
# ╠═5bcefcd9-f30e-4b40-a1f0-b66ff862d963
# ╟─81298eb8-b548-42aa-9fea-fa502482578b
# ╟─1931180b-424d-43ba-af25-61e84faf0eaf
# ╟─7e48b1e0-b66c-4773-9189-b72e931b8520
# ╟─df08b5c7-d63b-430d-8869-a994ed85b73c
# ╟─8358d4e1-09c2-4467-b0fa-26fc9a882e9c
# ╟─bc95d83c-fb07-4f24-b08a-b461d871c79e
# ╟─404e5b4b-0ddc-45b0-a4af-e29618a501be
# ╟─2f7931fa-262f-4f76-8f4b-f28e26989a2b
# ╟─66ada8ac-6556-4d18-9cf3-cbdbf3f9bc69
# ╟─01e08f32-9f91-41f9-b022-ad877864a784
# ╟─d12d08d6-4c4c-4afc-b4e5-970f86a440e5
# ╠═2b7754b3-44b3-4a09-99e2-4827afbacc64
# ╠═d777bcfb-ffad-4061-b86b-cf3f2709576d
# ╟─9c117644-13d3-4de3-a30b-e626df7d6815
# ╠═fc62b652-0d92-49e4-ae27-fd04a6b1d8bd
# ╟─dff17723-bba8-491f-af37-9119e4ff4445
# ╠═1c048c68-2a41-4710-9d5d-e092abbfc7d9
# ╟─55483f43-ca65-4775-a4b7-b824295ad34d
# ╠═4cda0d79-6a76-4529-b70e-4eb0bf9c2451
# ╟─4643e926-67e5-4ac5-a332-1895b992b981
# ╠═0865009d-6d80-452b-b9e5-74b424f9b3c3
# ╟─361b5bbe-2fcd-4f96-8488-c52d9b2dbea5
# ╠═863fe345-3a98-46d6-9112-78ee18635ffe
# ╟─bf4807d5-6fbb-43bc-9be3-475b2ad6e0f6
# ╟─f7e7769e-9be0-41bb-900b-9034db833a5b
# ╠═ad8fdc0f-4059-4bec-98a5-8b38b5a17fd0
# ╟─7c45e9f8-de6b-4bf8-aa91-5b23a47f5d02
# ╠═5d25244c-7d05-43af-a6a5-69fdb52a253e
# ╟─29c9a3a5-73a1-4daa-b492-178b97917258
# ╠═901eaef2-2cff-4131-b19c-b43a88b35b34
# ╟─99f6a01a-4a46-43dd-8ef9-a614302e29af
# ╟─076bd182-885d-4808-ba4a-9d125cd09957
# ╟─c4fd1d3b-9b18-48b3-a0fd-466fcb3e17ee
# ╠═d780fb54-2677-481e-a228-478845fba613
# ╟─d65460a3-a703-44f6-aa42-a3dd47ae3034
# ╠═7bcd562e-970f-4614-94d0-41b8f47a5ff2
# ╠═18159d33-d61e-44cc-9966-801f15b7f5d5
# ╠═51f8e7ee-868e-47d9-bfa5-4ac06f37d942
# ╟─95fdbbc4-b612-4512-9069-6110e41f9e9d
# ╟─c771cef0-8fb8-4414-af8a-3e6512832d90
# ╟─46273cec-629b-4a2f-ba2c-e354e5003adc
# ╟─50f9ef55-ec4d-4801-a7df-b755fcc9cdef
# ╟─80d0dbc9-9e4c-4270-9395-baec8974bdf2
# ╠═fbb2ce7b-3a81-4c4e-b271-0f33819837a7
# ╟─994319d8-2e54-4edd-a6fb-cd8df9f9fcd7
# ╠═a11a242c-4672-4639-ad54-faa63d0a1cd1
# ╠═6873136d-76b9-41ee-a61f-2dd473ac8aca
# ╠═b6d6d602-03f6-4d11-be10-631a3502ea40
# ╠═e8e790c5-fd10-4797-8dbf-74cde9ac20a2
# ╠═f5d3be1c-ccb1-43ec-8d5b-5afc631cb54b
# ╟─469dd7f7-dc57-4743-a844-714fa3952c8c
# ╟─bbdfee6a-fd4d-4220-aadf-9ceba2415a75
# ╟─884beeaf-d196-4d9a-9088-a3b88ff5670e
# ╠═69892e4e-821b-4efa-b7f5-26bdbb5d0f8a
# ╟─1658f96c-7d15-4ed2-9f58-a161bc8b635f
# ╠═3ad1607a-66c4-42e2-a088-db1832fd1f32
# ╟─49e3234a-c066-42bc-bc90-bf7699309286
# ╟─065d2711-a5b6-4fcd-8e99-919296af78cb
# ╠═45757ac2-7db2-4ffa-bc5c-fb993eb6a991
# ╟─debd87f9-13ee-4177-8245-c9cc4df1d157
# ╟─2a0e3a6a-0fd0-4f9e-ab54-2377d0761ba3
# ╟─7ced39d8-26a1-497f-94fc-96d725ea6287
# ╟─e9e3afa0-0b4d-4367-a7f9-acd8992a88a5
# ╟─1ee60c29-bb29-4d9c-a2d9-20fac192f89f
# ╟─cd62422c-abd3-493d-a563-16520b237537
# ╟─6c2bab0b-4785-413b-a851-0c0ab06c73a4
# ╟─1e3c4060-5d78-4159-bb2d-caf158d9a32d
# ╠═830796ba-f8d6-4843-9297-e76492589d49
# ╟─5ea61cf4-4f87-43ef-8556-f37ea60d2515
# ╟─c870e56a-cc10-4f85-9767-af46d9845b6a
# ╟─d9063387-a1d9-44e5-81e8-9dd4111ad72a
# ╠═24331be7-d705-41e9-925a-ec76b80fa38f
# ╟─36ce1f19-59f6-4595-a75a-22f519e326d9
# ╟─c674d531-be5a-45b6-b5be-480753f0135f
# ╟─e40a1b59-ed60-4081-afbf-661373b8b3fa
# ╟─28563a65-dfbd-4143-a0ec-772e553a3fb9
# ╠═e12e7cc3-abe6-4f51-a8b0-9254dbade011
# ╟─291e034f-a119-4c9b-8a50-4a35cd54e055
# ╟─c53871d4-c739-4dcf-ad6d-c5dced86c208
# ╟─83d8e64c-e9ab-4065-a056-f189e30e149c
# ╟─5ab45915-9446-4583-a7b0-2ff97a5808f4
# ╟─0ec4b965-80c4-4b40-925a-f3dcb2fd0115
# ╟─e7aae6a9-1fa7-48a1-9b11-8e60c69cf9c9
# ╟─5dded0ab-c093-4e14-a2f2-de5d3506d171
# ╟─0b42e250-90d9-4b97-8fb6-0a7a896b92e5
# ╟─e4d17d82-b7f0-4070-9177-e6a1cebb4c24
# ╟─7787b512-37e0-4c2e-8d43-88433ce6c764
# ╟─4cbd2235-074d-4374-99c8-f290215b1640
# ╟─46a23d85-70f0-4f15-9a76-8a3701a82183
# ╟─8495592a-9619-4e2c-97fb-ef9f55f29f4d
# ╟─7ec2f5b9-5779-4f95-979d-96e23e742d5a
# ╟─6bd294df-005b-4979-b2ee-39922b9223b7
# ╠═e89303b7-3dbb-452c-bd71-ddaac5d22dc4
# ╟─42b2d4f0-4d76-4e42-bd2a-f2ed48a4e4a4
# ╠═aa0f3953-c4e8-4735-831c-9129e893ca05
# ╟─75189e15-e7bd-4dcc-9d41-27f83687b966
# ╟─61d8b963-5ad7-4f64-8b5f-46e3b40346a0
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
