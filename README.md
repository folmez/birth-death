# birth-death
g = BIRTH_DEATH(N) calculates survival times of the simple birth-death process. Process starts with one individual. At any point, one individual of the population gives birth to a new individual or dies, with equal probability. That is, when population is n, it becomes n+1 with probability 1/2 and n-1 with probabilitylity 1/2. Time between birth-death events is exponentially distributed random variable.

This algorithm is originally written to analyse the results published in Font-Clos, Francesc, et al. "The perils of thresholding." New Journal of Physics 17.4 (2015): 043066.