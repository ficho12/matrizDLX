.data

; Especificación de los Datos
a:      .float 1.0
b:      .float 2.0
c:      .float 3.0
d:      .float 4.0
e:      .float 5.0
f:      .float 6.0
g:      .float 0.0
h:      .float 0.0
i:      .float 0.0
j:      .float 0.0
k:      .float 0.0
l:      .float 0.0

.text

.global main

main:
    ; g=a*b
    lf      f0, a
    lf      f1, b
    multf   f2,f0,f1    ; a*b
    sf      g, f2

    ; h=c*d
    lf      f0, c
    lf      f1, d 
    multf   f2,f0,f1    ; c*d
    sf      h,f2

    ; i=e*f  
    lf      f0, e
    lf      f1, f 
    multf   f2,f0,f1    ; e*f
    sf      i,f2
   
    ; j=g*h
    lf      f0, g
    lf      f1, h
    multf   f2, f0, f1      ; g*h
    sf      j, f2

    ; k=a+b
    lf      f0, a
    lf      f1, b
    addf    f2, f0, f1      ; a+b
    sf      k, f2
    ; l=c+d
    lf      f0, c
    lf      f1, d
    addf    f2, f0, f1      ; c+d
    sf      l, f2

acabar:
    trap 0