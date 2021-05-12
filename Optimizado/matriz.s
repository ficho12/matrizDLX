.data

;Datos de entrada y salida en DLX:
; VARIABLES DE ENTRADA: NO MODIFICAR ORDEN (Se pueden modificar los valores)
a1: .float 1.1 
a2: .float 2.2 
a3: .float 3.3
a4: .float 4.4

;;;;; VARIABLES DE SALIDA: NO MODIFICAR ORDEN
; m11, m12, m13, m14
; m21, m22, m23, m24
; m31, m32, m33, m34
; m41, m42, m43, m44
M:  .float 0.0, 0.0, 0.0, 0.0
    .float 0.0, 0.0, 0.0, 0.0
    .float 0.0, 0.0, 0.0, 0.0
    .float 0.0, 0.0, 0.0, 0.0
; hm1, hm2, hm3, hm4
HM: .float 0.0, 0.0, 0.0, 0.0

; vm1, vm2, vm3, vm4
VM: .float 0.0, 0.0, 0.0, 0.0

check:          .float 0.0
;;;;; FIN NO MODIFICAR ORDEN


.text

.global main

main:
    
    ;MF(a1,a2)    ;MF(a3,a4)
    lf      f0, a1      ; f0: a11
    lf      f1, a2      ; f1: a21
    divf    f2,f0,f1    ; f2: a12 a1/a2

    
    lf      f4, a3      ; f4: b11
    lf      f5, a4      ; f5: b21
    divf    f6,f4,f5    ; f6: b12 a1/a2
    multf   f3,f0,f1    ; f3: a22 a1*a2
    multf   f7,f4,f5    ; f7: b22 a1*a2

    ; Calculamos producto de Kronecker
    ; Primera Fila

    ;a11b11: f0*f4
    multf   f8,f0,f4
    ;a11b12: f0*f6
    multf   f9,f0,f6
    ;a12b11: f2*f4
    multf   f10,f2,f4
    ;a12b12: f2*f6
    multf   f11,f2,f6


    ; Segunda Fila

    ;a11b21: f0*f5
    multf   f12,f0,f5
    ;a11b22: f0*f7
    multf   f13,f0,f7
    ;a12b21: f2*f5
    multf   f14,f2,f5
    ;a12b22: f2*f7
    multf   f15,f2,f7



    ;MF(a2,a3) =>
    ;(a2    a2/a3)
    ;(a3    a2*a3)
    ; f1: a2=c11
    ; f4: a3=c21

    divf    f25,f1,f4    ; f25: c12 a2/a3
    multf   f26,f1,f4    ; f26: c22 a2*a3
        ;a1+a4
    addf	f24,f0,f5


    ; Tercera Fila

    ;a21b11: f1*f4
    multf   f16,f1,f4
    ;a21b12: f1*f6
    multf   f17,f1,f6
    ;a22b11: f3*f4
    multf   f18,f3,f4    
    ;a22b12: f3*f6
    multf   f19,f3,f6

    ; Cuarta Fila

    ;a21b21: f1*f5
    multf   f20,f1,f5
    ;a21b22: f1*f7
    multf   f21,f1,f7
    ;a22b21: f3*f5
    multf   f22,f3,f5    
    ;a22b22: f3*f7
    multf   f23,f3,f7



    ;(f1    f25)
    ;(f4    f26)
    ; Calculamos el determinante
    ; a2 * (a2*a3) - (a2/a3 * a3)
    ; f1 * f26 - (f25 * f4)
    ; f27 - f28
    multf   f27,f1,f26    ; f27 Det
    multf   f28,f25,f4    ; f28 Det
    subf    f29,f27,f28   ; f29: Resultado
    
    ; Dividimos a1+a4/Det
    ; f24/f29
    divf    f30,f24,f29    ; f30: Resultado Divis
    
    addi r1,r0,#60 ; 16posiciones*4bytes= 64

    ; Hacemos la multiplicacion del vector Mion
    ;m11
    multf   f0,f8,f30
    sf      M(r1), f0
    subi    r1,r1,#4 
    ;m12     
    multf   f1,f9,f30
    sf      M(r1), f1
    subi    r1,r1,#4 
    ;m13
    multf   f2,f10,f30 ;coincide1
    sf      M(r1), f2
    subi    r1,r1,#4  
    ;m14
    multf   f3,f11,f30
    sf      M(r1), f3
    subi    r1,r1,#4   
    ;-----------
    ;m21
    multf   f4,f12,f30
    sf      M(r1), f4
    subi    r1,r1,#4

    multf   f5,f13,f30
    sf      M(r1), f5
    subi    r1,r1,#4  

    multf   f6,f14,f30
    sf      M(r1), f6
    subi    r1,r1,#4 

    multf   f7,f15,f30 ;coincide2
    sf      M(r1), f7
    subi    r1,r1,#4   
    ;-----------
    ;m31
    ;multf   f8,f16,f30 ;coincide2
    sf      M(r1), f7
    subi    r1,r1,#4

    ;multf   f9,f17,f30 ;coincide1
    sf      M(r1), f2
    subi    r1,r1,#4 

    multf   f10,f18,f30
    sf      M(r1), f10
    subi    r1,r1,#4

    multf   f11,f19,f30
    sf      M(r1), f11
    subi    r1,r1,#4
    ;-------------
    ;m41
    multf   f12,f20,f30
    sf      M(r1), f12
    subi    r1,r1,#4

    multf   f13,f21,f30
    sf      M(r1), f13
    subi    r1,r1,#4

    multf   f14,f22,f30
    sf      M(r1), f14
    subi    r1,r1,#4

    multf   f15,f23,f30
    sf      M(r1), f15
    ;subi    r1,r1,#4    
    ;---------------
    

    ;VM=[m11*m21 M12*M22 M13*M23 M14*M24)]
    multf   f0,f0,f4
    multf   f1,f1,f5
    addi r1,r0,#12 ; 4*4
    multf   f2,f2,f6
    addf    f12,f0,f1 ; VM(0) --> f0 VM(4) --> f1
    multf   f3,f3,f7
    addf  f12,f12,f2
    sf      VM(r1), f0
    subi    r1,r1,#4 
    
    sf      VM(r1), f1
    subi    r1,r1,#4 
    addf  f12,f12,f3
    
    sf      VM(r1), f2
    subi    r1,r1,#4 

    
    sf      VM(r1), f3
    ;subi    r1,r1,#4 


    ;HM=[M31*M41 M32*M42 M33*M43 M34*M44]

    multf   f8,f8,f12
    addi r1,r0,#12 ; 4*4
    multf   f9,f9,f13
    addf  f12,f12,f8
    multf   f10,f10,f14
    addf  f12,f12,f9
    multf   f11,f11,f15
    addf  f12,f12,f10
    sf      HM(r1), f8
    addf  f12,f12,f11
    subi    r1,r1,#4
    sf      HM(r1), f9
    subi    r1,r1,#4
    sf      HM(r1), f10
    subi    r1,r1,#4
    sf      HM(r1), f11
    
    ;subi    r1,r1,#4
    
    ;check = 𝑣𝑚1 +𝑣𝑚2 + 𝑣𝑚3 + 𝑣𝑚4 + ℎ𝑚1 + ℎ𝑚2 + ℎ𝑚3 + ℎ𝑚4

    sf check,f12
	
    
acabar:

trap 0