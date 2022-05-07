//
//  ContentView.swift
//  ldk-swift-sample
//
//  Created by Arik Sosman on 4/20/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isRunningTestFlow = false
    
    @State private var multiPeerSimulation: PolarIntegrationSample.MultiPeerSimulator? = nil
    
	var body: some View {

		Button(action: {
            self.isRunningTestFlow = true
			let sample = PolarIntegrationSample()
			Task {
				try? await sample.testPolarFlow()
                self.isRunningTestFlow = false
			}
		}, label: {
			Text("Hello World")
        }).disabled(self.isRunningTestFlow)

        if let simulation = self.multiPeerSimulation {
            Button {
                self.multiPeerSimulation = nil
            } label: {
                Text("Stop multi-peer simulation")
            }
        } else {
            Button {
                self.multiPeerSimulation = PolarIntegrationSample.MultiPeerSimulator()
                Task {
                    try? await self.multiPeerSimulation!.simulateMultiplePeers()
                }
            } label: {
                Text("Simulate multiple peers")
            }
        }


	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
