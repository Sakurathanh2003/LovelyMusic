//
//  PermissionErrorView.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 18/08/2022.
//

import SwiftUI

struct PermissionErrorView: View {
    var body: some View {
        VStack() {
            Image("img_permission_request_icon")
                .resizable()
                .frame(width: 129, height: 103)
            Spacer().frame(height: 9)
            VStack(spacing: 4) {
                Text("Please allow libary access")
                    .foregroundColor(.white)
                    .font(Poppins.medium(size: 15))
                Text("Please allow libary access to\nscan insect species information")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .font(Poppins.regular(size: 13))
                    .opacity(0.75)
            }
            
            Spacer().frame(height: 27)
            
            ZStack {
                Color(rgb: 0x672CE9)
                Button {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                } label: {
                    Text("Allow access")
                        .foregroundColor(.white)
                        .font(Poppins.medium(size: 17))
                }
            }
            .frame(width: 165, height: 44)
            .cornerRadius(22)
        }
    }
}

struct PermissionErrorView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionErrorView()
    }
}
