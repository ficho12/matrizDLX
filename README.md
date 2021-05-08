# matrizDLX
Desarrollo y optimización de un código que realice cálculos con matrices en DLX


� = (𝑀𝐹(𝑎1
, 𝑎2) ⊗ 𝑀𝐹(𝑎3
, 𝑎4)) ×
𝑎1 + 𝑎4
|𝑀𝐹(𝑎2
, 𝑎3)|
VM=[𝑚11 ∗ 𝑚21 𝑚12 ∗ 𝑚22 𝑚13 ∗ 𝑚23 𝑚14 ∗ 𝑚24]
HM=[𝑚31 ∗ 𝑚41 𝑚32 ∗ 𝑚42 𝑚33 ∗ 𝑚43 𝑚34 ∗ 𝑚44]
𝑐ℎ𝑒𝑐𝑘 = 𝑣𝑚1 +𝑣𝑚2 + 𝑣𝑚3 + 𝑣𝑚4 + ℎ𝑚1 + ℎ𝑚2 + ℎ𝑚3 + ℎ𝑚4
siendo:
• VM y HM matrices de 1x4:
o [𝑣𝑚1 𝑣𝑚2 𝑣𝑚3 𝑣𝑚4]
o [ℎ𝑚1 ℎ𝑚2 ℎ𝑚3 ℎ𝑚4]
• M matriz 4x4: [
𝑚11 𝑚12 𝑚13 𝑚14
𝑚21 𝑚22 𝑚23 𝑚24
𝑚31 𝑚32 𝑚33 𝑚34
𝑚41 𝑚42 𝑚43 𝑚44]
• |𝐴| determinante de la matriz
• 𝑎𝑋 números reales
• 𝑀𝐹(𝛼1
, 𝛼2) la siguiente matriz:
𝑀𝐹(𝛼1
, 𝛼2) = [
𝛼1 𝛼1/𝛼2
𝛼2 𝛼1 ∗ 𝛼2
]
• ⊗ el producto de Kronecker
o 𝐴 ⊗ 𝐵 = [
𝑎11𝐵 𝑎12𝐵
𝑎21𝐵 𝑎22𝐵
] = [
𝑎11𝑏11 𝑎11𝑏12 𝑎12𝑏11 𝑎12𝑏12]
𝑎11𝑏21 𝑎11𝑏22 𝑎12𝑏21 𝑎12𝑏22]
𝑎21𝑏11 𝑎21𝑏12 𝑎22𝑏11 𝑎22𝑏12]
𝑎21𝑏21 𝑎21𝑏22 𝑎22𝑏21 𝑎22𝑏22]
𝐴, 𝐵 matrices de 2x2 
[𝑎11 𝑎12]
[𝑎21 𝑎22],
[𝑏11 𝑏12]
[𝑏21 𝑏22]
