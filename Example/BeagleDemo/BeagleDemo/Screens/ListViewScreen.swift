//
//  Copyright © 2020 Zup IT. All rights reserved.
//

import UIKit
import BeagleUI

struct ListViewScreen: DeeplinkScreen {
    
    init(path: String, data: [String : String]?) {
    }
    
    func screenController() -> UIViewController {
        return Beagle.screen(.declarative(screen))
    }
    
    var screen: Screen {
        return Screen(
            navigationBar: NavigationBar(title: "ListView"),
            child: listView
        )
    }
    
    var listView = ListView(
        rows: [
            Touchable(action: Navigate.addView(.init(path: .NAVIGATE_ENDPOINT)), child: Text("0000")),
            Text("0001", flex: Flex(size: Size(width: .init(value: 100, type: .real), height: .init(value: 100, type: .real)))),
            Text("0002"),
            Text("0003"),
            Text("0004"),
            LazyComponent(
                path: .TEXT_LAZY_COMPONENTS_ENDPOINT,
                initialState: Text("Loading LazyComponent...")
            ),
            Text("0005"),
            Text("0006"),
            Text("0007"),
            Text("0008"),
            Text("0009"),
            Text("0010"),
            Text("0011"),
            Text("0012"),
            Text("0013"),
            Image(name: "beagle"),
            Text("0014"),
            Text("0015"),
            Text("0016"),
            NetworkImage(path: .NETWORK_IMAGE_BEAGLE),
            Text("0017"),
            Text("0018"),
            Text("0019"),
            Text("0020"),
            Container(children: [Text("Text1"), Text("Text2")], flex: Flex())],
        direction: .horizontal)
}

