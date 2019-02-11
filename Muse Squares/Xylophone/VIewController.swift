
import UIKit
import AVFoundation

class ViewController: UIViewController{
    
    var player: AVAudioPlayer?
    let soundArray = ["note1","note2","note3","note4","note5","note6","note7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func notePressed(_ sender: UIButton) {
        playSound(selectedSoundFileName: soundArray[sender.tag-1])
    }
    
    func playSound(selectedSoundFileName: String) {
        let path = Bundle.main.path(forResource: selectedSoundFileName, ofType:"wav")!
        let url = URL(fileURLWithPath: path)
        
        do {
            // Open cd player put in disk
            let sound = try AVAudioPlayer(contentsOf: url)
            self.player = sound
            //sound.numberOfLoops = 0
            //sound.prepareToPlay()
            sound.play()
        } catch {
            print("error loading file")
            // couldn't load file :(
        }
    }
}
