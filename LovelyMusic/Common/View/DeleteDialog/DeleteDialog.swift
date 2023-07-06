//
//  DeleteDialog.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 25/07/2022.
//

import SwiftUI

struct DeleteDialog: View {
    @EnvironmentObject var presentationContext: SolarPresentationContext
    
    @ObservedObject var viewModel: DeleteDialogViewModel
    var didTapDelete: (() -> Void)?
    
    var body: some View {
        ZStack {
            BlurView(style: .dark)
                .onTapGesture {
                    self.presentationContext.dismiss()
                }

            HStack {
                Spacer().frame(width: 46)
                
                VStack {
                    Spacer().frame(height: 20)
                    
                    Image("img_delete")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 48, height: 48)
                    
                    Text("Delete")
                        .foregroundColor(Color(rgb: 0xFFFFFF))
                        .font(Poppins.medium(size: 17))
                        .frame(height: 5)
                    
                    Spacer().frame(height: 10)

                    Text("Are you sure you want to delete \(viewModel.name())?")
                        .foregroundColor(Color(rgb: 0xFFFFFF))
                        .font(Poppins.regular(size: 13))
                        .multilineTextAlignment(.center)
                    
                    Spacer().frame(height: 20)
                    
                    HStack {
                        Button {
                            self.presentationContext.dismiss()
                        } label: {
                            Text("Cancel")
                                .font(Poppins.medium(size: 17))
                                .foregroundColor(Color(rgb: 0xFFFFFF).opacity(0.75))
                                .frame(width: 110, height: 44, alignment: .center)
                                .background(
                                    RoundedRectangle(cornerRadius: 22).stroke(Color(rgb: 0xFFFFFF).opacity(0.75), lineWidth: 1)
                                )
                        }
                        
                        Spacer()
                        
                        Button {
                            viewModel.deleteItem()
                            self.didTapDelete?()
                        } label: {
                            Text("Delete")
                                .font(Poppins.medium(size: 17))
                                .foregroundColor(Color(rgb: 0xFFFFFF))
                                .frame(width: 110, height: 44, alignment: .center)
                                .background(Color(rgb: 0xFF1111))
                                .cornerRadius(22)
                        }
                    }
                    
                    Spacer().frame(height: 20)
                }
                .padding(.horizontal, 20.0)
                .background(Color(rgb: 0x1F222A))
                .cornerRadius(15)
                
                Spacer().frame(width: 46)
            }
            
        }.ignoresSafeArea()
    }
}

struct DeleteDialog_Previews: PreviewProvider {
    static var previews: some View {
        DeleteDialog(viewModel: DeleteDialogViewModel(item: MyRingToneItem(rlmObj: RlmMyRingtone())))
    }
}
