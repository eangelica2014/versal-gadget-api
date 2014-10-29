---
id: authors-and-learners
title: Authors and learners
---

An **author** creates content in a course: drags gadgets into the lesson, then enters text, uploads images, selects questions for a quiz, etc. From the viewpoint of the gadget developer, the author _configures_ each of the gadgets in a lesson. The configuration for each gadget instance is stored in the **attributes** of that instance.

Each lesson may contain several **instances** of the same kind of gadget (for example, several image gadgets). Of course, each gadget instance has its own configuration and is independent of other gadget instances.

A **learner** can view the course content and interact with it, but cannot change the attributes configured by the author. Some gadgets may need to save the results of the learner's interaction with the gadget's UI (for example, save the last selected item). The Versal platform saves this information as the **learner's state**, which is separate for each learner and each gadget instance.

Typically, an author will first create an empty gadget in a lesson, edit the gadget's configuration, and then check the learner's view of the gadget. So each gadget should provide a consistent user experience both for authors and for learners.
