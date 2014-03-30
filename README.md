Diablo 3 Hero Viewer
=

A simple Application to view an inputted BattleID's Diablo 3 heroes and their respective statistics. Implemented using a remote call to blizzard's now OUTDATED Diablo 3 Api found here: http://blizzard.github.io/d3-api-docs/. Created soley for learning purposes and all images used belong to Blizzard.

**For Testing:**  
Tag : SgtWaffles  
ID  : 1928

Explored:
=
- Using Remote APIS / HTTPGets
- Segues and Navigation Controllers
- UIActivity Indicators
- Customizing Cells
- JSON Parsing
- http://www.paintcodeapp.com/

Mistakes:
=
- UITableViewControllers generally only allows control of the table view, and as such trying to add activity indicators and options bars in an elegant manor seems impossible.
- Next time, use a single UIView with subviews to add features mentioned above.
- Abstraction of URLS and Data not elegant
- Error Handling not concrete

Screenshots
=

![alt tag](http://puu.sh/7PDlH/16be004704.jpg)  
![alt tag](http://puu.sh/7PN08/adb9e61be0.jpg)
![alt tag](http://puu.sh/7PN5b/a33d650477.png)
