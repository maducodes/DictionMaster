import UIKit
import AVFoundation

final class SearchResultPresenter {
    weak var viewController: SearchResultViewControllerType?
    private let service: SearchResultServiceType
    private var soundUrl: String?
    private var audioPlayer: AVPlayer?

    init(service: SearchResultServiceType) {
        self.service = service
    }
    
    private func setTitleAtributte(index: Int,
                                   wordType: String,
                                   definition: String?) -> NSMutableAttributedString {
        let gray = [NSAttributedString.Key.foregroundColor: Colors.terciaryBlack]
        let black = [NSAttributedString.Key.foregroundColor: Colors.secondaryBlue]
        
        let atributedString = NSMutableAttributedString()
        atributedString.append(NSAttributedString(string: "\(String(index)))", attributes: black))
        atributedString.append(NSAttributedString(string: " [\(wordType)] ", attributes: gray))
        atributedString.append(NSAttributedString(string: definition ?? "", attributes: black))
        return atributedString
    }
    
    private func extractExamples(from meaning: Meaning) -> [String?] {
        var examples: [String?] = []
        
        for definition in meaning.definitions {
            if let example = definition.example {
                examples.append(example)
            }
        }
        
        return examples
    }
    
    private func mapping(_ meanings: [Meaning]) -> [MeaningViewModel] {
        var meaningViewModel: [MeaningViewModel] = []
        
        for (index, meaning) in meanings.enumerated() {
            let definitionTitle = setTitleAtributte(index: (index + 1),
                                                    wordType: meaning.partOfSpeech,
                                                    definition: meaning.definitions.first?.definition)
            let examples = extractExamples(from: meaning)
            meaningViewModel.append(MeaningViewModel(definition: definitionTitle,
                                                     examples: examples))
        }
        
        return meaningViewModel
    }
}

extension SearchResultPresenter: SearchResultPresenterType {
    func searchResult(search: String) {
        viewController?.show(state: .loading)
        service.fetchSearch(search: search) { [weak self] response in
            guard let data = response?.first else {
                self?.viewController?.show(state: .error(search: search))
                return
            }

            if let sound = data.phonetics.first?.audio {
                self?.soundUrl = sound
            }

            let viewModel = SearchResultViewModel(
                word: data.word,
                phonetic: data.phonetic,
                meanings: self?.mapping(data.meanings) ?? []
            )

            self?.viewController?.show(state: .success(viewModel: viewModel))
        }
    }
    
    func playAudio() {
        guard let url = soundUrl else {
            viewController?.showErrorSoundAlert(message: Strings.errorAlertDescription)
            return
        }
        
        guard let encodedUrlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let audioURL = URL(string: encodedUrlString) else {
            viewController?.showErrorSoundAlert(message: Strings.errorAlertDescription)
            return
        }
        
        self.audioPlayer = AVPlayer(url: audioURL)
        
        guard let audioPlayer = audioPlayer else {
            viewController?.showErrorSoundAlert(message: Strings.errorAlertDescription)
            return
        }
        
        audioPlayer.volume = 1.0
        audioPlayer.play()
    }
}
