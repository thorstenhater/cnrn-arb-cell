NEURON  {
    SUFFIX NaTa_t
    USEION na READ ena WRITE ina
    RANGE gNaTa_tbar
}

UNITS {
    (S)  = (siemens)
    (mV) = (millivolt)
    (mA) = (milliamp)
}

PARAMETER {
    gNaTa_tbar = 0.00001 (S/cm2)
}

STATE {
    m
    h
}

BREAKPOINT {
    SOLVE states METHOD cnexp
    ina = gNaTa_tbar*m*m*m*h*(v-ena)
}

DERIVATIVE states {
    LOCAL qt, mAlpha, mBeta, mRate, hAlpha, hBeta, hRate
    qt = 2.3^((34-21)/10)

    mAlpha = -0.182*6*exprelr(-(v + 38)/6)
    mBeta  = -0.124*6*exprelr( (v + 38)/6)
    mRate  = mAlpha + mBeta

    hAlpha = -0.015*6*exprelr( (v + 66)/6)
    hBeta  = -0.015*6*exprelr(-(v + 66)/6)
    hRate  = hAlpha + hBeta

    m' = qt*(mAlpha - m*mRate)
    h' = qt*(hAlpha - h*hRate)
}

INITIAL {
     LOCAL mAlpha, mBeta, hAlpha, hBeta
							 
    mAlpha = -0.182*6*exprelr(-(v + 38)/6)
    mBeta  = -0.124*6*exprelr( (v + 38)/6)
    m      = mAlpha/(mAlpha + mBeta)

    hAlpha = -0.015*6*exprelr( (v + 66)/6)
    hBeta  = -0.015*6*exprelr(-(v + 66)/6)
    h      = hAlpha/(hAlpha + hBeta)
}
