//
//  PartDataModel.swift
//  CycleAssembler
//
//  Created by Aditya Vyavahare(ヴィヤヴャハレ・アディティア) on 30/08/23.
//

import UIKit

struct PartsDataModel: Equatable {
    let image: UIImage
    let name: String
    let description: String
}
class Parts {
    // list of parts
    var partsArray: [PartsDataModel] = [
        PartsDataModel(image: UIImage(named: "img_frame")!, name: "Frame", description: "The bicycle frame is the core structure that holds all components together. Typically made from materials like steel, aluminum, carbon fiber, or titanium, it provides the bike's shape and stability. The frame's design influences factors such as ride comfort, handling, and overall performance. Different frame styles cater to various riding styles, from road racing to mountain biking."),
        PartsDataModel(image: UIImage(named: "img_handle")!, name: "Handle", description: "The bicycle handle, also known as the handlebar, is the steering and control mechanism. It extends from the frame and provides the rider with a grip for maneuvering. Handlebars come in various styles, including drop bars for road bikes, flat bars for urban and mountain bikes, and more. They play a crucial role in determining the rider's posture and control while cycling."),
        PartsDataModel(image: UIImage(named: "img_mudGuard")!, name: "Mud Guard", description: "A bicycle mudguard, also called a fender, is an accessory attached above the wheels. It prevents mud, water, and debris from splashing onto the rider and bike components. Mudguards come in different styles and lengths, catering to various bike types and weather conditions. They enhance rider comfort, reduce cleaning efforts, and help protect the bike's moving parts from debris damage."),
        PartsDataModel(image: UIImage(named: "img_seat")!, name: "Seat", description: "The bicycle seat, or saddle, is the component where the rider sits. It's designed for comfort and support during cycling. Seats come in various shapes and sizes to accommodate different body types and riding styles. Proper adjustment and padding are important for a comfortable and ergonomic riding experience."),
        PartsDataModel(image: UIImage(named: "img_sideStand")!, name: "Side Stand", description: "A bicycle side stand is a small device attached to the frame near the rear wheel. It allows the bike to stand upright when not in motion, providing convenience for parking and brief stops. Side stands come in different styles, including single-legged and double-legged designs. They offer stability and help prevent the bike from falling over when parked."),
        PartsDataModel(image: UIImage(named: "img_wheel")!, name: "Wheel", description: "A bicycle wheel is a circular component with a rim at its outer edge, connected to a hub at its center. Spokes connect the hub to the rim, providing structural integrity. The wheel rotates around an axle, allowing the bike to move forward. Different wheel sizes and designs cater to various riding styles, such as road, mountain, and hybrid biking.")
    ]
}
