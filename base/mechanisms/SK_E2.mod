: SK-type calcium-activated potassium current
: Reference : Kohler et al. 1996

NEURON {
    SUFFIX SK_E2
    USEION k READ ek WRITE ik
    USEION ca READ cai
    RANGE gSK_E2bar
}

UNITS {
    (mV) = (millivolt)
    (mA) = (milliamp)
    (mM) = (milli/liter)
}

PARAMETER {
    gSK_E2bar = 0.000001 (mho/cm2)
    zTau      = 1        (ms)
}

STATE {
    z FROM 0 TO 1
}

BREAKPOINT {
    SOLVE states METHOD cnexp
    ik = gSK_E2bar*z*(v - ek)
}

DERIVATIVE states {
    LOCAL ca, zInf
    ca = cai
    if (ca < 1e-7) {
            ca = ca + 1e-07
    }
    zInf =  1/(1 + (0.00043/ca)^4.8)

    z' = (zInf - z)/zTau
}

INITIAL {
    LOCAL ca
    ca = cai
    if (ca < 1e-7) {
            ca = ca + 1e-07
    }
    z =  1/(1 + (0.00043/ca)^4.8)
}
