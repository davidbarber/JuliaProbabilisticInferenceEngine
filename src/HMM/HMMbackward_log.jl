function HMMbackward(v,phghm,pvgh;UseLogArray=true)
    #%HMMBACKWARD HMM Backward Pass
    #% logbeta=HMMbackward(v,phghm,pvgh)
    #%
    #% Inputs:
    #% v : visible (observation) sequence being a vector v=[2 1 3 3 1 ...]
    #% phghm : homogeneous transition distribution phghm(i,j)=p(h(t)=i|h(t-1)=j)
    #% pvgh : homogeneous emission disrtribution pvgh(i,j)=p(v(t)=i|h(t)=j)
    #% 
    #% Outputs:
    #% logbeta: log beta messages: log p(v(t+1:T)|h(t))
    #% See also HMMbackward.m, HMMviterbi.m, demoHMMinference.m
    
    T=length(v); H=size(phghm,1)
    
    if !UseLogArray # beta recursion (not recommended due to numerical underflow)
        beta=zeros(H,T)
        beta[:,T]=ones(H,1)
        for t=T:-1:2
            beta[:,t-1]=phghm'*(beta[:,t].*pvgh[v[t],:]')
        end
        return log(beta)
    end
    
    if UseLogArray
        logpvgh=LogArray(log(pvgh))
        logphghm=LogArray(log(phghm))
        logbetaoutput=zeros(H,T)
        logbeta = LogArray(zeros(H,1))
        for t=2:T
            logbeta=logphghm.'*(logbeta.*logpvgh[v[t],:].')
            logbetaoutput[:,t]=(logbeta).content
        end
    end
    
    return logbetaoutput
    
end

