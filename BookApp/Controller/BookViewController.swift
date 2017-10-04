//
//  BookViewController.swift
//  BookApp
//
//  Created by Jayaprakash Manchu on 29/09/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {

    //MARK:- Outlet Properties
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Computed Property
    var bookModel : BooksModel? {
        didSet {
            itemsToDisplay = bookModel?.items
            rightBarButtonItem.isEnabled = true
            tableView.reloadData()
        }
    }
    
    //MARK:- Properties
    let kCustomRowCount = 7
    let kTopRatedVal = 4.0
    let CellIdentifier = "LazyTableCell"
    let PlaceholderCellIdentifier = "PlaceholderCell"
    lazy var keychain = KeychainWrapper()
    lazy var imageDownloadsInProgress = [IndexPath: IconDownloader]()
    var isLoadingAll = true
    var itemsToDisplay : [Item]?
    lazy var markedItemIds = [String: String]()
    
    //MARK:- view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBarButtonItem.isEnabled = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
    }

    //MARK: - Methods
    @IBAction func toggleAllVsTopRated(_ sender: UIBarButtonItem) {
        
        isLoadingAll = !isLoadingAll
        sender.title = isLoadingAll ? "Top Rated" : "All"

        if(!isLoadingAll) {
            itemsToDisplay = bookModel?.items?.filter({ (item) -> Bool in
                
                if let rating = item.volumeInfo?.averageRating {
                    return rating >= kTopRatedVal
                } else {
                    return false
                }
            })
        } else {
            itemsToDisplay = bookModel?.items
        }
        tableView?.reloadData()
    }
    
    @IBAction func togglePendingVsRead(_ sender: UIButton) {
        if let cell = sender.superview?.superview as? UITableViewCell {
            if let indexPath = tableView?.indexPath(for: cell) {
                if let selectedItem = itemsToDisplay?[indexPath.row] {
                    if markedItemIds.keys.contains(selectedItem.idValue!) {
                        markedItemIds.removeValue(forKey: selectedItem.idValue!)
                        sender.setTitle("Pending", for: .normal)
                    } else {
                        markedItemIds[selectedItem.idValue!] = "Read"
                        sender.setTitle("Read", for: .normal)
                    }

                }

            }
        }
        /*
         [self.keychain mySetObject:_markedItemIds forKey:(__bridge NSString *)kSecValueData];
         [self.keychain writeToKeychain];*/
    }
    
    
    // -------------------------------------------------------------------------------
    //    terminateAllDownloads
    // -------------------------------------------------------------------------------
    func terminateAllDownloads() {
        // terminate all pending download connections
        let allDownloads = imageDownloadsInProgress.values
        allDownloads.forEach { (iconDownloader) in
            iconDownloader.cancelDownload()
        }
        
        imageDownloadsInProgress.removeAll()
    }

    deinit {
        terminateAllDownloads()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        terminateAllDownloads()
    }
    
}
//MARK:- Helper Method
extension BookViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0

        if let itemsToDisplay = itemsToDisplay {
            count = itemsToDisplay.count
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell?
        
        if let itemsToDisplay = itemsToDisplay {
            
            let nodeCount = itemsToDisplay.count
            
            if nodeCount == 0 && indexPath.row == 0 {
                // add a placeholder cell while waiting on table data
                cell = tableView.dequeueReusableCell(withIdentifier: PlaceholderCellIdentifier, for: indexPath)
            } else {
                if let customCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as? BookTableViewCell {
                    // Leave cells empty if there's no data yet
                    cell = customCell
                    if nodeCount > 0 {
                        let selectedItem = itemsToDisplay[indexPath.row]
                        let volumeInfo = selectedItem.volumeInfo
                        
                        customCell.bookTitleLabel?.text = volumeInfo?.title
                        customCell.bookSubTitleLabel?.text = volumeInfo?.subTitle
                        
                        let hadItem = markedItemIds.keys.contains(selectedItem.idValue!)
                        
                        customCell.pendingOrReadButton.setTitle(hadItem ? "Read" : "Pending", for: .normal)
                        
                        // Only load cached images; defer new downloads until scrolling ends
                        if let image = volumeInfo?.imageLinks?.smallThumbnailIcon {
                            customCell.bookImageView?.image = image
                        } else {
                            if self.tableView.isDragging == false && self.tableView.isDecelerating == false {
                                startIconDownload(selectedItem: selectedItem, indexPath: indexPath)
                            }
                            // if a download is deferred or in progress, return a placeholder image
                            customCell.bookImageView?.image = UIImage(named: "Placeholder.png")
                        }
                    }
                }
                
            }

        }
        
        return cell == nil ? UITableViewCell() : cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "pushToDetails", sender: tableView.cellForRow(at: indexPath))
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushToDetails" {
            if let selectedRow = tableView.indexPath(for: sender as! UITableViewCell)?.row {
                if let selectedItem = itemsToDisplay?[selectedRow] {
                    (segue.destination as? BookDetailViewController)?.selectedItem = selectedItem
                }
            }
            
        }
    }
}


//MARK:- Table cell image support
extension BookViewController {
    // -------------------------------------------------------------------------------
    //    startIconDownload:forIndexPath:
    // -------------------------------------------------------------------------------
    
    func startIconDownload(selectedItem: Item, indexPath: IndexPath)  {
        
        guard nil != imageDownloadsInProgress[indexPath] else {
            let iconDownloader = IconDownloader(item: selectedItem)
            imageDownloadsInProgress[indexPath] = iconDownloader
            iconDownloader.startDownload(completionHandler: {
                if let cell = tableView.cellForRow(at: indexPath) {
                    // Display the newly loaded image
                    cell.imageView?.image = selectedItem.volumeInfo?.imageLinks?.smallThumbnailIcon
                    
                    // Remove the IconDownloader from the in progress list.
                    // This will result in it being deallocated.
                    imageDownloadsInProgress.removeValue(forKey: indexPath)
                }
            })
            return
        }
    }
    
    
    // -------------------------------------------------------------------------------
    //    loadImagesForOnscreenRows
    //  This method is used in case the user scrolled into a set of cells that don't
    //  have their app icons yet.
    // -------------------------------------------------------------------------------
    func loadImagesForOnscreenRows() {
        if let itemsToDisplay = itemsToDisplay,
            itemsToDisplay.count > 0,
            let visiblePaths = tableView.indexPathsForVisibleRows {
                visiblePaths.forEach({ (indexPath) in
                    let itemRec = itemsToDisplay[indexPath.row]
                    if (itemRec.volumeInfo?.imageLinks?.smallThumbnailIcon == nil) {
                        startIconDownload(selectedItem: itemRec, indexPath: indexPath)
                    }
                })
            }
    }
}

//MARK: - UIScrollViewDelegate
extension BookViewController : UIScrollViewDelegate {
    // -------------------------------------------------------------------------------
    //    scrollViewDidEndDragging:willDecelerate:
    //  Load images for all onscreen rows when scrolling is finished.
    // -------------------------------------------------------------------------------
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            loadImagesForOnscreenRows()
        }
    }
    
    
    // -------------------------------------------------------------------------------
    //    scrollViewDidEndDecelerating:scrollView
    //  When scrolling stops, proceed to load the app icons that are on screen.
    // -------------------------------------------------------------------------------
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadImagesForOnscreenRows()
    }
}
























