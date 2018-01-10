import VerbalExpressions // marathon: https://github.com/lf-araujo/SwiftVerEx.git
import Yaml // marathon: https://github.com/behrang/YamlSwift.git
import Files // marathon: https://github.com/JohnSundell/Files.git
import Foundation

/* 
    TODOs

    - [X] If @email.com, then unshuffle

    ---
    
    This is a marathon swift script / swift code that can be used to shuffle 
    authors, anonymizing  them so to allow emailing the other participants
    with their colleagues material. This is a quasi-peer-review tool for use
    in graduate level.

    The requirement is the use of pandoc's markdown as the document type, with
    a .md extension.

    At this point of development, it anonymizes the md files, renames them with 
    the email of another student (taken from any other of the md files in
    the same directory). The rest of the process is manual, ie, I have to 
    on forward to the student, then receive the response and pass along to the
    original author.

    This is where I am in development now. The tool should check for files with
    @email.com format, which means it is time to unshuffle, so I can return to
    author.

    Some conventions:

    1. Author: the student who uploaded the original;
    2. Reviewer: whoever is making suggestions in a text that is not his own.

*/

extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }

        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(Int(random() % numericCast(unshuffledCount) ))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

extension Dictionary where Value: Equatable {
    func allKeys(forValue val: Value) -> [Key] {
        return self.filter { $1 == val }.map { $0.0 }
    }
}


func original() {
    var email: String = ""
    var document: [String] = []
    var emaillist: [String] = []

    for file in Folder.current.files {
        guard file.extension == "md" else {
            continue
        }
 
        let content = try! file.readAsString()
        let pattern = "(?s)(?<=---).*(?=---)"
        if let range = content.range(of: pattern, options: .regularExpression) {
            let text = String(content[range])
            let value = try! Yaml.load(text)
            email = value["email"].string!
            let author = value["author"].string!
            let emailline = "email: " + email
            let authorline = "author: " + author
            var anonymcontent = content.replacingOccurrences(of: "\n\(emailline)", with: "\nemail: ")
            anonymcontent = anonymcontent.replacingOccurrences(of: "\n\(authorline)", with: "\nauthor: ")

            document.append(anonymcontent)
        }

        
        emaillist.append(email)
    }

    emaillist = emaillist.shuffled()


    for (index, file) in Folder.current.files.enumerated() {
        guard file.extension == "md" else {
            continue
        }

        let outfile = try! Folder.current.createFile(named: emaillist[index])
        try! outfile.write(string: document[index])
    } 
}


func edited() {
    var originalpairs: [String: String] = [:]
    var email: String = ""
    var author: String = ""
    var document: [String] = []
    
    // listing the original pairs
    for  file in Folder.current.files {
        guard file.extension == "md" else {
            continue
        }
 
        let content = try! file.readAsString()
        let pattern = "(?s)(?<=---).*(?=---)"
        if let range = content.range(of: pattern, options: .regularExpression) {
            let text = String(content[range])
            let value = try! Yaml.load(text)
            email = value["email"].string!
            author = value["author"].string!
        }   
        originalpairs[author] = email
    }

    // reverting shuffle
    for file in Folder.current.files {
        guard file.name.contains("@") && !file.name.contains("edited_") else {
            continue
        }

        let content = try! file.readAsString()
        let pattern = "(?s)(?<=---).*(?=---)"
        if let range = content.range(of: pattern, options: .regularExpression) {
            let text = String(content[range])
            let value = try! Yaml.load(text)
            email = file.name
            // the following is a bit tricky, it is reducing a dict into string with .reduce()
            author = originalpairs.allKeys(forValue: email).reduce("") { $0 + String($1) }
            var editedcontent = text.replacingOccurrences(of: "email: ", with: "email: \(email)")
            editedcontent = editedcontent.replacingOccurrences(of: "author: ", with: "author: \(author)")
            editedcontent = content.replacingOccurrences(of: text, with: editedcontent)

            let outfile = try! Folder.current.createFile(named: "edited_\(email)")
            try! outfile.write(string: editedcontent)
        }   

    }
}


let pattern = VerEx().any("@")
var allfiles: String = ""

for file in  Folder.current.files {
    allfiles += file.name
}

if pattern.test(allfiles) {
    edited()
} else {
    original()
}
