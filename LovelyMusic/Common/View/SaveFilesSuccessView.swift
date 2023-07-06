//
//  SaveFilesSuccessView.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 07/07/2022.
//

import SwiftUI

struct SaveFilesSuccessView: View {
    var body: some View {
        ZStack {
            HStack {
                Spacer().frame(width: 33)
            
                Image("ic_saveFiles")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 28, height: 28)
                
                Spacer().frame(width: 24)
                
                Text("Saved files")
                    .font(Poppins.medium(size: 13))
                    .foregroundColor(Color(rgb: 0xFFFFFF))
                
                Spacer().frame(width: 33)
                
            }
        }
        .frame(width: 189, height: 52)
        .background(Color.black)
        .cornerRadius(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white, lineWidth: 1)
        )
        
    }
}

struct SaveFilesSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SaveFilesSuccessView()
            .background(Color.black)
            .previewLayout(.sizeThatFits)
    }
}
