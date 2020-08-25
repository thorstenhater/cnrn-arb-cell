: Comment    The transient component of the K current
: Reference  Voltage-gated K+ channels in layer 5 neocortical pyramidal neurones from young rats:subtypes and gradients,Korngreen and Sakmann, J. Physiology, 2000
: Comment:   shifted -10 mv to correct for junction potential
: Comment    corrected rates using q10 = 2.3, target temperature 34, orginal 21

NEURON {
    SUFFIX K_Tst
    USEION k READ ek WRITE ik
    RANGE gK_Tstbar
}

UNITS {
    (S)  = (siemens)
    (mV) = (millivolt)
    (mA) = (milliamp)
}

PARAMETER {
    gK_Tstbar = 0.00001 (S/cm2)
}

STATE {
    m
    h
}

BREAKPOINT {
    SOLVE states METHOD cnexp
    ik = gK_Tstbar*(m^4)*h*(v-ek)
}

DERIVATIVE states {
    LOCAL qt, mInf, hInf, mTau, hTau
    
    qt   = 2.3^((34 - 21)/10)
    mInf = 1/(1 + exp(-(v + 10)/19))
    mTau = 0.34 + 0.92*exp(-((v + 81)/59)^2)
    hInf = 1/(1 + exp((v + 76)/10))
    hTau = 8 + 49*exp(-((v + 83)/23)^2)

    m' = qt*(mInf - m)/mTau
    h' = qt*(hInf - h)/hTau
}

INITIAL{
   m = 1/(1 + exp(-(v + 10)/19))
   h = 1/(1 + exp(-(v + 76)/-10))
}