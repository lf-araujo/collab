import Yaml // marathon: https://github.com/behrang/YamlSwift.git
import Files //// marathon:https://github.com/JohnSundell/Files.git
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

var email: String = ""
var document: String = ""


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
        document = content.replacingOccurrences(of: "\n\(emailline)", with: "")
        document = content.replacingOccurrences(of: "\n\(authorline)", with: "")
    }  

    // Creating new file with name from email and copying contents into it
    //let folder = try Folder()
    let file = try Folder.current.createFile(named: email)
    try file.write(string: document)
}
