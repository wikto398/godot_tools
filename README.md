# Godot Tools

Tools and scripts shared across several of my Godot projects. This game consumes it as the
`godot_tools` **git submodule**.

Modules are plain GDScript classes with `class_name`, so they are available project-wide
without path imports; some are also registered as autoloads (see the game's
`project.godot`). A few ship interfaces intended to be implemented per project.

## Interfaces

| Module | Purpose |
|--------|---------|
| `ActionExecutorInterface` | Contract for executing an action in the environment (the game's `ActionExecutor` implements it) |
| `ObservationCollectorInterface` | Contract for building an observation from the environment |
| `SenderInterface` / `ReceiverInterface` | Contracts for sending observations / receiving actions; UDP implementations (`UDPSender`/`UDPReceiver`) are provided and used by the game |
| `InfoIconInterface`, `InfoPanelInterface`, `PopUpInterface` | UI contracts for hover/panel/popup widgets |

## Communication

| Module | Purpose |
|--------|---------|
| `EnvironmentConnector` | Bridges the game and the agent; picks a `Sender`/`Receiver` implementation |
| `SenderInterface/`, `ReceiverInterface/` | UDP-based transport implementations |
| `MessagePack` | MessagePack encode/decode helper |
| `ArgsParser` | Parses command-line arguments (used as an autoload) |

## Grids & pathing

| Module | Purpose |
|--------|---------|
| `Grids` | Grid abstractions — `Field`, `FieldGrid`, and `PointyHexGrid` (the game's `TerrainFieldGrid` extends `PointyHexGrid`) |
| `Pathing` | Pathfinding (A*, Dijkstra) over any `FieldGrid` |
| `PriorityQueue` | Priority queue used by pathfinding |

## State & behaviour

| Module | Purpose |
|--------|---------|
| `StateMachine` | Generic state machine with states, transitions and signals (`SignalStateMachine` is used by the game's `Builder`) |
| `Unit` | Base unit plus `StateMachineUnit` |
| `BehaviourTree` | Behaviour tree (`Selector`, `Sequence`, `Decorator`, `Action`) editable in the editor and saveable as a resource |
| `Condition` | Boolean condition combinators (`ANDCondition`, `ORCondition`) |

## Components & utilities

| Module | Purpose |
|--------|---------|
| `Component` / `Component2D` | Component base classes for attaching behaviour to entities |
| `DamageNumbers` | Floating damage-number display |
| `DebugLogger` | Leveled logging to console/file (used as an autoload) |
| `DotEnvReader` | Loads a `.env` file into the process environment |

## Used by this game

Verified consumers: `EnvironmentConnector` + `UDPSender`/`UDPReceiver` (wired in
`modules/MainGame/MainGame.tscn` and `autoload/RLCommunicator`), `SignalStateMachine`
(`modules/TurnUnit/Builder`), `PointyHexGrid` (via `TerrainFieldGrid`), `Pathing`, `Unit`,
`ArgsParser` and `DebugLogger` (autoloads).

## See also

- [`../AGENTS.md`](../AGENTS.md) — how the game wires these together
- [`../README.md`](../README.md) — the game
