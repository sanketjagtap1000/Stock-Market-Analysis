use stock;

select * from stocks;
select str_to_date(Date,'%d/%m/%Y') from stocks as Date;
desc stocks;
alter table stocks
modify Date date;
#Average trading volume
select Ticker,concat(round((avg(volume)/1000000),2),'M') as Average_trading_volume from stocks group by Ticker;

#Highest and Lowest dividend
select Ticker,round(sum(Dividend_Amount),2) as Sum_Dividend_Amount from stocks group by Ticker 
order by Sum_Dividend_Amount Asc;

#Highest and Lowest price to earning ratio
select Ticker,round(Avg(PE_ratio),2) as Avg_PE_ratio from stocks group by Ticker order by Avg_PE_ratio Asc;

#Highest Market Cap
select Ticker,concat(round((sum(Market_Cap)/1000000000),2),' Billions') as Highest_Market_Cap from stocks 
group by Ticker order by Highest_Market_Cap ASC;


#Most volatile stock
select Ticker,round(STDDEV(Beta),4) as Most_volatility from stocks group by Ticker 
order by Most_volatility;

#52_week_high
select Ticker , year(date) as Years , max(52_Week_High) as 52_week_high,round(avg(`adjusted close`),2) as Adjusted_close  from stocks group by Ticker,Years;


#52_week_Low
select Ticker,year(date) as Years, min(52_Week_Low) as 52_week_low,round(avg(`adjusted close`),2) as Adjusted_close  from stocks group by Ticker,Years ;


#RSI and MACD Indicator
select Ticker, count(case
	   when RSI_14days < 45 and MACD > 0 then 'Strong buying signal'
       when RSI_14days >= 69 and MACD < 0 then 'Strong selling signal'
       else 'Neutral'
       End) as StockSignalcount,
      (case
	   when RSI_14days < 45 and MACD < 0 then 'Strong buying signal'
       when RSI_14days >= 69 and MACD < 0 then 'Strong selling signal'
       else 'Neutral'
       End) as stocksignal
      
      
      from stocks 
       group by Ticker,stocksignal
       order by ticker;
       
       

       
select Ticker,date,(case
	   when RSI_14days < 45 and MACD > 0 then 'Strong buying signal'
       when RSI_14days >= 69 and MACD < 0 then 'Strong selling signal'
       else 'Neutral'
       End) as StockSignal

 from stocks 
       group by stocksignal,ticker,date
       order by date;






