//
//  AlbumsTableViewController.swift
//  PinkFloydAlbums
//
//  Created by Alexey on 5/4/22.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    enum Section {
        case all
    }
    
    
    var albumTitle = ["The Dark Side of the Moon", "Wish You Were Here", "Animals", "The Wall", "A Momentary Lapse of Reason", "The Division Bell", "Delicate Sound of Thunder", "Pulse"]
    
    var albumCover = ["The Dark Side of the Moon", "Wish You Were Here", "Animals", "The Wall", "A Momentary Lapse of Reason", "The Division Bell", "Delicate Sound of Thunder", "Pulse"]
    
    var publicationYear = ["1973", "1975", "1977", "1979", "1987", "1994", "1988", "1995"]
    
    lazy var dataSource = configureDataSource()
    
    var albumIsFavorites = Array(repeating: false, count: 8)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
        tableView.dataSource = dataSource
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.all])
        snapshot.appendItems(albumTitle, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: false)
        
        tableView.separatorStyle = .none
    }
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, String> {
        
        let cellIdentifier = "datacell"
        
        let dataSource = UITableViewDiffableDataSource<Section, String>(tableView: tableView, cellProvider: { tableView, indexPath, albumName in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AlbumTableViewCell
            
            cell.nameLabel.text = albumName
            cell.albumCoverImageView.image = UIImage(named: self.albumCover[indexPath.row])
            cell.yearLabel.text = self.publicationYear[indexPath.row]
            
            //cell.accessoryType = self.albumIsFavorites[indexPath.row] ? .checkmark : .none
            
            cell.favoriteImage.isHidden = self.albumIsFavorites[indexPath.row] ? false : true
            
            return cell
        }
        )
        return dataSource
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Create an (instantiation) option menu as an action sheet
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        
        if let popoverController = optionMenu.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath) {
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
            }
        }
        
        // Add actions to the menu
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        
        // Mark as favorite action
        let favoriteActionTitle = self.albumIsFavorites[indexPath.row] ? "Remove from favorites" : "Mark as favorite"
        
        let favoriteAction = UIAlertAction(title: favoriteActionTitle, style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            
            let cell = tableView.cellForRow(at: indexPath) as! AlbumTableViewCell
            
            // Solution to exercise #2
            cell.favoriteImage.isHidden = self.albumIsFavorites[indexPath.row]
            
            self.albumIsFavorites[indexPath.row] = self.albumIsFavorites[indexPath.row] ? false : true
            
        })
        optionMenu.addAction(favoriteAction)
        
        // Display the menu
        present(optionMenu, animated: true, completion: nil)
        
        // Deselect the row
        tableView.deselectRow(at: indexPath, animated: false)
        
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
