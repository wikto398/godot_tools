extends Node

enum LogLevel {
    TRACE,
    DEBUG,
    INFO,
    WARNING,
    ERROR
}

func _ready() -> void:
    var log_level = ArgsParser.kwargs.get("log_level", "INFO").to_upper()
    current_log_level = LogLevel[log_level]
    var log_to_file_arg = ArgsParser.kwargs.get("log_to_file", "false").to_lower()
    to_file = log_to_file_arg == "true"

var current_log_level: LogLevel = LogLevel.DEBUG:
    set(value):
        current_log_level = value
        debug("Log level set to: " + LogLevel.find_key(current_log_level))
var to_file: bool = false:
    set(value):
        to_file = value
        debug("Logging to file: " + str(to_file))
        if to_file and not log_file:
            debug("Initializing log file for DebugLogger")
            var log_path = "res://logs/debug_log.txt"
            log_file = FileAccess.open(log_path, FileAccess.WRITE)
            if log_file:
                debug("Log file created at: " + log_path)
            else:
                error("Failed to create log file at: " + log_path)

var log_file: FileAccess = null

func _log(message: String, level: LogLevel = LogLevel.DEBUG) -> void:
    if level < current_log_level:
        return
    var level_str = LogLevel.find_key(level)
    var timestamp = Time.get_datetime_string_from_system()
    var message_str = "[" + level_str + "] | " + timestamp + " | " + message
    if to_file and log_file:
        log_file.store_line(message_str)
        log_file.flush()
    else:
        print(message_str)

func trace(message: String) -> void:
    _log(message, LogLevel.TRACE)

func debug(message: String) -> void:
    _log(message, LogLevel.DEBUG)

func info(message: String) -> void:
    _log(message, LogLevel.INFO)

func warning(message: String) -> void:
    _log(message, LogLevel.WARNING)
    push_warning(message)

func error(message: String) -> void:
    _log(message, LogLevel.ERROR)
    push_error(message)




