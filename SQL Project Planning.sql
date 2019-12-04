;WITH pl AS 
(
  SELECT p.Start_Date
        , p.End_Date
        , rn = ROW_NUMBER() OVER (ORDER BY p.Start_Date)
  FROM Projects (NOLOCK) p
)
SELECT   MIN(Start_Date), MAX(End_Date) 
FROM pl WITH (NOLOCK)
GROUP BY DATEDIFF(DAY, rn, End_Date)
ORDER BY DATEDIFF(DAY, MIN(Start_Date), MAX(End_Date)), MIN(Start_Date)
