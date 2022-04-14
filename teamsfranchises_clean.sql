SELECT franchID
	,franchName
	,ifnull(active, 'N') AS 'Active'
FROM lahmansbaseballdb.teamsfranchises
