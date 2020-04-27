//
//  ViewController.swift
//  MapKitGoogleStyler
//
//  Created by fmo91 on 02/01/2017.
//  Copyright (c) 2017 fmo91. All rights reserved.
//

import UIKit
import MapKit
import MapKitGoogleStyler

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureMapView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configureMapView() {
        mapView.delegate = self
        // We first need to have the path of the overlay configuration JSON
        guard let overlayFileURLString = Bundle.main.path(forResource: "MapStyle", ofType: "json") else {
            return
        }
        let overlayFileURL = URL(fileURLWithPath: overlayFileURLString)

        // After that, you can create the tile overlay using MapKitGoogleStyler
        guard let tileOverlay = try? MapKitGoogleStyler.buildOverlay(with: overlayFileURL) else {
            return
        }

        // And finally add it to your MKMapView
        mapView.addOverlay(tileOverlay)

    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
         if let tileOverlay = overlay as? MKTileOverlay {
               return MKTileOverlayRenderer(tileOverlay: tileOverlay)
           } else {
               return MKOverlayRenderer(overlay: overlay)
           }
       }
}
