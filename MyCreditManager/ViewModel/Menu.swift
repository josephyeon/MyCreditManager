//
//  Menu.swift
//  MyCreditManager
//
//  Created by 정현준 on 2023/04/26.
//

import Foundation

/** 메뉴 클래스 */
class Menu {

    var dataList: [Student] = []

}

extension Menu {

    func showDataList() {

        if dataList.isEmpty {
            return
        }

        for data in dataList {

            print("이름: \(data.name)")

            for grade in data.grade {

                print("===> 과목: \(grade.subject), 성적: \(grade.point)")
            }
        }
    }

    /** 메뉴 보여주기 */
    func showMenuList() {

        showDataList()

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
            addStudent()
        case .remove_student:

            print("학생삭제")
            removeStudent()
        case .add_grade:

            print("성적추가(변경)")
            addGrade()
        case .remove_grade:

            print("성적삭제")
            removeGrade()
        case .average:

            print("평점보기")
            average()
        case .quit:

            print("종료")
            return
        case .none:

            print("입력오류")
            showMenuList()
        }
    }

    /** 학생추가 */
    func addStudent() {

        print("추가할 학생의 이름을 입력해주세요.")

        // input 실행
        if let input = readLine() {

            if input.isEmpty {

                print("입력 오류")
            }

            else if dataList.contains(where: { $0.name == input }) {

                print("이미 등록된 학생")
            }

            else {

                let student = Student()
                student.name = input
                dataList.append(student)

                print("\(input) 학생을 추가하였습니다.")
            }
            showMenuList()
        }
    }

    /** 학생 제거 */
    func removeStudent() {

        print("삭제할 학생의 이름을 입력해주세요.")

        // input 실행
        if let input = readLine() {

            if input.isEmpty {

                print("입력 오류")
            }

            else if !dataList.contains(where: { $0.name == input }) {

                print("등록되지 않은 학생")
            }

            else {

                if let index = dataList.firstIndex(where: { $0.name == input }) {

                    dataList.remove(at: index)
                    print("\(input) 학생을 제거하였습니다.")
                }
            }

            showMenuList()
        }
    }

    /** 성적추가(변경) */
    func addGrade() {

        // 안내문 출력
        print("""
              성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, ..., F 등)을 띄어쓰기로 구분하여 차례대로 작성해주세요.
              입력 예) Mickey Swift A+
              만약에 학생의 성적 중 해당 과목이 존재하면 기존의 점수가 갱신됩니다.
              """)

        // input 실행
        if let input = readLine()?.split(separator: " ").map( { String($0) } ){

            // 예외처리
            if input.isEmpty || input.count != 3 || input.contains(where: { $0.isEmpty }) {
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
            }

            else {

                /** 등록된 학생 판별여부 */
                if let index = dataList.firstIndex(where: { $0.name == input[0] }) {

                    if let gradeIndex = dataList[index].grade.firstIndex(where: { $0.subject == input[1] }) {

                        dataList[index].grade[gradeIndex].subject = input[1]
                        dataList[index].grade[gradeIndex].point = input[2]
                    }

                    else {

                        let gradeInfo = Grade()
                        gradeInfo.subject = input[1]
                        gradeInfo.point = input[2]

                        dataList[index].grade.append(gradeInfo)
                    }

                    print("\(input[0]) 학생의 \(input[1]) 과목이 \(input[2])으로 추가(변경) 되었습니다.")
                }

                else {

                    print("등록되지 않은 학생입니다. 다시 확인해주세요.")
                }
            }

            showMenuList()
        }
    }

    /** 성적삭제 */
    func removeGrade() {

        // 안내문 출력
        print("""
              성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.
              입력 예) Mickey Swift
              """)

        // input 실행
        if let input = readLine()?.split(separator: " ").map({ String($0) }) {

            // 예외처리
            if input.isEmpty || input.count != 2 {
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
            }

            else {

                if let index = dataList.firstIndex(where: { $0.name == input[0] }) {

                    var gardeList = dataList[index].grade

                    if let gradeIndex = gardeList.firstIndex(where: { $0.subject == input[1] }) {

                        gardeList.remove(at: gradeIndex)
                        dataList[index].grade = gardeList

                        print("\(input[0]) 학생의 \(input[1]) 과목의 성적이 삭제되었습니다.")
                    }

                    else {

                        print("등록되지 않은 과목입니다. 다시 확인해주세요.")
                    }

                }

                else {
                    print("등록되지 않은 학생입니다. 다시 확인해주세요.")
                }
            }
        }

        showMenuList()
    }

    /** 평점 계산 */
    func average() {

        print("평점을 알고싶은 학생의 이름을 입력해주세요.")

        if let name = readLine() {

            if let index = dataList.firstIndex(where: { $0.name == name }) {

                var sum: Float = 0.0
                for grade in dataList[index].grade {

                    print("\(grade.subject): \(grade.point)")

                    switch gradeType(rawValue: grade.point) {

                    case .Ap:

                        sum += 4.5
                    case .A:

                        sum += 4.0
                    case .Bp:

                        sum += 3.5
                    case .B:

                        sum += 3.0
                    case .Cp:

                        sum += 2.5
                    case .C:

                        sum += 2.0
                    case .Dp:

                        sum += 1.5
                    case .D:

                        sum += 1.0
                    case .F:

                        sum += 0.0
                    case .none:

                        print("해당되는 점수 없음")
                    }
                }

                let average = sum / Float(dataList[index].grade.count)
                print("평점: \(average)")
            }
        }
    }
}

/** 입력 라인 */
extension Menu {

}
