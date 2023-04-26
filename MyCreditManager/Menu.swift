//
//  Menu.swift
//  MyCreditManager
//
//  Created by 정현준 on 2023/04/26.
//

import Foundation

/** 메뉴 클래스 */
class Menu {

    /** 메뉴 보여주기 */
    func showMenuList() {

        // 안내문 출력
        print("""
              원하는 기능을 입력해주세요
              1:학생추가, 2:학생삭제, 3:성적추가(변경), 4:성적삭제, 5:평점보기, X:종료
              """)

        // input 실행
        if let input = readLine() {

            if input.isEmpty {

                print("입력 오류")
                showMenuList()
                return
            }

            selectMenu(input)
        }
    }

    /** 메뉴 선택 */
    func selectMenu(_ menu: String) {

        switch menuType(rawValue: menu) {
        case .add_student:

            print("학생추가")
        case .remove_student:

            print("학생삭제")
        case .add_grade:

            print("성적추가(변경)")
        case .remove_grade:

            print("성적삭제")
        case .average:

            print("평점보기")
        case .quit:

            print("종료")
        case .none:

            print("입력오류")
        }
    }
}
