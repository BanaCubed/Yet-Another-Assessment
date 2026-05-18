class_name Interaction extends Resource
## Resource containing details on an interaction between mutiple types of entities.


## Enum containing the valid outcomes of an interaction between two entities.
enum Outcomes {
    ## Consumes the target entity.
    ## This will convert HUNGRY selfs to SATIATED.
    ## Also removes the target entity from the board.
    CONSUME_TARGET,

    ## Consumes the entity that triggers this interaction.
    ## This will convert HUNGRY targets to SATIATED.
    ## Also removes the self from the board.
    CONSUME_SELF,

    ## Preserve the target entity.
    ## This will convert SPOILABLE targets to PRESERVED.
    PRESERVE_TARGET,

    ## Preserves the entity that triggers this interaction.
    ## This will convert SPOILABLE selfs to PRESERVED.
    PRESERVE_SELF,

    ## Makes the self unable to move through the target.
    ACT_AS_WALL,
}


## String containing the name of the target entity-type.
## This is not a direct reference to the second entity type because that could
## result in circular references or some weird instance-related equality issues.
@export var target_type: StringName
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


static func name_of_interaction(type: Outcomes) -> StringName:
    match type:
        Outcomes.CONSUME_TARGET:
            return &"CONSUMED"
        Outcomes.CONSUME_SELF:
            return &"CONSUMING SELF"
        Outcomes.PRESERVE_SELF:
            return &"PRESERVING SELF"
        Outcomes.PRESERVE_TARGET:
            return &"PRESERVED"
        Outcomes.ACT_AS_WALL:
            return &"BLOCKING"
        _:
            return &"UNKNOWN INTERACTION"


#region State After Interaction
## Takes the current states of the interacting entity and the target entity, and returns a
## tuple-like array of the new self state, and new target state.
static func state_after_interaction(type: Outcomes, current: Entity.States, target: Entity.States) -> Array[Entity.States]:
    if current == Entity.States.REMOVED or target == Entity.States.REMOVED:
        return [current, target]
    match type:
        Outcomes.CONSUME_TARGET:
            var new_current = Entity.States.SATIATED if current == Entity.States.HUNGRY else current
            return [
                new_current,
                Entity.States.REMOVED,
            ]
        Outcomes.CONSUME_SELF:
            var new_target = Entity.States.SATIATED if target == Entity.States.HUNGRY else target
            return [
                Entity.States.REMOVED,
                new_target,
            ]
        Outcomes.PRESERVE_TARGET:
            return [
                current,
                Entity.States.PRESERVED,
            ]
        Outcomes.PRESERVE_SELF:
            return [
                Entity.States.PRESERVED,
                target,
            ]
        _:
            return [current, target]
#endregion
