: Reference: Reuveni, Friedman, Amitai, and Gutnick, J.Neurosci. 1993

NEURON {
   SUFFIX Ca_HVA
   USEION ca READ eca WRITE ica
   RANGE gCa_HVAbar 
}

UNITS {
   (S)  = (siemens)
   (mV) = (millivolt)
   (mA) = (milliamp)
}

PARAMETER {
   gCa_HVAbar = 0.00001 (S/cm2) 
}

STATE {
   m
   h
}

BREAKPOINT {
   SOLVE states METHOD cnexp
   ica = gCa_HVAbar*m*m*h*(v - eca)
}

DERIVATIVE states {
   LOCAL mAlpha, mBeta, mRate, hAlpha, hBeta, hRate
   
   mAlpha = 0.055*3.8*exprelr(-(v + 27)/3.8)
   mBeta  = 0.94*exp(-(v + 75)/17)
   mRate  = mAlpha + mBeta

   hAlpha = 0.000457*exp(-(v + 13)/50)
   hBeta  = 0.0065/(exp(-(v + 15)/28) + 1)
   hRate  = hAlpha + hBeta

   m' = mAlpha - m*mRate
   h' = hAlpha - h*hRate
}

INITIAL {
   LOCAL mAlpha, mBeta, hAlpha, hBeta

   mAlpha = 0.055*3.8*exprelr(-(27 + v)/3.8)
   mBeta  = 0.94*exp(-(v + 75)/17)

   hAlpha = 0.000457*exp(-(v + 13)/50)
   hBeta  = 0.0065/(exp(-(v + 15)/28) + 1)

   m = mAlpha/(mAlpha + mBeta)
   h = hAlpha/(hAlpha + hBeta)
}
