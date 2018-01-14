# Collab

## TODOS
	
	- [X] First milestone
	- [ ] Second milestone
	- [ ] Third milestone
	- [ ] Ensure descentralization of the tool with blockchain. Perhaps [this](https://github.com/pixelspark/catena) library.

## Summary

This is a small project for educational purposes. It strikes me how difficult it is to collaborate in scientific environments, as each author usually has his own strict schedule and may not be able to respond timely while the team is working on a paper. This code is a small project to ameliorate that a bit. 

The intended functionality is so that an author will submit a paper written in pandoc markdown, his files will then be passed along to (assigned to) anonymous reviewers registered in a blockchain, which upon returning the document files with suggestions for corrections will be rewarded a certain cryptocurrency amount. The original author then receives the corrections, incorporates them as suggested or respond to the reviewers and will then be allowed to upload the final document to a second blockchain, where papers will be registered.

The above aim is not realistic to a sole programmer, thus I decided to write slowly towards milestones.

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

Reviewers should be indexed in a ~blockchain~ list. In this milestone some type of reviewer index will be added. This list should comprise email and specialty of the reviewer, files sent to the tool will be passed to reviewers with experience in the relevant area. The tool should then wait for a response in a fixed time frame. This response should be either accept, revision or rejection. If the first, the process is ended and a final file should be printed out (as .md file). In the second case, the file should be reviewed by the author and resent for follow-up of the original reviewer (again, fixed time frames), finally the third option also ends the process.

## Third milestone

Final publication should be uploaded to a blockchain. Perhaps start by using [catena](https://github.com/pixelspark/catena)?


## Language used

Right now it is a small Swift script, which is halfway to the first milestone. 