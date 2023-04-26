//
//  Enums.swift
//  MyCreditManager
//
//  Created by 정현준 on 2023/04/26.
//

import Foundation

/** 메뉴 타입*/
enum menuType: String {
    case add_student = "1" // 학생추가
    case remove_student = "2" // 학생삭제
    case add_grade = "3" // 성적추가(변경)
    case remove_grade = "4" // 성적삭제
    case average = "5" // 평점보기
    case quit = "X" // 종료
}

/*
- A+ (4.5점) / A (4점)
- B+ (3.5점) / B (3점)
- C+ (2.5점) / C (2점)
- D+ (1.5점) / D (1점)
- F (0점)
 */
enum gradeType: String {

    case Ap = "A+"
    case A = "A"
    case Bp = "B+"
    case B = "B"
    case Cp = "C+"
    case C = "C"
    case Dp = "D+"
    case D = "D"
    case F = "F"
}
