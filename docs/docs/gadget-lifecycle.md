---
id: gadget-lifecycle
title: The gadget lifecycle
---

### Gadget/player messaging

The player communicates with the gadget through a `postMessage`-based message bus. The recommended way is to use the `player-api` module, which hides the low-level details of `postMessage` communication. If you wish you may consult the detailed documentation about the [gadget messaging API](https://github.com/Versal/versal-gadget-launchers/blob/master/iframe-launcher/README.md). However, the [player-api module](https://github.com/Versal/versal-gadget-api/blob/master/README.md#versal-player-apijs) is more convenient and sufficient for all purposes.

### Installation of `player-api`

This module is part of the Versal gadget API. Include this as a Bower dependency:

    bower install --save versal-gadget-api

If you are using Web components, include the `player-api` into your main HTML document like this:

    <link rel="import" href="bower_components/versal-gadget-api/versal-gadget-api.html">

The recommended way of using Web components is to include this polyfill,

    bower install --save versal-component-runtime

If you are not using Web components, include these files:

    <script src="bower_components/eventEmitter/EventEmitter.js"></script>
    <script src="bower_components/versal-gadget-api/versal-player-api.js"></script>

### Sending and receiving messages

When your gadget code is loaded, create a new `player-api` object:

    var playerApi = new VersalPlayerAPI();

To receive messages from the player, add a listener to the player object, for example like this:

    playerApi.on('attributesChanged', function(attrs){
      // do something
    });

To send messages to the player, call a method on the `player-api` object, for example:

    // send this command to receive initial events
    playerApi.startListening();

The supported messages and their JSON formats are documented in the repository [Versal/versal-gadget-api](https://github.com/Versal/versal-gadget-api/blob/master/README.md#versal-player-apijs). Here we will describe how gadgets use these messages to communicate with the player.

### Gadget configuration

When the gadget code is first loaded, the gadget is not yet attached to a DOM node in the lesson document. At this point, the gadget should initialize itself, so that it is ready to receive its current configuration data. Then the gadget should send the player a `startListening` message. The player will respond by sending messages that give the gadget its configuration data.

Keep in mind that the Versal platform expects the same gadget code to implement the learner's UX and the additional editing UX.
To aid this separation of concerns, the gadget configuration data has two main parts: the gadget's **attributes** and the gadget's **learner state**.

The attributes are parameters of the gadget instance that are configured by the course author, globally for all learners. The learner state describes the result of each particular learner's last interaction with the gadget.

For example, the attributes of a quiz gadget may describe the quiz title, the text of each question, and the correct answers. The learner state of a quiz gadget may describe the answers last selected by the learner when submitting the quiz for evaluation.

As another example, consider the standard Versal image gadget. The attributes of the image gadget describe the image caption text and the asset information for the uploaded image. The learner state is empty, since the image gadget is not interactive.

Each gadget instance’s learner state is associated with the particular signed-in Versal user (who may or may not have authoring rights to the gadget).
When editing the gadget, the author changes the gadget's attributes, while the learner state can only be changed by a learner. That learner may happen to be the same person as the course author, since all authors are learners by virtue of being authenticated Versal users. But other learners cannot change the gadget's attributes.

How does the gadget receive its configuration data? After the gadget sends the message `startListening` to the player, the player will post a series of `attributesChanged` and/or `learnerStateChanged` messages to the gadget. These messages carry the attributes and the learner state for the gadget.

The configuration data always consists of a set of attributes - each attribute being a key-value pair. As an example, the attributes for the "French word gallery" gadget might contain an array, such as

```
{ words:
  [
     { imageId : "a7c3fb", word : "soupçon" },
     { imageId : "4cb834", word : "parapluie" },
     { imageId : "7ad20c", word : "gants" }
  ]
}
```

while the learner state may be just a single attribute, say `{index: 1}`, storing the index of the word last viewed by the learner. As a developer, you are free to organize your data structures as you see fit.

The gadget may also receive an `editableChanged` message that indicates whether an author has started editing the gadget.

The gadget code must always react to these messages by adjusting its UI and/or by storing the state internally. For example, the `editableChanged` message can come at any time (as the author toggles editing on and off). The same holds for `attributesChanged` and `learnerStateChanged`.

### Initial visual state

At the initialization stage, the gadget may also post the messages `setEmpty`, `setHeight`, `watchBodyHeight`, and `setPropertySheetAttributes` to the player API. These messages will configure some visual aspects of the gadget that are provided by the Versal platform.

The `setEmpty` message is relevant when editing; it tells the player to display a gadget placeholder indicating that the gadget is empty and cannot yet show any useful content. The author will see right away that the gadget still needs to be configured. For instance, an image still needs to be uploaded, or other content needs to be configured, before the gadget can show anything. Here is how an empty gadget looks:

![empty gadget](images/empty_gadget.png "Empty gadget")

The `setHeight` message specifies the desired pixel height of the gadget's iframe. The width of the iframe is fixed, equal to the total width of the lesson window. (In the Web browser, this is 724 px, but it can be different on other platforms).

The `watchBodyHeight` message specifies that the gadget's iframe should dynamically track the actual height of the content of the gadget's `body` element.

The `setPropertySheetAttributes` message will declare the types and the names of the attributes displayed in the gadget's **property sheet**. This is a simple UI provided by the Versal player, which allows the author to configure some parameters of the gadget. (See below for more details.)

### Persisting the attributes and the learner state

The Versal platform will persist the gadget's attributes and learner state if the gadget sends the messages `setAttributes` and `setLearnerState` to the player.

In principle, a gadget can create its own author's UI for editing the attributes. It is convenient to use **property sheets** for simple attributes such as text, numbers, or checkboxes. The property sheet is implemented by the Versal player and is toggled through the "cogwheel" icon in the Versal player.

The Versal player will automatically persist all attributes defined on the property sheet. When the author changes any values in the property sheet, the gadget will receive an `attributesChanged` message and can react to it normally.

### Property sheets

Property sheets automatically specify titles for the data attributes. The `setPropertySheetAttributes` message specifies all titles and types of the attributes. Presently the player supports the following data types in property sheets:

* `Text`, `Number`, `TextArea`, `Checkbox`, `Color`: these types need no options.

Example: `{ type: 'TextArea' }`

*   `Checkboxes`, `Radio`, `Select`: these types take an array of `options`, representing the possible selection items. The `Select` type is a drop-down listbox.

Example: `{ type: 'Radio', options : ['Green', 'Yellow', 'Red' ] }`

*      `Date`, a date picker

Example: `{ type: 'Date', yearStart: 1990, yearEnd : 2038 }`

*      `DateTime`, a date/time picker

Example: `{ type: 'Datetime', 'yearStart : 1990, yearEnd : 2038, minsInterval : 60 }`

*      `Range`, a slider with a given range and step

Example: `{ type: 'Range', min: 100, max: 200, step: 10 }`

*      `Tags`, a selection of user-supplied tags

Example:

```
{ type : 'Tags',
  options: ['music', 'movies', 'study', 'family', 'pets'],
  lowercase: true,
  duplicates: false,
  minLength: 3,
  maxLength: 20,
  updateAutoComplete: true
}
```

Here is an example property sheet, showing a slider for a numerical value ("number of words") and a drop-down selection box ("chosen author"):

![property sheet](images/property_sheet_1.png "Property sheet")

The property sheet in this screenshot was configured by the following message:

```
playerApi.setPropertySheetAttributes({
     numberOfWords:  { type: 'Range', min: 100, max: 500, step: 20 },
     chosenAuthor: { type: 'Select',
                      options: ['Shakespeare', 'Hegel', 'Dickens', 'Lao Tzu']
                   }
})
```

If the property sheets are not powerful enough for configuring your gadget, you can implement your own custom UI for the gadget editing. Your gadget should call `setAttributes` whenever you need to persist some changed attributes.

There is no property sheet option for the learner state. Call `setLearnerState` to persist any changes.

### Assets

If your gadget displays images, the author must somehow provide these images when creating the lesson. The Versal platform allows the author to upload images and videos directly through the **asset** API.

The gadget asks the user to upload a new asset like this:

```
playerApi.requestAsset({
    attribute: 'myImage',
    type: 'image'
})
```

Possible asset types are `image` and `video`. The `attribute` field specifies the name of the gadget's attribute that will hold the asset information.

Upon a `requestAsset` message, the player displays a UI for uploading an asset (an image or a video). After a successful upload, the player will create a new asset ID string for the uploaded asset. The new asset ID will be set to the attribute with the given name. So the player will post a message `attributesChanged` to the gadget. The new value of the attribute `myImage` could be, for example, this:

```
  myImage: {
      id: 'a73cb21...",
      representations: [
        { id: '65bb32...',
          scale: '800x600',
          contentType: 'image/png',
          original: false,
          available: true
        }, ...
      ]
    }
```

A Versal asset contains an array of `representations`. Each element of that array describes an image or a video, which may have been scaled down to a smaller size. One of the representations is tagged as `original:true`; this is the one that has not been scaled down.  (If you upload a small image, it will not be scaled down, and so there will be only one "representation", which will be `original`.)

All uploaded assets are automatically processed (and scaled down if necessary) by the Versal platform. The resulting representations are stored in remote URLs. To display the image, you must formulate a valid URL by rendering a provided "url template" with the representation's ID. The template is delivered to the gadget via the [`environmentChanged`](https://github.com/Versal/versal-gadget-launchers/blob/master/iframe-launcher/README.md#environmentchanged) message. The template will be similar to `//static.versal.com/restapi/assets/<%= id %>` which can be rendered by replacing the substition section at the end of the template with the desired representation Id. For example you can get full URLs like this:

```
var url = playerApi.assetUrl(assetId);
/* now set img src to this url */
```

The gadget can now use this URL to set the `img src=...` tag or to display a video player.
