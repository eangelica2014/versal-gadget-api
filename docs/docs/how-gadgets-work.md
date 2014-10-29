---
id: how-gadgets-work
title: How gadgets work
---

A gadget is a single-page app that lives inside an `iframe`. The `iframe` for each gadget will be created automatically by the Versal player whenever a lesson is loaded.

The gadget communicates with the course player via events sent over a `postMessage` based event bus. Gadgets use this API to perform four basic functions:

* get and set persistent gadget configuration data: the attributes (configured by the course author) and the learner state (for each learner)
* let the authors upload images and videos to the Versal platform
* use some standard visual features of the Versal course player ("empty gadget" and "gadget error" views, property sheets, and asset upload dialog)
* store question/answer data and perform scoring (for quizzes and other challenges)

More details about the lifecycle of the gadget are found in the **Reference guide**

It is recommended for gadget developers to use `player-api`, which is a convenience library that hides the need for `postMessage` and provides some other useful functions (see below).
