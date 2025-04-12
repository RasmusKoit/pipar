# mouse-bite.pretty
Mouse bites KiCad footprints

Mouse bites on a PCB (Printed Circuit Board) are small, perforated tabs along the edges of the board, often used to allow multiple boards to be fabricated together in a single panel and then easily separated. These small holes are typically placed in a line along the edge where the board will be snapped apart, somewhat resembling the perforations on a postage stamp.

The main purpose of mouse bites is to simplify the manufacturing process by allowing multiple PCBs to be produced together and then separated by breaking them along the perforated lines. After separation, the edge where the mouse bites were located can sometimes have a rough finish, which may need to be filed down or sanded to ensure a smooth edge, especially if the PCB will be housed in a case.


<img  style="float: right;" src="https://github.com/AchimPieters/mouse-bite.pretty/blob/main/images/mouse.svg" width="140">


# How to use
* Download this repro
* Add the folder `mouse-bite.pretty` to your kicad project folder
* Open your project en select `PCB editor` 
* In the menu go to `Preferences` then `Manage Symbol libraries`
* Select `Project Specific Libraries`
* Click on the folder icon <img  style="float: right;" src="https://github.com/AchimPieters/mouse-bite.pretty/blob/main/images/folder.svg" width="30"> and select the `mouse-bite.pretty` folder and then `Open`
* In the `PCB editor` click the footprint icon <img  style="float: right;" src="https://github.com/AchimPieters/mouse-bite.pretty/blob/main/images/Footprint.svg" width="15"> and in the search field type `mouse`
* Select your mouse bite and add it to your design.
* Place the footprint on your pcb edge
* Connect the `Edge.Cuts` layer to the footprint
* draw the half circles on the `Edge.Cuts` layer

# MIT LICENCE

<img  style="float: right;" src="https://github.com/AchimPieters/mouse-bite.pretty/blob/main/images/MIT_SOFTWARE%20WHITE.svg" width="200">


<sup>Copyright © 2024 Studiopieters | Achim Pieters</sup>

<sup>Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:</sup>

<sup>The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software</sup>

<sup>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.</sup>
