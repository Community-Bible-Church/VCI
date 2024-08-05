DECLARE @VCIAttributeId INT = 15892; -- VCI Person Attribute ID
DECLARE @LevelAttributeId INT = 15889; -- Level Attribute ID of VCI Matrix
DECLARE @ResponsibleAttributeId INT = 15888; -- Responsible Attribute ID of VCI Matrix
DECLARE @AddedAttributeId INT = 15905; -- Added Date Attribute ID of VCI Matrix
DECLARE @EvalAttributeId INT = 15890; -- Evaluation Date Attrivute ID of VCI Matrix
DECLARE @NotesAttributeId INT = 15891; -- Notes Attribute ID of VCI Matrix

SELECT vcip.*
FROM Person p2
INNER JOIN AttributeValue vciav
    ON vciav.EntityId = p2.Id
        AND vciav.AttributeId = @VCIAttributeId
CROSS APPLY (
    SELECT TOP 1 p.Id
        , p.FirstName
        , p.LastName
        , levelav.[Value] as [Level]
        , addedav.ValueAsDateTime as [Added Date]
        , evalav.ValueAsDateTime as [Evaluation Date]
        , concat(rp.NickName,' ',rp.LastName) as [Person Responsible]
        , notesav.Value as Notes
    FROM Person p
    INNER JOIN AttributeValue vciav
        ON vciav.EntityId = p.Id
            AND vciav.AttributeId = @VCIAttributeId
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
    LEFT JOIN Person rp 
        ON rp.Id = responsibleav.ValueAsPersonId
    LEFT JOIN AttributeValue addedav
        ON addedav.EntityId = ami.Id
            AND addedav.AttributeId = @AddedAttributeId
    LEFT JOIN AttributeValue evalav
        ON evalav.EntityId = ami.Id
            AND evalav.AttributeId = @EvalAttributeId
    LEFT JOIN AttributeValue notesav
        ON notesav.EntityId = ami.Id
            AND notesav.AttributeId = @NotesAttributeId
    where p.Id = p2.Id
    ORDER BY p.Id, evalav.ValueAsDateTime Desc
    ) vcip
ORDER BY vcip.[Evaluation Date] ASC