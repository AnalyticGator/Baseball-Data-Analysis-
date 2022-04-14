Select  -- Active players Total_RBI from 2015 - 2018 desc.  Joining of people_clean_active and batting_clean
  distinct playerID_people, 
  nameFirst, 
  nameLast, 
  SUM(RBI) OVER (PARTITION BY playerID_batting) AS Total_RBI 
FROM 
  (
    SELECT 
      * -- Peoples and appearance tables joined. Games played >= 50 and Player is active.
    FROM 
      (
        SELECT 
          -- Peoples and Appearance tables joined.  Games played >= 50 and 
          p.playerID_people, 
          p.nameFirst, 
          p.nameLast, 
          p.finalgame AS 'Last Game Played', 
          CASE WHEN p.finalGame >= '2019-03-28' THEN 'Active' ELSE 'Inactive' END AS Player_Status 
        FROM 
          people p 
          Join (
            Select 
              -- Appearances sub query to get a list of all PlayerId's and the sum of total games played. Utilize Total_Games to filter for players who have played in 50 or more games. 
              DISTINCT playerID_appearances, 
              Total_Games 
            FROM 
              (
                SELECT 
                  -- Appearances inner sub query to get a list of all PlayerId's and the sum of total games played. Add column for Total Games played  
                  *, 
                  SUM(G_all) OVER (
                    PARTITION BY playerID_appearances
                  ) AS Total_Games 
                FROM 
                  lahmansbaseballdb.appearances
              ) innersub_appearance50
          ) appearance50 on p.playerID_people = appearance50.PlayerID_appearances 
        WHERE 
          Total_Games >= 50
      ) appearance50_active 
    WHERE 
      Player_Status like 'Active'
  ) people_clean_active 
  LEFT JOIN(
    SELECT 
      playerID_batting, 
      yearID_batting AS 'Year', 
      RBI AS 'RBI' 
  
    FROM 
      batting
  ) batting_clean on playerID_people = playerID_batting 
WHERE 
  YEAR between 2015 
  and 2018 
ORDER BY 
  RBI desc
