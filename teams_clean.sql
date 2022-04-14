

CREATE OR REPLACE VIEW dim_teams AS
-- Cleansed teams table
-- Joined teamfranchises table for franchise name
SELECT 
  ID_teams, 
  yearID_teams AS 'Year', 
  W_teams AS 'Wins', 
  L_teams AS 'Losses', 
  franchName AS 'Franchise Name', 
  ifnull(WCWin_teams, 'N/A') AS 'Wildcard Series Winner', 
  ifnull(DivWin_teams, 'N/A') AS 'Division Series Winner', 
  LgWin_teams AS 'League Championship Series Winner', 
  ifnull(WSWin_teams, 'N/A') AS 'World Series Winner', 
  R_teams AS ' Runs', 
  AB_teams AS 'At-Bats', 
  H_teams AS 'Hits', 
  AB_teams - (2B_teams + 3B_teams + HR_teams) AS 'Singles', 
  2B_teams AS 'Doubles', 
  3B_teams AS 'Triples', 
  HR_teams AS 'Home Runs', 
  BB_teams AS 'Walks', 
  SO_teams AS 'Strikeouts', 
  SB_teams AS 'Stolen Bases', 
  ER_teams AS 'Earned Runs', 
  ERA_teams AS 'ERA', 
  teamRank_teams AS 'Final Division Rank' 
FROM 
  teams t 
  LEFT JOIN teamsfranchises tf on t.franchID_teams = tf.franchID
