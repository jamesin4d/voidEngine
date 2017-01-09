# voidEngine
Integrating libraries i've been working on for use in project: void voyagers
src/ contains the code

src/components contains component objects
src/entities contains entity factory functions
src/systems contains systems for manipulating component data

src/physics contains code for collision detection incorperating ECS; heavily influenced by bump.lua, heavily modified as well. not finished

src/lvl contains "levels" states; may or may not be removed

src/lib contains various libraries:
lib/encos - minimal entity component library
lib/fms - finite state machine; state.switch()
lib/microem - minimal event:emit/listen manager 
lib/soil - Simple Objects Implemented Lightly; 29 line oop library.
