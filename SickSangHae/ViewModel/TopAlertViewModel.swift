//
//  TopAlertViewModel.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/23.
//

import SwiftUI

class TopAlertViewModel: ObservableObject {
    @Published var isAlertVisible = true
    var name: String
    var currentCase: TopAlertViewCase

    init(name: String, currentCase: TopAlertViewCase) {
        self.name = name
        self.currentCase = currentCase
    }

    func hideAlert() {
        withAnimation {
            isAlertVisible = false
        }
    }

  // 제스처 변경(스와이프) 처리를 수행하는 함수
    func onDragChanged(value: DragGesture.Value) {
        let translation = value.translation
    }
  
  // 제스처 종료(스와이프 완료) 처리를 수행하는 함수
    func onDragEnded(value: DragGesture.Value) {
        let translation = value.translation
        if translation.height < -50 {
            hideAlert()
        }
    }
}
