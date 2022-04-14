SELECT *   -- Peoples and appearance tables joined. Games played >= 50 and Player is active.
FROM
(SELECT -- Peoples and Appearance tables joined.  Games played >= 50 and 
  p.playerID_people AS 'PlayerID', 
  p.nameFirst AS 'First Name', 
  p.nameLast AS 'Last Name', 
  p.birth_date AS 'Birth Date', 
  p.weight AS 'Weight', 
  p.height AS 'Height', 
  p.bats AS 'Bats', 
  p.throws AS 'Throws', 
  Total_Games, 
  p.finalgame AS 'Final Game', 
  CASE WHEN death_date IS NULL THEN timestampdiff(year, p.birth_date, CURRENT_DATE) ELSE 'Passed Away' END AS 'Current Age', 
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
Order BY 
  Total_Games desc

) appearance50_active

WHERE Player_Status like 'Active'  
	
