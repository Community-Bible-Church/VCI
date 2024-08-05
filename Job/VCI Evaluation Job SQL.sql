DECLARE @VCIAttributeId INT = 15892; -- VCI Person AttributeId
DECLARE @bgcAttributeId INT = 1298; -- Person Attribute of Background Check Date
DECLARE @LevelAttributeId INT = 15889; -- Level Attribute of VCI Matrix
DECLARE @ResponsibleAttributeId INT = 15888; -- Responsible Attribute of VCI Matrix
DECLARE @AddedAttributeId INT = 15905; -- Added Date Attribute of VCI Matrix
DECLARE @EvalAttributeId INT = 15890; -- Evaluation Date Attribute of VCI Matrix
DECLARE @NotesAttributeId INT = 15891; -- Notes Attribute of VCI Matrix

SELECT vcip.*
FROM Person p2
CROSS APPLY (
    SELECT TOP 1 pa.Guid as Person
        , levelav.[Value] as [Level]
        , addedav.ValueAsDateTime as [AddedDate]
        , evalav.ValueAsDateTime as [EvalDate]
        , responsibleav.[Value] as [Responsible]
        , vciav.[Value] as VCI
    FROM Person p
    INNER JOIN PersonAlias pa 
        ON pa.PersonId = p.Id
    INNER JOIN AttributeValue vciav
        ON vciav.EntityId = p.Id
            AND vciav.AttributeId = @VCIAttributeId
    LEFT JOIN AttributeValue bgcav
        ON bgcav.EntityId = p.Id
            AND bgcav.AttributeId = @bgcAttributeId
    INNER JOIN AttributeMatrix am
        ON vciav.[Value] = am.Guid
    INNER JOIN AttributeMatrixItem ami
        ON ami.AttributeMatrixId = am.Id
    LEFT JOIN AttributeValue levelav
        ON levelav.EntityId = ami.Id
            AND levelav.AttributeId = @LevelAttributeId
    LEFT JOIN AttributeValue responsibleav
        ON responsibleav.EntityId = ami.Id
            AND responsibleav.AttributeId = @ResponsibleAttributeId
    LEFT JOIN AttributeValue addedav
        ON addedav.EntityId = ami.Id
            AND addedav.AttributeId = @AddedAttributeId
    LEFT JOIN AttributeValue evalav
        ON evalav.EntityId = ami.Id
            AND evalav.AttributeId = @EvalAttributeId
    LEFT JOIN AttributeValue notesav
        ON notesav.EntityId = ami.Id
            AND notesav.AttributeId = @NotesAttributeId
    WHERE p.Guid = p2.Guid
    ORDER BY p.Id, evalav.ValueAsDateTime Desc
    ) vcip
WHERE cast(vcip.EvalDate as DATE) = CAST(getdate() AS DATE)