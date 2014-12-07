function HMMbackward(v,phghm,pvgh)
    #%HMMBACKWARD HMM Backward Pass
    #% beta=HMMbackward(v,phghm,pvgh)
    #%
    #% Inputs:
    #% v : visible (observation) sequence being a vector v=[2 1 3 3 1 ...]
    #% phghm : homogeneous transition distribution phghm(i,j)=p(h(t)=i|h(t-1)=j)
    #% pvgh : homogeneous emission disrtribution pvgh(i,j)=p(v(t)=i|h(t)=j)
    #%
    #% Outputs:
    #% beta:  beta messages: \propto p(v(t+1:T)|h(t))
    #% See also HMMbackward.m, HMMviterbi.m, demoHMMinference.m

    T=length(v); H=size(phghm,1)

    pvghtrans=pvgh'
    phghmtrans=phghm'
    beta=ones(H,T)
    for t=T:-1:2
        tmp=phghmtrans*(beta[:,t].*pvghtrans[:,v[t]])
	beta[:,t-1]=tmp./sum(tmp)
    end
    return beta

end

