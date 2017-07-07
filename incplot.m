function incplot(min,max,parameter,s,k,r,t,st,n)

% Make sure function logcallprice is saved in matlab directory before using

% min is minimum incremented value
% max is maximum incremented value

% parameter selects icremented parameter to increment
% underlying - parameter = 1
% strike - parameter = 2 
% rate - parameter = 3 
% time - parameter = 4 
% stdv - parameter = 5

% s,k,r,t,st,n are base paramters for Monte Carlo when not being
% incremented. s - underlying, k - strike, r - rate, t - time to maturity,
% st - standard deviation, n - simulations.

index = 1; % index for storage vector

% predeclaring storage vector

storage = zeros(1,length(min:((max-min)/15):max));

if parameter == 1;
    
    %underlying variation
    
    for i = min:((max-min)/20):max
        
    %incrementing and storing
    
    storage(1,index)=logcallprice(i,k,r,t,st,n);
    index=index+1;

    end
    
    %plotting increments
    
    plot(min:((max-min)/20):max,storage(1,:));
    xlabel('Initial Underlying Value')

    % This procedure is the same for every other parameter selection below
    
elseif parameter == 2;
    
    for i = min:((max-min)/20):max

    storage(1,index)=logcallprice(s,i,r,t,st,n);
    index=index+1;

    end
    
    plot(min:((max-min)/20):max,storage(1,:));
    xlabel('Strike Price')
    
elseif parameter == 3;
    
    for i = min:((max-min)/20):max
    
    storage(1,index)=logcallprice(s,k,i,t,st,n);
    index=index+1;

    end
    
    plot(min:((max-min)/20):max,storage(1,:));
    xlabel('Rate')

elseif parameter == 4;
    
    for i = min:((max-min)/20):max
    
    storage(1,index)=logcallprice(s,k,r,i,st,n);
    index=index+1;

    end
    
    plot(min:((max-min)/20):max,storage(1,:));
    xlabel('Time to Maturity')
    
elseif parameter == 5;
    
    for i = min:((max-min)/20):max
    
    storage(1,index)=logcallprice(s,k,r,t,i,n);
    index=index+1;

    end
    
    plot(min:((max-min)/20):max,storage(1,:));
    xlabel('Stardard Deviation')
    
else  
    
    %output if a non-valid parameter choice is selected
    
    display('parameter input not valid')   
    
end

end