//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by Atsushi Suzuki on 2017/01/18.
//  Copyright © 2017年 atsushi.suzuki. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentsTableView: UITableView!
    
    @IBOutlet weak var comment: UITextField!
    @IBOutlet weak var commentButton: UIButton!
    
    
    var comments: [Dictionary<String, String>] = []                 // コメント

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        commentsTableView.dataSource = self
        commentsTableView.delegate = self
        
        commentsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell1")
        
        // テーブルセルのタップを無効にする
        commentsTableView.allowsSelection = false

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPostData(postData: PostData) {
        self.postImageView.image = postData.image
        
        self.captionLabel.text = "\(postData.name!): \(postData.caption!)"
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale!
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString:String = formatter.string(from: postData.date! as Date)
        self.dateLabel.text = dateString
        
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: UIControlState.normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: UIControlState.normal)
        }
        // コメント
        comments = postData.comments
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("DEBUG_PRINT: comment.count=\(comments.count)")
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 再利用可能なcellを得る
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath as IndexPath)

        // 値をセットする
        cell.textLabel!.text = comments[indexPath.row]["name"]! + ":" + comments[indexPath.row]["comment"]!
        
        return cell
    }
    
    
}
