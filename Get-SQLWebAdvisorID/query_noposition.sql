USE [ODS_HR]

SELECT *
FROM (
    SELECT   P.ID AS [EMPLOYEEID]
            ,P.FIRST_NAME AS [GIVENNAME]
            ,P.MIDDLE_NAME AS [MIDDLENAME]
            ,P.LAST_NAME AS [SURNAME]
            ,P.SUFFIX AS [SUFFIX]
            ,P.PREFERRED_NAME AS [PREFERREDNAME]
            ,PP.PERSON_PIN_USER_ID AS [EXTENSIONATTRIBUTE1]
            ,P.BIRTH_DATE
            ,P.SSN
    FROM ODS_ST.dbo.S85_PERSON AS P -- WITH (NOLOCK)
    LEFT JOIN ODS_ST.dbo.S85_PERSON_PIN AS PP -- WITH (NOLOCK)
        ON PP.PERSON_PIN_ID = P.ID
    ) AS PERSON
WHERE PERSON.EMPLOYEEID IS NOT NULL