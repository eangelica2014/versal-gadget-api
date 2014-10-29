---
id: add-configurable-color
title: Add a configurable color
---

Let's add a new feature to the gadget, so that the author can set the background color. The color will be stored as a new attribute `bodyColor` in the gadget configuration.

To let the gadget author edit the color, we use a **property sheet**. This is a feature of the player that is convenient for editing simple attributes.

We need to make only two changes to the gadget code:

1. Configure the property sheet
2. Set the background color on `attributesChanged`

To configure the property sheet, we just need to add a call to the player API (anywhere after creating the `player` object):

```
player.setPropertySheetAttributes({
     bodyColor:  { type: 'Color'}
});
```

To set the background color, we modify the `attributesChanged` handler like this:

```
player.on('attributesChanged', function(data){
  if(data.greeting) {
    greeting.value = data.greeting;
  }
  if (data.bodyColor) {
    document.querySelector('body').style.background = data.bodyColor;
  }
});
```

Now reload the browser window with the gadget. Click on the cogwheel icon to open the property sheet. You can now select a color:


![lesson with colored gadget](images/my-gadget-3.png "Lesson with colored gadget")
