# Godot Tools

Repository for tools and scripts that are used across multiple of my Godot projects.

## Most important tools: 
### ActionExecutorInterface
Interface for executing actions. This is used in the `ActionExecutor` node, which can be used for RL agents to execute actions in the environment. The `ActionExecutorInterface` allows for a clean separation of concerns, as the `ActionExecutor` node can be used with any implementation of the `ActionExecutorInterface`.

### ArgsParser
Utility for parsing command line arguments. 

### BehaviourTree
Implementation of a behaviour tree. Consists of usual nodes such as 'Selector', 'Sequence', 'Decorator', and 'Action'. Made so that it can be easily created and edited in the Godot editor with option to be saved as a resource. 

### DebugLogger
Utility for logging debug messages. Can be used to log messages to the console or to a file. Can be configured to log messages of different levels (e.g. info, warning, error).

### EnvironmentConnector
Used as a connection between the game itself and agent. Can utilize different communication methods based on the implementation of the `Sender` and `Receiver` interfaces. 

### Grids
Implementation of grids. Currently hex-based flat-topped grid is fully implemented.

### Pathing
Implementation of pathfinding algorithms. This includes A* and Dijkstra's algorithm. Should work on all grids extending "FieldGrid" class. 

### StateMachine
Implementation of a state machine. Consists of states and transitions.

### PriorityQueue
Implementation of a priority queue. Used in pathfinding algorithms.

### Sender and Receiver interfaces
Interfaces for sending observations and receiving actions. Used in the `EnvironmentConnector` node to send observations from the environment to the agent and receive actions from the agent to execute in the environment.
Currently only udp-based implementations are available, but the interfaces allow for easy implementation of other communication methods (e.g. shared memory, sockets, etc.).
