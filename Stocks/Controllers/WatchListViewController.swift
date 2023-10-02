//
//  ViewController.swift
//  Stocks
//
//  Created by Anıl Bürcü on 2.10.2023.
//

import UIKit
import FloatingPanel


class WatchListViewController: UIViewController {
    
    
    private var searchTimer: Timer?
    
    private var panel: FloatingPanelController?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setUpSearchController()
        setUpFloatingPanel()
        setUpTitleView()
        
    }
    
    // MARK: - Private
    
    private func setUpFloatingPanel(){
        let vc = TopStoriesNewsViewController()
        let panel = FloatingPanelController(delegate: self)
        panel.surfaceView.backgroundColor = .secondarySystemBackground
        panel.set(contentViewController: vc)
        panel.addPanel(toParent: self)
        panel.track(scrollView: vc.tableView)
    }
    
    
    
    private func setUpTitleView(){
        let titleView = UIView(frame: CGRect(x: 0,
                                             y: 0,
                                             width: view.width,
                                             height: navigationController?.navigationBar.height ?? 100
                                            )
        )
        
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: titleView.width-20, height: titleView.height))
        label.text = "Stocks"
        label.font = .systemFont(ofSize: 40,weight: .medium)
        titleView.addSubview(label)
        
        
        navigationItem.titleView = titleView
    }
    
    private func setUpSearchController(){
        let resultVC = SearchResultsViewController()
        resultVC.delegate = self
        let searchVC = UISearchController(searchResultsController: resultVC)
        searchVC.searchResultsUpdater = self // Kullanıcının klavyede bir tuşa bastığını anlıyoruz(Her basışında bu fonk çağrılır)
        navigationItem.searchController = searchVC
    }
}

extension WatchListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              let resultsVC = searchController.searchResultsController as? SearchResultsViewController,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        
        // Optimize to reduce number of searches for when user stops typing
        
        //Reset timer
        
        searchTimer?.invalidate()
        
        //Kick off new timer
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { _ in
            // Call API to search
            
            APICaller.shared.search(query: query) { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        resultsVC.update(with: response.result)
                    }
                case .failure(let error):
                    
                    DispatchQueue.main.async {
                        resultsVC.update(with: [])
                    }
                    print(error)
                }
            }
        })
        // Update results controller
        
    }
}

extension WatchListViewController: SearchResultsViewControllerDelegate{
    
    func searchResultViewControllerDidSelect(searchResult: SearchResult) {
        
        navigationItem.searchController?.searchBar.resignFirstResponder()//sonuçlara tıklayınca klavyenin kağanması için
        //Present stock details for given selection
        
        let vc = StockDetailsViewController()
        let navVC = UINavigationController(rootViewController: vc)
        vc.title = searchResult.description
        present(navVC,animated: true)
    }
    
    
}

extension WatchListViewController:FloatingPanelControllerDelegate {
    func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {
        
        // Floating panel'i yukarı kaydırınca asıl VC deki title gitmesi için
        navigationItem.titleView?.isHidden = fpc.state == .full
    }
}

