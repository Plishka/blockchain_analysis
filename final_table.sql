with transformed as ( -- Transformed table to convinient to visualization form
		select
			id,
			date_time,
			case
				when tx_type in ('mint', 'inscribe-deploy') then to_wallet_buy
				else from_wallet_sold end as wallet,
			case
				when tx_type = 'inscribe-deploy' then 'inscribe-deploy'
				when tx_type = 'mint' then 'mint'
				when tx_type = 'trade' then 'sell'
				when tx_type = 'transfer' then 'send'
				else null end as tx_type,
			case
				when tx_type = 'inscribe-deploy' then 1.0
				else quantity end as quantity,
			round(price_sats_fish*0.00000001, 8) as price_btc,
			round(price_sats_fish*0.00000001*63000, 4) as price_usdt
		from 
			`crypto-421016.Fish_btc.fish_project`
	union
		select
			id,
			date_time,
			to_wallet_buy as wallet,
			case
				when tx_type = 'trade' then 'buy'
				when tx_type = 'transfer' then 'recieve-transfer'
				else null end as tx_type,
			quantity,
			round(price_sats_fish*0.00000001, 8) as price_btc,
			round(price_sats_fish*0.00000001*63000, 4) as price_usdt
		from 
			`crypto-421016.Fish_btc.fish_project`
		where tx_type = 'trade' or tx_type = 'transfer'
		order by 
				2
),

list as ( -- LIST OF SUSPICIOUS WALLETS
		with cte1 as (-- List of wallets who minted 28-29.10 (first transaction)
				select
					to_wallet_buy as wallets_minted_28_29
				from
					(SELECT
							to_wallet_buy, -- mint token distribution
							sum(minted) as total_minted,
							min(date_time) as first_transaction
					FROM 
						`crypto-421016.Fish_btc.fish_project`
					WHERE 
						minted > 0
					GROUP BY 
						to_wallet_buy
					HAVING 
						first_transaction = '2023-10-28' or first_transaction = '2023-10-29'
					ORDER BY 2 desc) a
					),
		cte2 as ( -- List of wallets who bought 28-29.10, 29.12
				SELECT
					distinct to_wallet_buy as wallets_buy_29 -- mint token distribution
				FROM 
					`crypto-421016.Fish_btc.fish_project`
				WHERE
					tx_type = 'trade' and date_time in ('2023-10-28', '2023-10-29', '2023-12-29') -- dates with suspicious behavior
				and to_wallet_buy not in (select 
												to_wallet_buy
										  from (select -- wallets who made first transaction before 28.10
													to_wallet_buy,
													min(date_time) as first_trx
												from 
													`crypto-421016.Fish_btc.fish_project`
												group by 
													to_wallet_buy
												having min(date_time) < '2023-10-28') b) 
					),
		cte3 as (
				with ConnectedWallets AS (-- List of connected wallets via transfer
						SELECT 
							distinct from_wallet_sold AS sender,
							to_wallet_buy AS receiver
						FROM 
							`crypto-421016.Fish_btc.fish_project`
						WHERE tx_type = 'transfer'
						)
					SELECT 
						sender as wallets_transfer
					FROM 
						ConnectedWallets
				union distinct
					SELECT 
						receiver
					FROM 
						ConnectedWallets
						)
		select 
			wallets_minted_28_29 as list_susp
		from 
			cte1
	union distinct
		select 
			*
		from 
			cte2
	union distinct
		select 
			*
		from 
			cte3
	union distinct -- add specific wallets to the list
		SELECT 
			'bc1pu...77x2u' AS list_susp
	union distinct
		select
			'bc1px...03tsh'
	union distinct
		SELECT 
			'1G8m6...vAP3f'
)
SELECT
	t.*,
	round(t.price_usdt*t.quantity, 2) as total_usdt,
	case
		when l.list_susp is not null then 'sybil'
		else 'organic' end as remark
FROM 
	transformed t
LEFT JOIN list l on t.wallet=l.list_susp
ORDER BY
	t.date_time, substring(t.id, 2, length(t.id) - 1)