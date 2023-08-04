//
//  VideosVC.swift
//  GujaratSamachar
//
//  Created by Nand Parikh on 23/06/23.
//

import UIKit

class VideosVC: UIViewController,VideoTableViewCellDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var tblVideosViewList: UITableView!
    
    // MARK: - Global Variable
    var videoModel : VideoArticleModel?
    var videoViewModel = VideoViewModel()

    // MARK: - Viewcontroller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureControl()
    }
    
    // MARK: - Configure Control
    func configureControl() {
        setUpTableView()
        videoViewModel.getData()
        videoViewModel.action = { [self] in
            reloadTBL()
        }
    }
    
    // MARK: - Reload Table
    func reloadTBL(){
        DispatchQueue.main.async { [self] in
            tblVideosViewList.reloadData()
        }
    }
    
    // MARK: - Setup TableView
    func setUpTableView(){
        tblVideosViewList.estimatedRowHeight = 540
        tblVideosViewList.rowHeight = UITableView.automaticDimension

        tblVideosViewList.register(UINib(nibName: "VideosViewCell", bundle: nil), forCellReuseIdentifier: "VideosViewCell")
    }
    
    // MARK: - Did Select Item
    func didSelectItem(videoURL: String, index: Int) {
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "VideoDetailVC") as? VideoDetailVC {
            detailVC.videoURL = videoURL
            detailVC.videoData = self.videoViewModel.arrVideoLists[index]
            self.present(detailVC, animated: true, completion: nil)
        }
    }
}

// MARK: - Tableview Delegate and Datasource Methods
extension VideosVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell : VideosViewCell = tableView.dequeueReusableCell(withIdentifier: "VideosViewCell") as? VideosViewCell{

            cell.delegate = self

            cell.configureCell(arrVideoLists: self.videoViewModel.arrVideoLists, clvVideos: cell.clvVideos, tblHeight: self.tblVideosViewList.bounds.size.height, tbl: self.tblVideosViewList, cnstHeight: self.tblVideosViewList.bounds.size.height)

            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
