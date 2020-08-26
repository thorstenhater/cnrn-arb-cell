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

    mAlpha = m_alpha(v)
    mBeta  = m_beta(v)
    mRate  = mAlpha + mBeta
    
    hAlpha = m_alpha(v)
    hBeta  = h_beta(v)
    hRate  = hAlpha + hBeta
    
    m' = qt*(mAlpha - m*mRate)
    h' = qt*(hAlpha - h*hRate)
}

INITIAL {
    LOCAL mAlpha, mBeta, hAlpha, hBeta
    
    mAlpha = m_alpha(v)
    mBeta  = m_beta(v)
    m      = mAlpha/(mAlpha + mBeta)

    hAlpha = m_alpha(v)
    hBeta  = h_beta(v)
    h      = hAlpha/(hAlpha + hBeta)
}

FUNCTION m_alpha(v) {
    m_alpha = -0.182*6*exprelr(-(v + 32)/6)
}
FUNCTION h_alpha(v) {
    h_alpha = -0.015*6*exprelr( (v + 60)/6)
}
FUNCTION m_beta(v) {
    m_beta = -0.124*6*exprelr( (v + 32)/6)
}
FUNCTION h_beta(v) {
    h_beta =-0.015*6*exprelr(-(v + 60)/6)
}

