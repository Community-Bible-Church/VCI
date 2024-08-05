DECLARE @PersonAttributeId INT = 16966; -- Person Attribute of Workflow
DECLARE @WorkflowTypeId INT = 195; -- Workflow Type ID from VCI Evaluation

select av.ValueAsPersonId as PersonId
from Workflow w
INNER JOIN AttributeValue av
    ON w.Id = av.EntityId and av.AttributeId = @PersonAttributeId
INNER JOIN Person p 
    ON av.ValueAsPersonId = p.Id
where w.WorkflowTypeId = @WorkflowTypeId
    AND CAST(w.ActivatedDateTime as DATE) BETWEEN dateadd(d,-3,CAST(getdate() as DATE)) AND CAST(getdate() as DATE)
order by w.ActivatedDateTime Desc