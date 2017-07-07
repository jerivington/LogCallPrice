% Verification of mc simulation method

% Make sure the functions logcallprice and incplot (in github repository) 
% are saved in matlab file directory before executing

% This script varies the parameters of the option pricing model: rate,
% standard deviation, underlying price, strike price, time to maturity for
% the monte carlo simulated option price using the function incplot
% and compares this to the analytical price. It then shows the convergence
% of the two solutions for increasing Monte Carlo Simulations then performs
% a random parameter test where random parameters are selected and the 
% magnitude of error isrecorded. This is done 100 times and the error 
% plotted onto a histogram.

tic % start timer

% Analytical solution to price

V=@(s,e,r,t,st)(exp(-r.*t).*( (log(s./e)+(r-0.5.*st.^2).*t).*normcdf(((...
    log(s./e)+(r-0.5.*st.^2).*t)./(st.*(t.^0.5)))) +(st./((2.*pi).^0.5))...
    .*(t.^0.5).*exp(-(((log(s./e)+(r-0.5.*st.^2).*t)./(st.*(t.^0.5))).^2)./2)));

% Parameters: s = underlying, k = strike, r=rate, t=time to maturity 
% st= standard deviation, n = number of simulations.

s=300; k=300; r=0.01; t=150/350; st=0.1; n=100000;

% Plotting Incremented Analytical Standard Deviation

subplot(2,2,1)
plot(0:0.01:0.3,V(s,k,r,t,0:0.01:0.3))
title('Analytical')
xlabel('Stardard Deviation')
ylabel('Option Price')
pause(realmin)

% Plotting Incremented Monte Carlo Standard Deviation

subplot(2,2,2)
incplot(0,0.3,5,s,k,r,t,st,n);
title('Monte Carlo')
pause(realmin)

%Plotting Incremented Analytical Rate

subplot(2,2,3)
plot(0:0.01:0.1,V(s,k,0:0.01:0.1,t,st))
xlabel('Rate')
ylabel('Option Price')
pause(realmin)

% Plotting Incremented Monte Carlo Rate

subplot(2,2,4)
incplot(0,0.1,3,s,k,r,t,st,n)
pause(realmin)
figure(2)

% Plotting Incremented Analytical Underlying Value

subplot(2,2,1)
plot(0:500,V(0:500,k,r,t,st));
axis([0 500 -inf inf])
title('Analytical')
xlabel('Initial Underlying Value')
ylabel('Option Price')
pause(realmin)

% Plotting Incremented Monte Carlo Underlying Value

figure(2)
subplot(2,2,2)
incplot(0,500,1,s,k,r,t,st,n)
axis([0 500 -inf inf])
title('Monte Carlo')
pause(realmin)

% Plotting Incremented Analytical Strike Price

figure(2)
subplot(2,2,3)
plot(100:500,V(s,100:500,r,t,st));
xlabel('Strike Price')
ylabel('Option Price')
pause(realmin)

% Plotting Incremented Monte Carlo Strike Price

figure(2)
subplot(2,2,4)
incplot(100,500,2,s,k,r,t,st,n)
pause(realmin)

% Plotting Incremented Analytical Time

figure(3)
subplot(2,2,1)
plot(0:1/365:1,V(s,k,r,0:1/365:1,st));
title('Analytical')
xlabel('Time to Maturity')
ylabel('Option Price')
pause(realmin)

% Plotting Incremented Monte Carlo Time

figure(3)
subplot(2,2,2)
incplot(0,1,4,s,k,r,t,st,n)
title('Monte Carlo')
pause(realmin)

% Plotting Convergence of Monte Carlo to Analytical for Increasing N

index=1;
storage=zeros(1,length(100:250:2*10^4));

a=V(s,k,r,t,st); % predeclaring analytical value for efficiency

for i = 100:250:2*10^4
    
   storage(1,index)=abs(a-logcallprice(s,k,r,t,st,i));
   
   index = index+1;
    
end

figure(3)
subplot(2,2,3)
plot(100:250:2*10^4,storage(1,:));
title('Error of N  Paths')
xlabel('No. of Simulations')
ylabel('Magnitude of Error')
pause(realmin)

% Plotting error of combinations of random variables

storage=zeros(1,100);

for i = 1 : 100
    
   s1=500*rand+1; e1=500*rand+1; r1=rand/10; t1=rand; st1=rand;
   
   storage(1,i)=abs(V(s1,e1,r1,t1,st1)-logcallprice(s1,e1,r1,t1,st1,n));
   
end

figure(3)
subplot(2,2,4)
histogram(storage,'BinWidth',0.0001)
title('Random Parameter Test')
xlabel('Magnitude of Error')
ylabel('Frequency /100')

toc % end timer