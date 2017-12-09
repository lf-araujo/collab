# Collab

## TODOS
	
## Summary

This is a small project for educational purposes. It strikes me how difficult it is to collaborate in scientific environments, each author has their own strict schedule and may not be able to respond timely. This code is a small personal project to amelirate that a bit. 

The aim is to create a complete publication system and a reviewer's list. The intended functionality is so that an author will submit a paper written in pandoc markdown, his files will then be passed along to anonymous reviewers registered in a blockchain, which upon returning the document files with suggestions for corrections will be rewarded a certain bitcoin amount. The original author then receives the corrections, incorporates them as suggested or respond to the reviewers and will then be allowed to upload the final document to a second blockchain, where papers will be registered.

The above final aim is not realistic to a sole writer, thus I decided to write slowly towards milestones.

## First milestone


Small script that will crawl through md files in the same directory, extracting the identity of the authors and passing the text on to other author in one of the other texts. Each participant is both original author and reviewer for the work of other person in the pool. This is intended to be used in a graduate level course as a way to train students on being effective as critics of their colleague's materials, albeit mainaining anonymity as much as possible. The odd case should be left to the monitor (me).

## Second milestone

Reviewers should be indexed in a blockchain.

## Third milestone

Final publication should be uploaded to a second blockchain.


## Language used

Right now it is a small Swift script, which is halfway to the first milestone. 