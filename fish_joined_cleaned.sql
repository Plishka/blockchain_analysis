with cte as (
		select
			distinct t1.id,
			case
				when t3.type is not null then t3.type
				when t1.type = 'inscribe-mint' then 'mint'
				else t1.type end as type,
			t1.quantity,
			t1.from_address as from_wallet_sold,
			t1.to_address as to_wallet_buy,
			t1.date_time,
			case
				when t1.type = 'inscribe-mint' then 60.0 -- average mint price per 1 fish (sats)
				when t1.type = 'inscribe-deploy' then 6000.0 -- contract deploy cost (sats)
				else t3.price_sats_fish end as price_sats_fish,
		from `crypto-421016.Fish_btc.fish` t1
		left join `crypto-421016.Fish_btc.trades` t3 on t1.id = t3.id	   -- trades table
		left join `crypto-421016.Fish_btc.failed_mint` t2 on t1.id = t2.id -- delete failed transactions
		from the main list
		where t2.id is null and t1.type <> 'inscribe-transfer'
)
select
	*
from cte
where 
	id not in (select id from xxx where from_wallet_sold = to_wallet_buy) -- filter records where sender and receiver is the same
order by 
	date_time, SUBSTRING(t1.id, 2, LENGTH(t1.id) - 1)