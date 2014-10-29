---
id: how-this-gadget-works
title: How this gadget works
---

The gadget uses the `player-api` module to interact with the Versal course player. There is only one attribute, `greeting`, and only one learner's attribute, `learnerName`. The listeners `on('attributesChanged')` and `on('learnerStateChanged')` will fire when the player sends these attributes to the gadget. When any of these values are modified, the gadget persists them by sending the messages `setAttribute` and `setLearnerAttribute` to the player API.

The message `editableChanged` is sent when the author toggles the editing mode on the gadget. In this simple gadget, it is sufficient to toggle the editable state on the `input` elements.
