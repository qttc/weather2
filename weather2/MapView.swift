//
//  MapView.swift
//  weather2
//
//  Created by Mikita Tratseuski on 11.10.23.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotation(annotation)
        uiView.showAnnotations([annotation], animated: true)
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        uiView.setRegion(region, animated: true)
    }
}
