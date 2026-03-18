extends Node

var args: Array = []
var flags: Array = []
var kwargs: Dictionary = {}

func _ready() -> void:
    _parse_args()
    _print_parsed_args()

func _parse_args() -> void:
    var passed_args = OS.get_cmdline_args()
    var index = 0
    while index < passed_args.size():
        var arg = passed_args[index]
        if arg.begins_with("--"):
            if arg.contains("="):
                _parse_equality_args(arg)
            elif index + 1 < passed_args.size() && !passed_args[index + 1].begins_with("--"):
                _parse_value_args(arg, passed_args[index + 1])
                index += 1
            else:
                _parse_flag_args(arg)
        else:
            _parse_positional_args(arg)
        index += 1

func _print_parsed_args() -> void:
    DebugLogger.info("Positional Arguments: " + str(args))
    DebugLogger.info("Flags: " + str(flags))
    DebugLogger.info("Keyword Arguments: " + str(kwargs))

func _parse_equality_args(arg: String) -> void:
    var splitted_arg = arg.split("=")
    var key = splitted_arg[0].substr(2)
    var value = splitted_arg[1]
    DebugLogger.debug("Parsed argument - Key: " + key + ", Value: " + value)
    kwargs[key] = value

func _parse_flag_args(arg: String) -> void:
    var flag = arg.substr(2)
    DebugLogger.debug("Parsed flag argument: " + flag)
    flags.append(flag)

func _parse_value_args(arg: String, value: String) -> void:
    var key = arg.substr(2)
    DebugLogger.debug("Parsed value argument - Key: " + key + ", Value: " + value)
    kwargs[key] = value

func _parse_positional_args(arg: String) -> void:
    DebugLogger.debug("Parsed positional argument: " + arg)
    args.append(arg)

