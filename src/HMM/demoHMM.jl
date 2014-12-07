function demoHMM()

    V=5  # number of visible states
    H=10 # numbmer of hidden states
    T=20 # number of timesteps

    h=zeros(Int64,1,T)
    v=zeros(Int64,1,T)
    ph1=condp(rand(H,1))
    phghmtmp=condp(eye(H,H))
    phghm=condp(eye(H,H))
    r=randperm(H)
    for i=1:H
        phghm[:,i]=phghmtmp[:,r[i]]
    end
    pvgh=condp((rand(V,H)))

    h[1]=randgen(ph1)
    v[1]=randgen(pvgh[:,h[1]])

    for t=2:T
        h[t]=randgen(phghm[:,h[t-1]])
        v[t]=randgen(pvgh[:,h[t]])
    end

    alpha,loglik=HMMforward(v,phghm,ph1,pvgh); # filtering

    println("Log Liklihood = $loglik\n")

    gamma = HMMsmooth(v,phghm,ph1,pvgh,alpha); # smoothing

    #phtgV1T, phthtpgV1T, loglik = HMMsmooth(v,phghm,ph1,pvgh,ReturnLogLikelihood=true,ReturnPairwiseMarginals=true)

    maxstate,logprob=HMMviterbi(v,phghm,ph1,pvgh);
    println("most likely path (viterbi):\n")
    println(maxstate)

    PyPlot.pcolor(alpha); PyPlot.suptitle("filtering");
    PyPlot.figure();
    PyPlot.pcolor(gamma); PyPlot.suptitle("smoothing");

end
