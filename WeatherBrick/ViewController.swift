//
//  Created by Volodymyr Andriienko on 11/3/21.
//  Copyright © 2021 VAndrJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let weatherBrickView = WeatherBrickView()
    
    override func loadView() {
        view = weatherBrickView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
