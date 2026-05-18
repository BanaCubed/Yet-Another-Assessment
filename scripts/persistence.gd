class_name Persistence extends Object
## Static utility class thingy for storing the savedata of the game.


## Array containing all the completed levels.
static var completed: Array[int] = []


## Adds a level to the list of completed levels and saves the list to disk.
static func add_completed(id: int) -> void:
    completed.append(id)
    var save_file := FileAccess.open("user://savegame.save", FileAccess.WRITE_READ)

    for i in completed:
        save_file.store_64(i)


## Initializes the array of completed levels.
static func init_completed() -> void:
    # Generic error prevention system.
    if not FileAccess.file_exists("user://savegame.save"):
        return
    
    var save_file := FileAccess.open("user://savegame.save", FileAccess.READ)

    var i := -1
    completed = []
    while i != 0:
        i = save_file.get_64()
        if i > 0:
            completed.append(i)
    print("Save data loaded")
    print(completed)


static func reset_save() -> void:
    completed = []
    FileAccess.open("user://savegame.save", FileAccess.WRITE_READ)