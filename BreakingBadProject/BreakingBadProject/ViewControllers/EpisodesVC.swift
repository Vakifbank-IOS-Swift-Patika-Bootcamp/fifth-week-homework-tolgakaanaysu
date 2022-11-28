//
//  EpisodesVC.swift
//  BreakingBadProject
//
//  Created by Tolga Kağan Aysu on 25.11.2022.
//

import UIKit

protocol EpisodeVCDelegate: AnyObject {
    func setTableViewAlpha()
}

final class EpisodesVC: BaseViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var episodesTableView: UITableView! {
        didSet{
            episodesTableView.delegate = self
            episodesTableView.dataSource = self
            episodesTableView.register(UINib(nibName: "EpisodeListCell", bundle: nil), forCellReuseIdentifier: "episodeCell")
            episodesTableView.estimatedRowHeight = UITableView.automaticDimension
        }
    }
    
    //MARK: - Property
    private var episodes: [EpisodeModel]?
    private var seasons: [EpisodeModel]?{
        didSet{
            episodesTableView.reloadData()
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllEpisodes()
        
    }
    
    //MARK: - IBActions
    @IBAction func seasonSegemtedControl(_ sender: UISegmentedControl) {
        episodesTableView.setContentOffset(.zero, animated: false)
        var seasonStr = ""
        switch sender.selectedSegmentIndex {
        case 0:
            seasons = episodes
            return
        case 1:
            seasonStr = "1"
        case 2:
            seasonStr = "2"
        case 3:
            seasonStr = "3"
        case 4:
            seasonStr = "4"
        case 5:
            seasonStr = "5"
        default:
            seasons = episodes
            return
        }
        seasons = episodes?.filter{$0.season == seasonStr}
    }
    
    //MARK: - Private methods
    private func getAllEpisodes() {
        indicator.startAnimating()
        NetworkClient.getAllEpisode {[weak self] episodes, error in
            guard let episodes = episodes,
                  let self = self else { return }
            self.episodes = episodes
            self.seasons = episodes
            self.indicator.stopAnimating()
        }
    }
}

//MARK: - TableView
extension EpisodesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        seasons?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let episode = seasons?[indexPath.row],
              let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell") as? EpisodeListCell
        else { return UITableViewCell()}
        cell.configure(episode: episode)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let episode = seasons?[indexPath.row] else { return}
        let detailsView = EpisodeDetailsView(frame: CGRect(origin: CGPointMake(view.center.x - 130,
                                                                               view.center.y - 150),
                                                           size: CGSize(width: 260, height: 300)))
        detailsView.configure(episode: episode)
        detailsView.delegate = self
        UIView.animate(withDuration: 1.0) {
            detailsView.alpha = 1
        }
        view.addSubview(detailsView)
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.alpha = 0.4
    }
}

extension EpisodesVC: EpisodeVCDelegate {
    func setTableViewAlpha() {
        self.episodesTableView.alpha = 1
    }
}
