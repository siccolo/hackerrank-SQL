CREATE TABLE OO (N INT NULL, P INT NULL)
GO
INSERT INTO OO
SELECT 1 , 2 
UNION ALL 
SELECT 3 , 2 
UNION ALL 
SELECT 6 , 8
UNION ALL  
SELECT 9 , 8
UNION ALL  
SELECT 2 , 5
UNION ALL  
SELECT 8 , 5
UNION ALL  
SELECT 5 , NULL
GO

;WITH h (v, vp, vlevel, vpath) AS (
	SELECT root.N, NULL, 'root', CAST (root.N AS VARCHAR(MAX))FROM OO as root WHERE P IS NULL
	UNION ALL 
		SELECT leaf.N, leaf.P, 'leaf', h.vpath + ' -> ' + CAST (leaf.N AS VARCHAR(MAX))
		FROM OO as leaf 
			INNER JOIN h ON leaf.P = h.v
)
SELECT * FROM h
ORDER BY v

;WITH h (v, vp, vlevel, vpath) AS (
	SELECT [v] = root.N
			, NULL
			, [vlevel] = CAST ( 'Root' AS VARCHAR(50))
			, CAST (root.N AS VARCHAR(MAX))
		FROM OO as root WHERE P IS NULL
	UNION ALL 
		SELECT [v] = leaf.N
			, leaf.P
			, [vlevel]= CASE WHEN EXISTS (SELECT 1 FROM OO WHERE P=leaf.N) THEN CAST ( 'Inner' AS VARCHAR(50))  ELSE 'Leaf' END
			, h.vpath + ' -> ' + CAST (leaf.N AS VARCHAR(MAX))
		FROM OO as leaf 
			INNER JOIN h ON leaf.P = h.v
)	
SELECT v, vlevel FROM h
ORDER BY v
