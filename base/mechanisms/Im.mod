: Reference: Adams et al. 1982 - M-currents and other potassium currents in bullfrog sympathetic neurones
: Comment:   corrected rates using q10 = 2.3, target temperature 34, orginal 21

NEURON {
    SUFFIX Im
    USEION k READ ek WRITE ik
    RANGE gImbar
}

UNITS {
    (S) = (siemens)
    (mV) = (millivolt)
    (mA) = (milliamp)
}

PARAMETER {
    gImbar = 0.00001 (S/cm2)
}

STATE {
    m
}

BREAKPOINT {
    SOLVE states METHOD cnexp
    ik = gImbar*m*(v - ek)
}

DERIVATIVE states {
    LOCAL qt, mAlpha, mBeta

    qt     = 2.3^((34-21)/10)
    mAlpha = 3.3e-3*exp( 2.5*0.04*(v + 35))
    mBeta  = 3.3e-3*exp(-2.5*0.04*(v + 35))

    : NB: Here the identity below does not help :/
    m'     = qt*(mAlpha - m*(mAlpha + mBeta))
}

INITIAL {
    LOCAL mAlpha, mBeta

    mAlpha = 3.3e-3*exp( 2.5*0.04*(v + 35))
    mBeta  = 3.3e-3*exp(-2.5*0.04*(v + 35))

    : NB: this is e^x/(e^x + e^-x) = 1/(1 + e^-2x), might be faster, but for one call idc :shrug:
    m = mAlpha/(mAlpha + mBeta)
}
