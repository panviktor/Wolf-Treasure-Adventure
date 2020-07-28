import UIKit

class WelcomeViewController: UIViewController {
    let rootView: UIImageView = {
        let view = UIImageView(image: UIImage(named: ImageName.welcomeViewBackground))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let itemElementImage: UIImageView = {
        let view = UIImageView(image: UIImage(named: ImageName.welcomeItemElement))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageName.welcomePlayButton), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadGUI()
        itemElementImage.rotate(5)
        playButton.pulsate(100)
    }
    
    private func loadGUI() {
        view.addSubview(rootView)
        rootView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rootView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        rootView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        rootView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        view.addSubview(itemElementImage)
        itemElementImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        itemElementImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        itemElementImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        itemElementImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       
        
        view.addSubview(playButton)
        playButton.topAnchor.constraint(equalTo: itemElementImage.topAnchor, constant: 50).isActive = true
        playButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 55).isActive = true
        playButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        playButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc private func buttonAction() {
        launchTheGame()
    }
    
    private func launchTheGame() {
        let GameVC = GameViewController()
        GameVC.modalPresentationStyle = .fullScreen
        self.present(GameVC, animated: true)
    }
}

