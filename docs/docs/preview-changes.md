---
id: preview-changes
title: Make and preview changes
---

While the preview is running, let us examine the gadget code in `versal.html`. It is self-contained and consists of a simple CSS style sheet and a small JavaScript snippet:

```javascript
<script>
var greeting = document.querySelector('[name=greeting]');
var learnerName = document.querySelector('[name=learnerName]');
var player = new VersalPlayerAPI();

greeting.addEventListener('change', function(e){
  player.setAttribute(greeting.name, greeting.value);
});

learnerName.addEventListener('change', function(e){
  player.setLearnerAttribute(learnerName.name, learnerName.value);
});

player.on('attributesChanged', function(data){
  if(data.greeting) {
    greeting.value = data.greeting;
  };
});

player.on('learnerStateChanged', function(data){
  if(data.learnerName) {
    learnerName.value = data.learnerName;
  };
});

player.on('editableChanged', function(editable){
  greeting.readOnly = !editable.editable;
  learnerName.readOnly = editable.editable;
});

player.setHeight(60);
player.startListening();
</script>
```

Let's set a background color on the gadget. Add these lines to the `<style>` tag in `versal.html`:

      body {
        background-color: #def;
      }

Now reload the browser window where you opened the preview. You will see the changed gadget:

![lesson with changed gadget](images/my-gadget-2.png "Lesson with changed gadget")

In this way, you can preview your new gadget code as you are developing it.
