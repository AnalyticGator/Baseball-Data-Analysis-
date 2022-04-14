	SELECT 
	playerID_batting, 
    teamID_batting,
    yearID_batting AS 'Year',
    G AS 'GA',
    AB AS 'AB',
   IFNULL(ROUND(H / AB, 3),0) AS 'BA',
    RBI AS 'RBI',
    HR AS 'HR',
    H - (2B + 3B + HR) AS '1B',
    2B,
    3B,
    SB AS 'Stolen Bases',
    CS AS 'Caught Stealing',
    BB AS 'Base on Balls',
    SO AS 'Strikeouts',
    IFnull(IBB , 'N/A') AS 'Intentional Walks',
    ifnull(HBP , 'N/A') AS 'Hit by Pitch',
    ifnull(SH , 'N/A') AS 'Sacrifice Hits',
    ifnull(SF , 'N/A') AS 'Sacrifice flies',
    GIDP AS 'Ground into Double Play'
FROM batting
WHERE G > 50 
