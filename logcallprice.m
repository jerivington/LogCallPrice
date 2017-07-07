function price = logcallprice(underlying, strike, rate, time, stdv, simulations)

%logcallprice Monte Carlo based pricer to price a call option with payoff
%Max(log(s)-log(k),0)


% The function takes the user inputs, defines the stepsize, defines the
% number of steps, predeclars the price, iterates a loop from 1 to number
% of simulations containing: assignment of olds and news every iteration 
% (to erase old values), performs a first order euler finite difference
% method to obtain the equity value at maturity, adds the payoff of this to 
% the price. When all simulation iterations are completed the price is
% discounted using the discount factor -rate*steps*dt and then averaged
% over all simulations.

% User inputs:
% strike - strike price of option, 
% underlying - initial underlying value,
% rate - risk neutral rate, 
% time - time until maturity (in years),
% stdv - standard deviation of stock's return (as a percentage),
% simulations - no. of paths simulated (more = more accuracy but slower).

% Other variables:
% dt - step size in time,
% steps - no. of steps to reach maturity time,
% db - scale of noise by brownian motion,
% olds - equity price at previous time step,
% news - equity price at current time step,
% randn - normally distributed random variable,

% Output:
% Price of the option today.

dt=1/365;

steps = round(time/dt,1);

db=dt^0.5;

price=0;

% Simulations iteration

for i = 1 : simulations
    
    % Assigning/ overwriting previous timestep and current timestep
    % variables
    
    olds=0;
    
    news=underlying;
    
    % Iterating for this particular simulated path
    
    for j = 1:steps
        
        % Applying Euler method
        
        olds = news;
        
        news=olds*(1+rate*dt+stdv*db*randn);
        
    end
    
    % Accumulating payoff from final equity value - news
    
    price = price + max(log(news) - log(strike), 0);
    
end

% Discounting and averaging payoff to obtain current value

price=(price*exp(-rate*steps*dt))/simulations;

end
