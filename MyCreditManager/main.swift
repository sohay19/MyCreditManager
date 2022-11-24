//
//  main.swift
//  MyCreditManager
//
//  Created by 소하 on 2022/11/24.
//

import Foundation

var selectedMenu:MenuType = .None
var database:[ScoreList] = []


func executeManager() {
    while selectedMenu != .Exit {
        print("원하는 기능을 입력해주세요")
        print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X:종료")
        let input = readLine()
        if let menu = input {
            if menu == "X" || menu == "x" {
                print("프로그램을 종료합니다...")
                return
            }
            if let menu = Int(menu) {
                let selecMenu = MenuType(rawValue: menu)
                selectedMenu = selecMenu ?? .None
                switch selectedMenu {
                case .None:
                    wrongInput()
                case .InsertStudent:
                    insertStudent()
                case .DeleteStudent:
                    deleteStudent()
                case .InsertScroe:
                    insertScore()
                case .DeleteScroe:
                    deleteScore()
                case .ShowScroe:
                    showScore()
                case .Exit:
                    selectedMenu = .None
                    wrongInput()
                }
            } else {
                wrongInput()
            }
        } else {
            wrongInput()
        }
        selectedMenu = .None
    }
}

func wrongInput() {
    print("뭔가 입력이 잘못되었습니다. 1~5사이의 숫자 혹은 X를 입력해주세요.")
}

func insertStudent() {
    print("추가할 학생의 이름을 입력해주세요")
    let input = readLine()
    guard let student = input else {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
    if student.isEmpty {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
    if database.contains(where: {$0.studentName == student}) {
        print("\(student)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
        return
    }
    database.append(ScoreList(studentName: student, scoreList: []))
    print("\(student) 학생을 추가했습니다.")
}

func deleteStudent() {
    print("삭제할 학생의 이름을 입력해주세요")
    let input = readLine()
    guard let student = input else {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
    if student.isEmpty {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
    if let index = database.firstIndex(where: {$0.studentName == student}) {
        database.remove(at: index)
        print("\(student) 학생을 삭제하였습니다.")
        return
    }
    print("\(student) 학생을 찾지 못했습니다.")
}

func insertScore() {
    print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요")
    print("입력예) Mickey Swift A+")
    print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
    let input = readLine()
    guard let input = input else {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
    let info = input.components(separatedBy: " ")
    if info.count != 3 {
        print("입력이 잘못되었습니다. 다시 확인해주세요")
        return
    }
    //
    let name = info[0]
    let subjects = info[1]
    let score = info[2]
    if let index = database.firstIndex(where: {$0.studentName == name}) {
        if let index = database[index].scoreList.firstIndex(where: {$0.subjects == subjects}) {
            database[index].scoreList[index].subjectsScore = score
        } else {
            database[index].scoreList.append(Score(subjects: subjects, subjectsScore: score))
        }
        print("\(name) 학생의 \(subjects) 과목이 \(score)로 추가(변경)되었습니다.")
        return
    }
    print("입력이 잘못되었습니다. 다시 확인해주세요")
}
func deleteScore() {
    print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
    print("입력예) Mickey Swift")
    let input = readLine()
    guard let input = input else {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
    let info = input.components(separatedBy: " ")
    if info.count != 2 {
        print("입력이 잘못되었습니다. 다시 확인해주세요")
        return
    }
    //
    let name = info[0]
    let subjects = info[1]
    if let index = database.firstIndex(where: {$0.studentName == name}) {
        if let index = database[index].scoreList.firstIndex(where: {$0.subjects == subjects}) {
            database[index].scoreList.remove(at: index)
            print("\(name) 학생의 \(subjects) 과목의 성적이 삭제되었습니다.")
        } else {
            print("\(subjects) 과목을 찾지 못했습니다.")
        }
        return
    }
    print("\(name) 학생을 찾지 못했습니다.")
    
}
func showScore() {
    print("평점을 알고 싶은 학생의 이름을 입력해주세요")
    let input = readLine()
    guard let name = input else {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
    if name.isEmpty {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
    if let index = database.firstIndex(where: {$0.studentName == name}) {
        let score = database[index].getAverage()
        for item in database[index].scoreList {
            print("\(item.subjects): \(item.subjectsScore)")
        }
        print("평점 : \(score)")
        return
    }
    print("\(name) 학생을 찾지 못했습니다.")
}


executeManager()
