/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/
SELECT C.Company_Code, C.Founder
    , LMCount= ISNULL(LMCount,0)
    , SMCount = ISNULL(SMCount,0)
    , MCount = ISNULL(MCount,0)
    , ECount = ISNULL(ECount,0)
FROM Company (NOLOCK) C
    LEFT OUTER JOIN 
    (
            SELECT LM.Company_Code, COUNT(DISTINCT lead_manager_code) AS LMCount
            FROM Lead_Manager (NOLOCK)LM
            GROUP BY LM.Company_Code
    )LM
    ON LM.Company_Code = C.Company_Code
    
    LEFT OUTER JOIN 
    (
            SELECT SM.Company_Code, COUNT(DISTINCT senior_manager_code) AS SMCount
            FROM Senior_Manager (NOLOCK) SM
            GROUP BY SM.Company_Code
    )SM
    ON SM.Company_Code = C.Company_Code
    
    LEFT OUTER JOIN 
    (
            SELECT  M.Company_Code, COUNT(DISTINCT manager_code) AS  MCount
            FROM Manager (NOLOCK)  M
            GROUP BY M.Company_Code
    )M
    ON M.Company_Code = C.Company_Code
    
    LEFT OUTER JOIN 
    (
            SELECT  E.Company_Code, COUNT(DISTINCT employee_code) AS  ECount
            FROM Employee (NOLOCK)  E
            GROUP BY E.Company_Code
    )E
    ON E.Company_Code = C.Company_Code
    
ORDER BY C.Company_Code
