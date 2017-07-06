% Analytical Price of option with payoff=max(log(s)-log(e),0)

V=@(s,e,r,t,st)(exp(-r.*t).*( (log(s./e)+(r-0.5.*st.^2).*t).*normcdf(((log(s./e)+(r-0.5.*st.^2).*t)./(st.*(t.^0.5)))) +(st./((2.*pi).^0.5)).*(t.^0.5).*exp(-(((log(s./e)+(r-0.5.*st.^2).*t)./(st.*(t.^0.5))).^2)./2)));