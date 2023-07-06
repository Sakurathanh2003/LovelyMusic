//
//  AlbumGrid.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 11/07/2022.
//

import SwiftUI

struct ListAlbum: View {
    @EnvironmentObject var viewModel: ExtractVideoViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Triangle()
                    .fill(Color(rgb: 0x1F222A))
                    .frame(width: 25, height: 27)
                Spacer().frame(width: 15)
            }
            
            ScrollViewReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(0..<viewModel.numberOfAlbums(), id: \.self) { index in
                            AlbumItemView(albumItem: viewModel.albumAt(index: index))
                            .id(index)
                            .onTapGesture {
                                viewModel.updateCurrentAlbum(at: index)
                            }
                        }.onAppear {
                            withAnimation {
                                proxy.scrollTo(viewModel.selectLibraryIndex)
                            }
                        }
                    }
                }
                .frame(width: 230, height: 244)
                .background(Color(rgb: 0x1F222A))
                .cornerRadius(10)
            }
        }.frame(width: 230, height: 258)
    }
}

private struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: 0, y: height))
        path.addQuadCurve(to: CGPoint(x: width, y: height), control: CGPoint(x: width / 2, y: -height / 2.5))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        
        return path
    }
}

struct AlbumGrid_Previews: PreviewProvider {
    static var previews: some View {
        ListAlbum()
            .previewLayout(.sizeThatFits)
    }
}
