DECLARE @MAX INT = 1000
;WITH NumberList(n) AS
(
    SELECT 2
    UNION ALL
    SELECT n+1 FROM NumberList WHERE n < @MAX
)
SELECT STRING_AGG( CAST(n AS VARCHAR(5)), '&') FROM NumberList nl
WHERE NOT EXISTS (SELECT 1 FROM NumberList nl2 where nl2.n < nl.n AND nl.n % nl2.n = 0)
OPTION (MAXRECURSION 0)


;WITH NumberList(n) AS
(
    SELECT 2
    UNION ALL
    SELECT n+1 FROM NumberList WHERE n < @MAX
)
SELECT STUFF(
	( 
		SELECT STRING_AGG( CAST(n AS VARCHAR(5)), '&') FROM NumberList nl
		WHERE NOT EXISTS (SELECT 1 FROM NumberList nl2 where nl2.n < nl.n AND nl.n % nl2.n = 0)
	FOR XML PATH(''),TYPE
	).value('text()[1]','nvarchar(max)'),1,2,N'')
OPTION (MAXRECURSION 0)


