---
id: gadget-development-workflow
title: Gadget development workflow
---

### Summary

To ensure gadget code quality all code goes through code review. Our workflow is similar to 
[github flow](http://scottchacon.com/2011/08/31/github-flow.html) where we create feature branches off of `master` and generate pull requests that are reviewed then merged back into `master`.

### Starting a project

A Versal engineer will create a repo for you. If you're starting with a pre-existing codebase or have already developed part of the gadget before this happens create an empty master branch and create a pull request on Github for someone to review your initial work. The steps for doing this are listed in the next section.

### Workflow steps

In a nutshell the flow works like this ([adapted from github-flow](http://scottchacon.com/2011/08/31/github-flow.html)):

* the `master` branch is always tested, reviewed and production ready code
* to work on something new, create a descriptively named branch off of master (e.g. feature/shuffle-deck or bugfix/timing)
* commit to that branch locally and regularly push your work to the same named branch on the server
* when you need feedback or help, or you think the branch is ready for merging, open a pull request and assign a Versal engineer
* after they have reviewed the code and tested the feature they will merge it into master and published

### Guidelines

#### Testing

We strongly encourage automated tests but many UI interactions and scenarios have to be tested manually across all the browsers Versal supports. Generally gadgets need to support the following browsers and all pull requests should be tested by both the developer and reviewer before submitting/merging:

* Chrome on Mac and windows
* Firefox on Mac and windows
* IE 11
* Safari on Mac

#### Style

See [Github](https://github.com/styleguide) and [Airbnb](https://github.com/airbnb/javascript) style guides for good style.

#### Name your branch sensibly

New features belong in new branches. Push your changes appropriately:

    $ git checkout -b feature/my-new-feature
    $ git push origin feature/my-new-feature

Our unenforced convention is to prefix each branch with some indication of its content:

  * `feature/branch`: a new feature
  * `fix/branch`: a fix for an outstanding (but non-critical) issue
  * `hotfix/branch`: an urgent fix for a prod issue

#### Don't force push

Generally don't use git's force push feature. Force pushing to a feature branch while you work on it is actually OK but should be done sparingly and with great care. Either know how [`push.default`](http://stackoverflow.com/questions/13148066/warning-push-default-is-unset-its-implicit-value-is-changing-in-git-2-0) works or specify an origin and branch while pushing.

#### Create small, meaningful commits

Each time you make a meaningful change or add code create a commit with a descriptive commit message. Ideally the person who reviews your code can look at each commit and know the entire store of how the feature was made or the bug was fixed.

#### Squash ugly commits

`git rebase -i` is a really great tool. Get to know it, and turn an ugly commit history into a beautiful one before submitting a PR.

#### Include an issue number

Your commit message or the pull request description should contain a Jira or Github issue number so the person reviewing it can find specification and/or conversations relating to the pull request. 

#### Provide context

Provide enough context for the reviewer. Assume they don't know anything about the issue before coming across your request (they might not). If there's an issue you're fixing link to it. If the commit history itself doesn't tell the full story story well enough add a couple sentences explaining it.
