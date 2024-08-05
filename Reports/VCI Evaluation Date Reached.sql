DECLARE @VCIAttributeId INT = 15892; -- VCI Person AttributeId
DECLARE @EvalAttributeId INT = 15890; -- Evaluation Date AttributeId from VCI Matrix
DECLARE @LevelAttributeId INT = 15889; -- Level AttributeId from VCI Matrix
DECLARE @bgcAttributeId INT = 1298; -- Background Check date Attribute Id
DECLARE @msAttributeId INT = 8524; -- Safety Awareness Training Date Attribute Id

SELECT topvci.*
FROM PersonAlias pa 
INNER JOIN AttributeValue avvci 
    ON avvci.EntityId = pa.AliasPersonId
        AND avvci.AttributeId = @VCIAttributeId
CROSS APPLY (
    SELECT TOP 1 p.Id
    , p.NickName
    , p.LastName
        , avlevel.Value AS [Level]
        , aveval.ValueAsDateTime AS EvalDate
        , avbgc.ValueAsDateTime as BGCDate
        , avms.ValueAsDateTime as MSDate
    FROM Person p
    INNER JOIN PersonAlias vpa
        ON vpa.AliasPersonId = p.Id
    INNER JOIN AttributeValue av
        ON av.EntityId = p.Id
            AND av.AttributeId = @VCIAttributeId
    INNER JOIN AttributeMatrix am
        ON am.Guid = av.Value
    INNER JOIN AttributeMatrixItem ami
        ON ami.AttributeMatrixId = am.Id
    INNER JOIN AttributeValue aveval
        ON aveval.EntityId = ami.Id
            AND aveval.AttributeId = @EvalAttributeId
    INNER JOIN AttributeValue avlevel
        ON avlevel.EntityId = ami.Id
            AND avlevel.AttributeId = @LevelAttributeId
    INNER JOIN AttributeValue avbgc
        ON avbgc.EntityId = p.Id 
            AND avbgc.AttributeId = @bgcAttributeId
    LEFT JOIN AttributeValue avms 
        ON avms.EntityId = p.Id 
            AND avms.AttributeId = @msAttributeId
    WHERE vpa.Guid = pa.Guid
    ORDER BY aveval.ValueAsDateTime Desc
    ) topvci
--    ON topvci.Person = pa.Guid
WHERE topvci.EvalDate between '1/1/2024' and getdate()
order by topvci.EvalDate desc