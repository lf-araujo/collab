import Yaml // marathon: https://github.com/behrang/YamlSwift.git
import Files // marathon:https://github.com/JohnSundell/Files.git
import Foundation

/* 
    - [ ]  identificar cada artigo com número único
    - [X]  remover email
    - [ ] registrar o email em um documento (isso é preciso para a parte II)
    - [X] encontrar suma forma de mostrar qual o email o arquivo deve ser enviado
        provavelmente renomeando cada artigo com o email para o qual ele
        deve ser encaminhado?
    - [ ] Parte II. Retornar o arquivo corrigido para o autor original
*/

extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }

        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(Int(random() % numericCast(unshuffledCount) + 1 ))
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


var email: String = ""
var document: [String] = []
var emaillist:[String] = []
var filelist:[String] = []

for file in Folder.current.files {
    guard file.extension == "md" else {
        continue
    }

    let content = try file.readAsString()
    let pattern = "(?s)(?<=---).*(?=---)"
    if let range = content.range(of: pattern, options: .regularExpression) {
        let text = String(content[range])
        let value = try! Yaml.load(text)
        email = value["email"].string!
        let author = value["author"].string!
        let emailline = "email: " + email
        let authorline = "author: " + author
        var anonymcontent = content.replacingOccurrences(of: "\n\(emailline)", with: "")
        anonymcontent = anonymcontent.replacingOccurrences(of: "\n\(authorline)", with: "")

        document.append(anonymcontent)
    }

    
    emaillist.append(email)
    filelist.append(file.name)

}


emaillist = emaillist.map(String.init).shuffled()
document = document.map(String.init).shuffled()

print(emaillist)
print(document)

// for (index, file) in Folder.current.files.enumerated() {
//     guard file.extension == "md" else {
//         continue
//     }

//     emaillist = emaillist.shuffled()
//     document = document.shuffled()

//     // print(emaillist[index])
//     // print(document[index])
//     let outfile = try Folder.current.createFile(named: emaillist[index])
//     try outfile.write(string: document[index])
// }