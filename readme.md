# iCEasy

## icestorm examples for both the iCEStick and iCE40-HX8K Breakout Board.

The point of this is to provide an easy way to get started playing with verilog on real hardware, and to provide somewhat of a cheat sheet for newcomers to git at the same time. The git stuff here was added because of [this phenomenon](https://xkcd.com/1597/).

The .v files are verilog, and the .pcf files are "placement constraint files" used to assign named ports in the verilog top level entity to actual pins on the relevant chip, among other things.

Requires [Icestorm](https://github.com/cliffordwolf/icestorm) installed on an Ubuntu 14.04 LTS system.

## To use:

Attach your iCEStick or iCE40-HX8K Breakout Board to your PC^[Although - only one at a time please!], then run:

    make 1k
    
for the iCEStick
or

    make 8k
    
for the 8k breakout board.

You'll need to enter your sudo passwd when prompted, as this assumes you don't have user permissions set to allow you to play with the /dev/ttyUSB* ports otherwise.

The Makefile will complete a full compilation of the associated verilog, *and flash the result to the board's eeprom* within about 10 seconds^[As tested on my slow e3 Xeon, anyway. Don't hold your breath if you're running on a RasPi!].
Thereafter, the LED's should flash in a sequence which probably won't repeat for a very long time.

By default it will delete the intermediary files and leave you with a clean directory when completed.


To play with verilog on your dev board, please run:

    git checkout -b some-branch-name-of-your-choice--name-it-by-what-you-want-it-to-do
    

And then simply edit/save your example-nk.v file and re-run make nk^[Where 'n' is 1 or 8.].

When you're pleased with the result, and want to locally save a checkpoint of your work in git:

    git add example-nk.v
    git commit -m "This is really easy"
    
    
If you want to wipe out your changes and start afresh with the most recent version in git, do:

    git checkout -- example-nk.v
    
Which will replace that file with the last "known good" one you left.


If you want to start a new branch from the master, do:

    git checkout master
   
and then make yourself another new branch from there. Beware that if you haven't either commited or "stashed" changes, they will be lost.

You can also make new branches from your branches in the obvious way, ie, without the `git checkout master`.

If you want to merge your branchs together, use `git checkout "keeper"` to select the branch you want to merge to, and then use `git merge "otherbranch"`. This is also how you pull your changes back into master.

Use `git status` to see where you're at with git, including tracked files, untracked files, and what branch you're on.

If you want to jump between branches without necessarily doing a `commit` of your half-done and broken code, but you still don't want your work clobbered; use `git stash` to temporarily save your uncompleted work where you can later `git stash pop` it back. Whilst your stuff is stashed you may then safely "checkout" to other branches without accidentally overwriting your unfinished work.

This should be enough to make you dangerous :) 

Good luck!
