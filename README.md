# Collab

## TODOS
	
	- [ ] Unscramble the files 

## Summary

This is a small project for educational purposes. It strikes me how difficult it is to collaborate in scientific environments, as each author usually has his own strict schedule and may not be able to respond timely while the team is working on a paper. This code is a small project to amelirate that a bit. 

The aim is to create a complete publication system and a reviewer's list. The intended functionality is so that an author will submit a paper written in pandoc markdown, his files will then be passed along  to (assigned to) anonymous reviewers registered in a blockchain, which upon returning the document files with suggestions for corrections will be rewarded a certain cryptocurrency amount. The original author then receives the corrections, incorporates them as suggested or respond to the reviewers and will then be allowed to upload the final document to a second blockchain, where papers will be registered.

The above final aim is not realistic to a sole programmer, thus I decided to write slowly towards milestones.

## First milestone


Small script that will crawl through md files in the same directory, extracting the identity of the authors and passing the text on to other author in one of the other texts. Each participant is both original author and reviewer for the work of other person in the pool. This is intended to be used in a graduate level course as a way to train students on being effective as critics of their colleague's materials, albeit maintaining anonymity as much as possible. The odd case should be left to the monitor (me).

It is also where I am at the moment. The code is a Swift [marathon](https://github.com/JohnSundell/Marathon) script all text (.md) files in a given directory, scrambles them, and anonymises them.

### Running it

- Place some .md files in a directory, these must have a yaml header with an `author:` variable
- Download the script either with github (git clone https://github.com/lf-araujo/collab)
- Make it executable: `chmod +x collab.swift`
- Run it either with `./collab.swift` or directly from github with  `marathon run lf-araujo/collab`
- New files will be created in the same directory without the `author:` yaml variable

## Second milestone

Reviewers should be indexed in a blockchain.

## Third milestone

Final publication should be uploaded to a second blockchain.


## Language used

Right now it is a small Swift script, which is halfway to the first milestone. 