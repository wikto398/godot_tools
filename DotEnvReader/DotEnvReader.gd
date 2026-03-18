class_name DotEnvReader

static func load_env(path := "res://.env") -> Dictionary:
    var env := {}
    if not FileAccess.file_exists(path):
        DebugLogger.warning(".env file not found: %s" % path)
        return env

    var file := FileAccess.open(path, FileAccess.READ)
    while not file.eof_reached():
        var line := file.get_line().strip_edges()

        if line == "" or line.begins_with("#"):
            continue

        var parts := line.split("=", false, 2)
        if parts.size() == 2:
            env[parts[0]] = parts[1]

    return env
