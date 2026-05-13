class_name Interaction extends Resource
## Resource containing details on an interaction between mutiple types of entities.


## Enum containing the valid outcomes of an interaction between two entities.
enum Outcomes {
    ## Consumes the target entity.
    ## This will convert HUNGRY selfs to SATIATED.
    CONSUME_TARGET,

    ## Consumes the entity that triggers this interaction.
    ## This will convert HUNGRY targets to SATIATED.
    CONSUME_SELF,

    ## Preserve the target entity.
    ## This will convert SPOILABLE targets to PRESERVED.
    PRESERVE_TARGET,

    ## Preserves the entity that triggers this interaction.
    ## This will convert SPOILABLE selfs to PRESERVED.
    PRESERVE_SELF,
}


## String containing the name of the target entity-type.
## This is not a direct reference to the second entity type because that could
## result in circular references or some weird instance-related equality issues.
@export var target_type: String
## The outcome of this interaction.
@export var interaction_type: Outcomes


## Utility function for getting the interactions between a source entity and a target entity.
## **DOES NOT CHECK BOTH WAYS**.
static func interactions_between(source: EntityType, target: String) -> Array[Outcomes]:
    var collector: Array[Outcomes] = []
    for rule in source.interactions:
        if rule.target_type == target:
            collector.append(rule.interaction_type)
    return collector