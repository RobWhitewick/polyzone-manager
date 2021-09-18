Introduction

PManager is a tool that you can utilize for an easy check if a person is inside different polyzones. It also offers useful commands for developers when using polyzones. 

It offers support for all types of zones (excluding entity zones). Comments are included

The resource operates on ComboZones and the onPointInOutExhaustive function provided by the PolyZone dependency, making it vastly more efficient than using the isPointInside function on every zone.

PManager can also be modified to accept coords instead of the player's position. This allows you to replace bt-targets isPointInside functions and improve performance significantly when using multiple polyzones.

Key features	

More efficient compared to other methods (idle resmon of 0.01ms)
Allows multiple polyzone types (excl. entity zones) to be used simultaneously 
Check if the player is inside multiple polyzones using one function.
Config options for triggering events on entering and exiting
Debug commands (printInfo, prints upon entry-exit and comboDraw)
Dynamic creation and deletion of polyzones on the fly



Dependencies
PolyZone dependency can be found here https://github.com/mkafrin/PolyZone
