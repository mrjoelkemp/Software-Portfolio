Author: Joel Kemp
Created: Fall, 2008
Purpose: AirBattles was supposed to be a PC-based, 3D Airplane shooter. 

Details:

The game was built using MS Visual Studio 2005, C++, the Irrlicht 1.4 Rendering engine, and subversion.
 
The game was used as the first project for the CCNY Chapter's ACM Game Development Special Interest Group, created and led by me. The group's purpose was to give undergraduates an opportunity to break into the difficult field of game development. 

Unfortunately, it was difficult to find students who were willing to put in the hours to make progress. I ended up using the project as an experiment in OOD, further exploring new ways to design a reusable architecture. With that said, the actual gameplay is severely lacking: only having a plane flying around in 3D space with a rendered terrain and some fireballs shot by the spacebar button.

The project is not without faults. In particular, the Airplane subclasses should not have been separate classes. A better design is to have a single Airplane class that loads the aircraft-specific attributes from an XML file. This way, it's not only easy to create new aircraft for inclusion, but makes tweaking of the aircraft properties not require a rebuilding of the system. 

The architecture has a lot of room for improvement, but the current state is as I left it years ago.