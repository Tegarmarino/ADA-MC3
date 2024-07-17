//
//  JournalToolBar.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Tegar marino on 11/07/24.
//

import SwiftUI

//struct JournalToolBar: View {
//    var JournalToolBarIcon: [String]
//
////    @Binding var selectedIndex: Int
//
//    var body: some View {
//        HStack {
//            HStack{
//                ForEach(JournalToolBarIcon.indices, id: \.self) { index in
//                    VStack {
//                        Image(systemName: JournalToolBarIcon[index])
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 20, height: 20)
//                            .padding(.horizontal,13)
//
//                    }
//                    .padding(.vertical,12)
//                    .foregroundColor(.black)
////                    .onTapGesture {
////                        withAnimation(.easeInOut) {
////                            selectedIndex = index
////                        }
////                    }
//                }
//            }
//            .padding(.horizontal)
//            .background(.white)
//            .cornerRadius(.infinity)
//
//            NavigationLink(destination: HomeView()) {
//                Image(systemName: "checkmark")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 20, height: 20)
//                    .padding(.all,12)
//                    .background(Color.theme.primaryColorTheme)
//                    .clipShape(Circle())
//                    .foregroundColor(.black)
//            }
//        }
//        .padding(.horizontal)
//    }
//}




//
//struct JournalToolBar: View {
//    var JournalToolBarIcon: [String]
//
//    @Binding var isBold: Bool
//    @Binding var isItalic: Bool
//    @Binding var isUnderline: Bool
//
//    var body: some View {
//        HStack {
//            HStack {
//                ForEach(JournalToolBarIcon.indices, id: \.self) { index in
//                    VStack {
//                        Image(systemName: JournalToolBarIcon[index])
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 20, height: 20)
//                            .padding(.horizontal, 13)
//                            .onTapGesture {
//                                switch JournalToolBarIcon[index] {
//                                case "bold":
//                                    isBold.toggle()
//                                case "italic":
//                                    isItalic.toggle()
//                                case "underline":
//                                    isUnderline.toggle()
//                                default:
//                                    break
//                                }
//                            }
//                            .foregroundColor(isSelected(icon: JournalToolBarIcon[index]) ? .blue : .black)
//                    }
//                    .padding(.vertical, 12)
//                }
//            }
//            .padding(.horizontal)
//            .background(.white)
//            .cornerRadius(.infinity)
//
//            NavigationLink(destination: HomeView()) {
//                Image(systemName: "checkmark")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 20, height: 20)
//                    .padding(.all, 12)
//                    .background(Color.theme.primaryColorTheme)
//                    .clipShape(Circle())
//                    .foregroundColor(.black)
//            }
//        }
//        .padding(.horizontal)
//    }
//
//    private func isSelected(icon: String) -> Bool {
//        switch icon {
//        case "bold":
//            return isBold
//        case "italic":
//            return isItalic
//        case "underline":
//            return isUnderline
//        default:
//            return false
//        }
//    }
//}
//




struct JournalToolBar: View {
    var JournalToolBarIcon: [String]
    @Binding var isBold: Bool
    @Binding var isItalic: Bool
    @Binding var isUnderline: Bool
    var closeKeyboardAction: () -> Void
    var saveAction: () -> Void
    
    var body: some View {
        HStack{
            HStack {
                ForEach(JournalToolBarIcon.indices, id: \.self) { index in
                    Button(action: {
                        switch JournalToolBarIcon[index] {
                            case "bold":
                                isBold.toggle()
                            case "italic":
                                isItalic.toggle()
                            case "underline":
                                isUnderline.toggle()
                            case "keyboard.chevron.compact.down":
                                closeKeyboardAction()
                            default:
                                break
                        }
                    }) {
                        Image(systemName: JournalToolBarIcon[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(isSelected(icon: JournalToolBarIcon[index]) ? .blue : .black)
                    }
                    .padding(.horizontal, 13)
                    .padding(.vertical, 12)
                }
            }
            .background(.white) // Optional: Change as needed
            .cornerRadius(.infinity)
            .padding(.horizontal)

            
            Button(action: {
                saveAction()
            }) {
                Image(systemName: "checkmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .padding(.all, 12)
                    .background(Color.theme.primaryColorTheme)
                    .clipShape(Circle())
                    .foregroundColor(.black)
            }
        }
        
    }
    
    private func isSelected(icon: String) -> Bool {
        switch icon {
            case "bold":
                return isBold
            case "italic":
                return isItalic
            case "underline":
                return isUnderline
            default:
                return false
        }
    }
}
