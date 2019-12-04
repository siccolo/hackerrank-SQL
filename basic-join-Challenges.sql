DECLARE @MaxChallenges INT =0
SET @MaxChallenges = 
(
    SELECT TOP 1 COUNT(*)
    FROM Challenges (NOLOCK) c
    GROUP BY hacker_id
    ORDER BY COUNT(*) DESC
)

SELECT h.hacker_id, h.name, c.Challenges
FROM Hackers (NOLOCK) h
INNER   JOIN
(
    SELECT hacker_id, Challenges = COUNT(*)
    FROM Challenges (NOLOCK) c
    GROUP BY hacker_id
)c ON c.hacker_id = h.hacker_id
WHERE 1=1
AND  (
        c.Challenges=@MaxChallenges
        OR NOT EXISTS
        (
                SELECT 1 FROM Challenges (NOLOCK) cdup
                WHERE cdup.hacker_id != h.hacker_id
                GROUP BY cdup.hacker_id
                HAVING COUNT(*) = c.Challenges
            )
     )
ORDER BY c.Challenges DESC, h.hacker_id
