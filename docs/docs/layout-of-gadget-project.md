---
id: layout-of-gadget-project
title: Layout of a gadget project
---

The Versal platform provides a **course player** environment that loads the gadget in the context of a lesson, passes configuration data to the gadget, and receives learner's data from the gadget.

Presently, a gadget is developed as a Web app - that is, as an individual HTML document. The player will first load the gadget's root file, `versal.html`. Any JavaScript libraries or frameworks required by the gadget need to be loaded there by usual mechanisms supported by HTML5 (statically or asynchronously). The gadget's JavaScript code should be loaded and started from this `versal.html`.

In addition, each gadget must have an icon, `assets/icon.png`, and a `versal.json` that specifies the gadget's name, current version, the Versal user who developed it, and other data.

The command

    versal create test1

will create a new minimal gadget project in the subdirectory `test1`. The project will contain just three files, `versal.html`, `assets/icon.png`, and `versal.json`.

The layout of `versal.json` is clear from this example (see [versal.json](https://github.com/Versal/hello-world-gadget/blob/master/versal.json) ):

```
{
  "name": "hello-world",  // short name of gadget
  "version": "0.1.1",   // semantic version
  "title": "Hello, World",
  "description": "Demo gadget showing the basic API",
  "author": "versal",   // username on Versal.com
  "launcher": "iframe",  // specifies the gadget launcher, must be "iframe" for now
  "defaultConfig": {  // default set of attributes for the gadget
    "chosenColor" : "#00cc00",
    "chosenWord" : "green"
  },
  "defaultUserState": { // default learner state for the gadget
    "isBold": false
  }
}
```

The command `versal upload` needs to be run in the root of the gadget project directory. It will package _all_ files in the gadget project directory and upload them to the Versal platform. It is advisable to keep in this project directory only the files that are required for the gadget at run time. Put all other files (for example, Coffeescript source files, documentation, or other data) in some other directory, not under the gadget project directory.
