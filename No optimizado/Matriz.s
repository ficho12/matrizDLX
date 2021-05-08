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
    ;MF(a1,a2)
    lf      f0, a1      ; f0: a11
    lf      f1, a2      ; f1: a21
    divf    f2,f0,f1    ; f2: a12 a1/a2
    multf   f3,f0,f1    ; f3: a22 a1*a2
    ;MF(a3,a4)
    lf      f4, a3      ; f4: b11
    lf      f5, a4      ; f5: b21
    divf    f6,f4,f5    ; f6: b12 a1/a2
    multf   f7,f4,f5    ; f7: b22 a1*a2

    ; Calculamos producto de Kronecker
    ; Primera Fila

    ;a11b11: f0*f4
    multf   f8,f0,f5
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
    
    ; Tercera Fila

    ;a21b11: f1*f4
    multf   f16,f1,f4
    ;a21b12: f1*f6
    multf   f17,f1,f6
    ;a22b11: f3*f4
    multf   f18,f3,f4    
    ;a22b12: f1*f6
    multf   f19,f1,f6

    ; Cuarta Fila

    ;a21b21: f1*f5
    multf   f20,f1,f5
    ;a21b22: f1*f7
    multf   f21,f1,f7
    ;a22b21: f3*f5
    multf   f22,f3,f5    
    ;a22b22: f3*f7
    multf   f23,f3,f7

    ;a1+a4
    addf f24,a1,a4

    ;MF(a2,a3) =>
    ;(a2    a2/a3)
    ;(a3    a2*a3)
    ; f1: a2=c11
    ; f4: a3=c21
    divf    f25,f1,f4    ; f25: c12 a2/a3
    multf   f26,f1,f4    ; f26: c22 a2*a3
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
    divf    f30,f24,f29    ; f30: Resultado Division

    ; Hacemos la multiplicacion del vector M
    
    multf   M(0),f8,f30
    multf   M(4),f9,f30
    multf   M(8),f10,f30
    multf   M(12),f11,f30

    multf   M(16),f12,f30
    multf   M(20),f13,f30
    multf   M(24),f14,f30
    multf   M(28),f15,f30

    multf   M(32),f16,f30
    multf   M(36),f17,f30
    multf   M(40),f18,f30
    multf   M(44),f19,f30

    multf   M(48),f20,f30
    multf   M(52),f21,f30
    multf   M(56),f22,f30
    multf   M(60),f23,f30    

    ;VM=[M(0)*M(16) M(4)*M(20) M(8)*M(24) M(12)*M(28)]
    multf   VM(0),f8,f12
    multf   VM(4),f9,f13
    multf   VM(8),f10,f14
    multf   VM(12),f11,f15

    ;HM=[M(32)*M(48) M(36)*M(52) M(40)*M(56) M(44)*M(60)]

    multf   HM(0),f16,f20
    multf   HM(4),f17,f21
    multf   HM(8),f18,f22
    multf   HM(12),f19,f23
    
    ;check = 𝑣𝑚1 +𝑣𝑚2 + 𝑣𝑚3 + 𝑣𝑚4 + ℎ𝑚1 + ℎ𝑚2 + ℎ𝑚3 + ℎ𝑚4
    addf  f0,VM(0),VM(4)
    addf  f0,f0,VM(8)
    addf  f0,f0,VM(12)
    addf  f0,f0,HM(0)
    addf  f0,f0,HM(4)
    addf  f0,f0,HM(8)
    addf  check,f0,HM(12)

acabar:

trap 0