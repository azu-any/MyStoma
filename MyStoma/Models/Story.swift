import SwiftUI

struct Story: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var imageName: String
    var description: String
}

let stories: [Story] = [
    .init(title: "FAIS", subtitle: "Italian Association for Incontinence and Ostomy", imageName: "FAIS", description: "The F.A.I.S. OdV (Federation of Incontinent and Ostomy Associations), is a Volunteer Organization that brings together Regional Voluntary Associations in favor of incontinent and ostomy people, established in 2002 in Rimini. Since November 30, 2022 it has been registered in the Single National Register of the Third Sector (RUNTS) no. repertoire 82953.")
]
