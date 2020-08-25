: Reference Colbert and Pan 2002
: Comment   took the NaTa and shifted both activation/inactivation by 6 mv

NEURON {
    SUFFIX NaTs2_t
    USEION na READ ena WRITE ina
    RANGE gNaTs2_tbar
}

UNITS {
    (S) = (siemens)
    (mV) = (millivolt)
    (mA) = (milliamp)
}

PARAMETER {
    gNaTs2_tbar = 0.00001 (S/cm2)
}

STATE {
    m
    h
}

BREAKPOINT {
    SOLVE states METHOD cnexp
    ina = gNaTs2_tbar*m*m*m*h*(v - ena)
}

DERIVATIVE states {
    LOCAL qt, mAlpha, mBeta, mRate, hAlpha, hBeta, hRate
    
    qt = 2.3^((34-21)/10)
    
    mAlpha = -0.182*6*exprelr(-(v + 32)/6)
    mBeta  = -0.124*6*exprelr( (v + 32)/6)
    mRate  = mAlpha + mBeta
    
    hAlpha = -0.015*6*exprelr( (v + 60)/6)
    hBeta  = -0.015*6*exprelr(-(v + 60)/6)
    hRate  = hAlpha + hBeta
    
    m' = qt*(mAlpha - m*mRate)
    h' = qt*(hAlpha - h*hRate)
}

INITIAL {
    LOCAL mAlpha, mBeta, hAlpha, hBeta
    
    mAlpha = -0.182*6*exprelr(-(v + 32)/6)
    mBeta  = -0.124*6*exprelr( (v + 32)/6)
    m      = mAlpha/(mAlpha + mBeta)

    hAlpha = -0.015*6*exprelr( (v + 60)/6)
    hBeta  = -0.015*6*exprelr(-(v + 60)/6)
    h      = hAlpha/(hAlpha + hBeta)
}
