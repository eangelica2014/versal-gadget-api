---
id: deploying-gadget
title: Deploying a gadget
---

After you create the HTML and JS files for your gadget, you will want to test your gadget visually and then upload it.

### The deployment cycle

* Test the gadget locally on your development machine
* Deploy the gadget in a "sandbox" on Versal.com
* Create a course that uses your gadget
* Develop, test, and deploy an updated version of the gadget
* Update the gadget in the course(s) using it

### Testing locally

Go to the gadget directory (where `versal.json` is located) and run the command

```
versal preview
```

This command starts a local HTTP server on port 3000. Open the URL [localhost:3000](http://localhost:3000) in a browser. You will see an empty lesson page and your gadget's icon in the bottom tray. Double-click on the gadget icon to insert the gadget into the lesson. This is how a course author will start using your gadget in a new course. You can now interact with your gadget, both as a course author and as a learner. (Click the "cogwheel" icon to toggle gadget editing.)

Pro tip: While this local HTTP server is running, you can continue changing the gadget's code. Just refresh the browser to see the changes live! (Except if you change `versal.json` then you need to restart `versal preview` to see the changes.)

### Deploying in sandbox

If you haven't yet deployed your gadget, make sure that you sign in to Versal:

```
versal signin
```

Go to the gadget directory and run the command

```
versal upload
```

The gadget will be uploaded to the Versal platform. However, this gadget is uploaded in a "sandbox". It is not yet approved for the entire world to see, and will be visible only in courses authored by yourself.

**WARNING: There are size restrictions in place when uploading gadgets. To exclude development resources and other extraneous files add their paths to a file in the root of your gadget project called `.versalignore` (works like `.gitignore`).

### Inserting a gadget into a course

Go to [versal.com](http://versal.com). You will need to authenticate; ask us for details. Sign in to `versal.com` and create a new course. After you start editing the new course, click on the "Sandbox" tray in the bottom; you should see your new gadget available. Drag your gadget into the lesson to start using it.

### Updating a published gadget

To update a published gadget, you need to do two things:

1. Change the gadget version upwards (e.g. from `0.1.3` to `0.1.4`) in `versal.json`
2. Upload the gadget again (`versal upload`) and request approval

Suppose you already created some courses that use your gadget version `0.1.3`, and now you published an updated version `0.1.4`. When you do this, the courses do not automatically start using the updated version. To avoid breaking the existing courses, all older gadget versions will be preserved by the platform. The course authors need to agree explicitly to upgrade your gadget to a new version.

Go to the course you created where your gadget has been used. Click on the "Sandbox" tray and you will see that your gadget's icon has a band on it, indicating that an upgrade is available. Click on the band and confirm the upgrade to a new version.
