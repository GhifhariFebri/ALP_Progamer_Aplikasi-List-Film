//
//  SplashScreenView.swift
//  ALP_Progamer_Aplikasi List Film
//
//  Created by MacBook Pro on 29/05/23.
//

import SwiftUI

// pembuatan struct splash screen view
struct SplashScreenView: View {
    var body: some View {
        VStack {
            Image("filmit")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 500, height: 500)
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}
struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
