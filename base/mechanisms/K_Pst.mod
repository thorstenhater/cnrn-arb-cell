:Comment    The persistent component of the K current
:Reference  Voltage-gated K+ channels in layer 5 neocortical pyramidal neurones from young rats:subtypes and gradients,Korngreen and Sakmann, J. Physiology, 2000
:Comment    shifted -10 mv to correct for junction potential
:Comment    corrected rates using q10 = 2.3, target temperature 34, orginal 21


NEURON {
    SUFFIX K_Pst
    USEION k READ ek WRITE ik
    RANGE gK_Pstbar
}

UNITS {
    (S) = (siemens)
    (mV) = (millivolt)
    (mA) = (milliamp)
}

PARAMETER {
    gK_Pstbar = 0.00001 (S/cm2)
}

ASSIGNED {
    mInf
    mTau
    hInf
    hTau
}

STATE {
    m
    h
}

BREAKPOINT {
    SOLVE states METHOD cnexp
    ik = gK_Pstbar*m*m*h*(v-ek)
}

DERIVATIVE states {
    LOCAL qt
    qt = 2.3^((34-21)/10)
  
    mInf = 1/(1 + exp(-(v + 11)/12))
    if (v < -60){
        mTau = 1.25 + 175.03*exp( (v + 10)*0.026)
    } else {
        mTau = 1.25 +  13.00*exp(-(v + 10)*0.026)
    }
    hInf =  1/(1 + exp((v + 64)/11))
    hTau =  360 + (1010 + 24*(v + 65))*exp(-((v + 85)/48)^2)

    m' = qt*(mInf - m)/mTau
    h' = qt*(hInf - h)/hTau
}

INITIAL {
    m = 1/(1 + exp(-(v + 11)/12))
    h = 1/(1 + exp( (v + 64)/11))
}
