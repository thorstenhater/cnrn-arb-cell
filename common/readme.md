# Common inputs

This path contains the common inputs that will define the model for both Arbor and NEURON/CoreNeuron.

Specifically:

  1. A flat morphology description that can be read and used 'as is' with no modification.
  2. A JSON file that defines the single cell model:
    - mechanism+paremeter distribution over regions
    - elecrophysiological parametres (capacitance, resistivity, initial voltage (default and local)
    - ion properties (concentrations, reversal potential, reversal potential calcluation method) (global and local)
    - global parameters like `celcius`.
  3. A JSON file that defines simulation properties:
    - simulation duration and timestep
    - what to record (voltage traces, spikes)
    - how many instances of the cells to simulate

## Units

The input JSON provides values for parameters like `cm`, `v_init`, `ena` etc.
Arbor uses the same units as NEURON, with few exceptions:
  * `cm` in Arbor is `F⋅m⁻²`
  * temperature in Arbor is called `temperature`, not `celcius`, and is given in Kelvin.
    * Arbor automatically converts when `celcius` is used in NMODL mechanisms.

So we suggest that the model description should us the same units as NEURON.

| parameter | units |
| --------- | ----- |
|   voltage               | mV          |
|   reversal potentials   | mV          |
|   concentrations (ions) | mM          |
|   axial resistivity     | Ω·cm        |
|   membrane capacitance  | μf⋅cm⁻²     |
|   temperature           | celcius     |
