//
//  DataManager.swift
//  DataManager
//
//  Created by younghwan on 2018. 1. 29..
//  Copyright © 2018년 w. All rights reserved.
//
// 
// > func list : 각 view화면에서 아래와 같이 사용하면 됩니다. ( sqlite3 import 필요 )
// 
// DataManager.listAll()
// 
// DataManager.insert("20180204", "2월4일 일기", "일기내용쓰기", "", "Sunny")
//
// DataManager.remove(1)
// 
// DataManager.update(2, "20180202", "러블리즈", "내용수정", "", "Snow")
// 
// print(DataManager.get(2))
//

import SQLite3

class DataManager {
    
    // Properties
    
    var database:Connection!
    let diaryTable = Table("diary")
    let id = Expression<Int>("id")
    let yyyymmdd = Expression<String>("yyyymmdd")
    let title = Expression<String>("title")
    let story = Expression<String>("story")
    let photo = Expression<String>("photo")
    let weather = Expression<String>("weather")
    
    private static var sharedDataManager: DataManager = {
        let dataManager = DataManager()
        return dataManager
    }()
    
    
    // Initialization
    private init(){
        connectDatabase()
        createTable()
        insertSampleData()
    }
    
    
    private func connectDatabase(){
        print("DataManager connectDatabase()")
        // database
        do {
            let documentDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("diary").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
        
    }
    
    
    private func createTable(){
        print("DataManager createTable()")
        
        let createTable = self.diaryTable.create { (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.yyyymmdd, unique: true)
            table.column(self.title)
            table.column(self.story)
            table.column(self.photo)
            table.column(self.weather)
        }
        
        do {
            try self.database.run(createTable)
        } catch {
            print(error)
        }
        
    }
    
    private func insertSampleData(){
        print("createSampleData()")
        
        //remove all
        let ditem = self.diaryTable.delete()
        do {
            try self.database.run(ditem)
        } catch {
            print(error)
        }
        
        //sample1
        let insertContents = self.diaryTable.insert(
            self.yyyymmdd <- "20180201"
            , self.title <- "Diary 첫째날"
            , self.story <- "시작합시다~! 홧팅!"
            , self.photo <- "1.jsp"
            , self.weather <- "Sunny"
            )
        do {
            try self.database.run(insertContents)
        } catch {
            print(error)
        }
        
        //sample2
        do {
            try self.database.run(self.diaryTable.insert(
                self.yyyymmdd <- "20180202"
                , self.title <- "[스타캐스트] 올 겨울도 러블리즈와 함께! [겨울나라의 러블리즈2] 포스터 촬영 현장"
                , self.story <- """
                그것은 바로! 바로바로
                2018년 2월 2일, 3일, 4일 블루스퀘어 아이마켓홀에서 3일간 진행되는 러블리즈의
                [겨울나라의 러블리즈2]!
                추위도 훠이훠이 무찌를 수 있을 만큼 러블리즈의 사랑스러움으로 가득찬
                [겨울나라의 러블리즈2] 공연을 보기 전!
                여러분들에게 콘서트 맛보기 사진들을 공개해볼까 합니다
                """
                , self.photo <- ""
                , self.weather <- ""
            ))
        } catch {
            print(error)
        }
        
        //sample3
        do {
            try self.database.run(self.diaryTable.insert(
                self.yyyymmdd <- "20180203"
                , self.title <- "윤종신은 왜 사랑 받을까? 고참 음악인의 치열한 생존기"
                , self.story <- """
                특정 주제, 장르에 얽메이지 않는 자유분방한 시도
                
                한동안 <월간 윤종신>은 하나의 주제에 맞춰 곡을 발표하는 방식을 달리 가져갔었다. '리페어'라는 단어를 사용했던 2013년엔 윤종신 본인의 과거 대표곡들을 직접 혹은 후배 음악인들을 기용해 리메이크하기도 했다. 2014년엔 소설, 게임 등 다양한 대중 문화로부터 소재를 취해 곡을 만들었다면 2015년은 매월 주목할만한 신작 영화를 음악으로 다뤘다.
                """
                , self.photo <- ""
                , self.weather <- ""
            ))
        } catch {
            print(error)
        }
        
    }
    
    
    class func shared() -> DataManager {
        //print("DataManager shared()")
        return sharedDataManager
    }
    
    
    class func listAll(){
        print("DataManager listAll()")
        do {
            let users = try shared().database.prepare(shared().diaryTable)
            for user in users {
                print("id: \(user[shared().id]), yyyymmdd: \(user[shared().yyyymmdd]), title: \(user[shared().title]), photo: \(user[shared().photo]), weather: \(user[shared().weather]), story: \(user[shared().story]) ")
            }
        } catch {
            print(error)
        }
    }
    
    
    class func get(_ rowid:Int) -> (yyyymmdd: String, title: String, photo: String, weather: String, story: String) {
        
        var yyyymmdd = ""
        var title = ""
        var photo = ""
        var weather = ""
        var story = ""
        
        do {
            let users = try shared().database.prepare(shared().diaryTable.filter(shared().id == rowid))
            for user in users {
                yyyymmdd = user[shared().yyyymmdd]
                title = user[shared().title]
                photo = user[shared().photo]
                weather = user[shared().weather]
                story = user[shared().story]
            }
        } catch {
            print(error)
        }
        
        return ( yyyymmdd, title, photo, weather, story)
    }
    
    
    class func insert(_ yyyymmdd:String, _ title:String, _ story:String, _ photo:String, _ weather:String){
        print("insert()")
        
        let insertContents = shared().diaryTable.insert(
            shared().yyyymmdd <- yyyymmdd
            , shared().title <- title
            , shared().story <- story
            , shared().photo <- photo
            , shared().weather <- weather
        )
        
        do {
            try shared().database.run(insertContents)
        } catch {
            print(error)
        }
        
    }
    
    class func update(_ id:Int, _ yyyymmdd:String, _ title:String, _ story:String, _ photo:String, _ weather:String){
        print("update()")
        
        let item = shared().diaryTable.filter(shared().id == id)
        
        let updateItem = item.update(
            shared().yyyymmdd <- yyyymmdd
            , shared().title <- title
            , shared().story <- story
            , shared().photo <- photo
            , shared().weather <- weather
        )
        
        do {
            try shared().database.run(updateItem)
        } catch {
            print(error)
        }
        
    }
    
    class func remove(_ id:Int){
        print("DataManager remove \(id)")
        
        let ditem = shared().diaryTable.filter(shared().id == id)
        let deleteItem = ditem.delete()
        do {
            try shared().database.run(deleteItem)
        } catch {
            print(error)
        }
        
    }
    
    class func removeAll(){
        print("DataManager removeAll")
        
        let ditem = shared().diaryTable.delete()
        do {
            try shared().database.run(ditem)
        } catch {
            print(error)
        }
        
    }
    
    
}
