# Simple Adventure Status Tracking.

## To Start:

* ```/lua run sast``` Defaults to DanNet
* ```/lua run sast eqbc``` Sets EQBC as the group command 
* ```/lua run sast dannet``` Sets DanNet as the group command
* ```/lua run solo``` Won't send any group commands to close window. useful if you just want to run this on each character.

## Description

* Only shows when in an Adventure, or have an active Expedition
* Auto Closes the Window in game across all characters if opened outside of the script every 5 seconds.
  * ie. first getting adventure or after zoning.
* Help Icon Tooltip will display Quest Information
* Clicking on the Help Icon will toggle ingame Window. no auto close
* Defaults to DanNet for communication to group, but checks for EQBC and switches if detected running.
* Added Expedition status

## Images:

Time to Enter:

<img width="181" alt="image" src="https://github.com/grimmier378/adventuretime/assets/124466615/57fa3e73-9d42-4c1c-86a7-07040bc74c1f">

Time to Complete:

<img width="184" alt="image" src="https://github.com/grimmier378/adventuretime/assets/124466615/4bbb8719-9f6c-434a-9b0e-8b0eed2e70a0">

ToolTip

<img width="194" alt="image" src="https://github.com/grimmier378/adventuretime/assets/124466615/a395d748-0330-41a7-be01-2eebbef57929">

Lock Window:

* Lock Icon will always only appear on the top row.
  
![image](https://github.com/grimmier378/sast/assets/124466615/197ff8ab-cbd5-4e5a-be9b-00c1a5f296de)
