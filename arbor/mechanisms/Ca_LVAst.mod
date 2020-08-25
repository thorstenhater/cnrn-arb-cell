:Comment   LVA ca channel. Note: mtau is an approximation from the plots
:Reference Avery and Johnston 1996, tau from Randall 1997
:Comment   shifted by -10 mv to correct for junction potential
:Comment   corrected rates using q10 = 2.3, target temperature 34, orginal 21

NEURON {
   SUFFIX Ca_LVAst
   USEION ca READ eca WRITE ica
   RANGE gCa_LVAstbar
}

UNITS {
   (S) = (siemens)
   (mV) = (millivolt)
   (mA) = (milliamp)
}

PARAMETER {
   gCa_LVAstbar = 0.00001 (S/cm2)
}

STATE {
   m
   h
}

BREAKPOINT {
   SOLVE states METHOD cnexp
   ica = gCa_LVAstbar*m*m*h*(v - eca)
}

DERIVATIVE states {
  LOCAL qt, mInf, mTau, hInf, hTau

  qt = 2.3^((34 - 21)/10)

  mInf = 1/(1 + exp(-(v + 40)/6.0))
  hInf = 1/(1 + exp( (v + 90)/6.4))
  mTau =  5 + 20/(1 + exp((v + 35)/5))  
  hTau = 20 + 50/(1 + exp((v + 50)/7))

   m' = (mInf - m)*qt/mTau
   h' = (hInf - h)*qt/hTau
}

INITIAL {
   m = 1/(1 + exp(-(v + 40)/6.0))
   h = 1/(1 + exp( (v + 90)/6.4))
}
