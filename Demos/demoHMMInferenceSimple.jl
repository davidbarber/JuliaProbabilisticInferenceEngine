function demoHMMInferenceSimple()

    V=5  # number of visible states
    H=10 # numbmer of hidden states
    T=20 # number of timesteps

    # setup the HMM
    h = zeros(Int64,1,T) # holds the state value for the hidden variable at a specific timestep
    v = zeros(Int64,1,T) # holds the state value for the visible variable at a specific timestep

    ph1=condp(rand(H,1)) # probabilities for the states of the hidden variable at timestep 1

    phghm=condp(eye(H,H))  # transition matrix with sum(phghm, 1) = 1 with phghm[i, j] = p(hg=i | hm=j), hg @t, hm @t-1
    # shuffle the column data in phghm while keeping sum(phghm, 1) = 1
    # done below such as no 2 columns have value 1.0 on the same row
    phghmtmp=condp(eye(H,H))
    r=randperm(H)
    for i=1:H
        phghm[:,i]=phghmtmp[:,r[i]]
    end

    pvgh=condp((rand(V,H))) # emision matrix with sum(pvgh, 1) = 1 with pvgh[i, j] = p(vg = i | h = j), vg, h @t

    % generate some fake data
    h[1]=randgen(ph1) # initialize the hidden variable @t=1 with a random state based on ph1 distribution
    v[1]=randgen(pvgh[:,h[1]]) # initialize the visible variable @t=1 with a random state based on pvgh( vg | h@t=1)

    for t=2:T
        h[t]=randgen(phghm[:,h[t-1]]) # set the hidden variable state @t based on h@t-1 using the transition matrix
        v[t]=randgen(pvgh[:,h[t]]) # set the visible variable state @t based on h@t using the emission matrix
    end

    # Perform Inference tasks:
    alpha,loglik=HMMforward(v,phghm,ph1,pvgh); # filtering

    # smoothed posteriors:
    gamma = HMMsmooth(v,phghm,ph1,pvgh,alpha); # smoothing

    # most likely joint state
    maxstate,logprob = HMMviterbi(v,phghm,ph1,pvgh);

    println("Inference log likelihood = $loglik\n")
    println("most likely path (viterbi):\n")
    println(maxstate)
    println("original path (hidden states):")
    println(h)
    println("original path (visible states):")
    println(v)

    PyPlot.pcolor(alpha); PyPlot.suptitle("filtering");
    PyPlot.figure();
    PyPlot.pcolor(gamma); PyPlot.suptitle("smoothing");

end
