//
//  ViewController_2.swift
//  Combine_Test
//
//  Created by Juan Capponi on 1/12/21.
//

import UIKit
import Combine

class ViewController_2: UIViewController {

    @IBAction func incrementValue(_ sender: Any) {
        counter.increment()
    }
    
    
    @IBOutlet weak var labelValue: UILabel!
    
    let counter = Counter()
    
    var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
    }
    
    func bind() {
        counter.$value.assign(to: \.text!, on: labelValue).store(in: &cancellable)
    }
    
}

class Counter {
    @Published private (set) var value: String = "0"
    
    private var currentValue = 0
    
    func increment() {
        currentValue += 1
        value = "\(currentValue)"
    }
}
