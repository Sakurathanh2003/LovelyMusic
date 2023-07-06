//
//  RenameDialog.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 25/07/2022.
//

import SwiftUI
import Introspect

struct RenameDialog: View {
    @EnvironmentObject var presentationContext: SolarPresentationContext
    @ObservedObject var viewModel: RenameDialogViewModel
    
    var saveButtonDidTap: (() -> Void)?
    
    var body: some View {
        ZStack {
            BlurView(style: .dark).ignoresSafeArea()
            
            HStack {
                Spacer().frame(width: 46)
                VStack {
                    Image("img_rename")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 48, height: 48)
                    
                    Text("Rename")
                        .foregroundColor(Color(rgb: 0xFFFFFF))
                        .font(Poppins.medium(size: 17))
                    Spacer().frame(height: 20)
                    
                    TextField( viewModel.newName, text: $viewModel.newName)
                        .foregroundColor(Color(rgb: 0xFFFFFF))
                        .accentColor(Color(rgb: 0x18C8B8))
                        .font(Inter.medium(size: 15))
                        .multilineTextAlignment(.center)
                        .introspectTextField { textField in
                            textField.becomeFirstResponder()
                        }
                    
                    Rectangle().frame(height: 1)
                        .foregroundColor(Color(rgb: 0xFFFFFF).opacity(0.5))
                    
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
                            viewModel.didTapSave()
                            self.saveButtonDidTap?()
                        } label: {
                            Text("Save")
                                .font(Poppins.medium(size: 17))
                                .foregroundColor(viewModel.saveTextColor())
                                .frame(width: 110, height: 44, alignment: .center)
                                .background(viewModel.buttonSaveColor())
                                .cornerRadius(22)
                        }.allowsHitTesting(viewModel.enableSaveButton())
                    }
                }
                .padding(.vertical, 20.0)
                .padding(.horizontal, 24.0)
                .background(Color(rgb: 0x1F222A))
                .cornerRadius(15)
                
                Spacer().frame(width: 46)
            }
        }
    }
}

struct RenameDialog_Previews: PreviewProvider {
    static var previews: some View {
        RenameDialog( viewModel: RenameDialogViewModel(item: MyRingToneItem(rlmObj: RlmMyRingtone())))
    }
}
