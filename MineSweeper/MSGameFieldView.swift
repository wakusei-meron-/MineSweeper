//
//  MSGameFieldView.swift
//  MineSweeper
//
//  Created by Genki Ishibashi on 2015/01/08.
//  Copyright (c) 2015年 Genki Ishibashi. All rights reserved.
//

import UIKit

class MSGameFieldView: UIView {

    let numRows: Int, numColumns: Int
    let numMine: Int
    
    var buttonArray = [[MSButton]]()
    
    required init(coder aDecoder: NSCoder) {
        
        let m = MSGameManager.manager()
        numRows    = m.getNumRows()
        numColumns = m.getNumColumns()
        numMine    = m.getNumMines()
        
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        
        let btnWidth : CGFloat  = rect.size.width / CGFloat(numRows)
        let btnHeight : CGFloat = rect.size.height / CGFloat(numColumns)
        let btn = MSButton()
        
        for row_i in 0..<numRows {
            
            var columnArray = [MSButton]()
            
            for col_j in 0..<numColumns{
                
                let btn = MSButton(frame: CGRect(
                    x: btnWidth  * CGFloat(row_i),
                    y: btnHeight * CGFloat(col_j),
                    width: btnWidth,
                    height: btnHeight)
                )
                btn.row = row_i
                btn.column = col_j
                
                self.addSubview(btn)
                columnArray.append(btn)
            }
            
            buttonArray.append(columnArray)
        }
    }
    
    func setupButtons(){

        var currentNumMines = numMine
        
        for rowButtons in buttonArray as [Array]{
            for btn in rowButtons as [MSButton]{
                
                btn.msState = MSButton.MSButtonState.unOpened
                btn.isMine = setMineOrNot(Float(numRows * numColumns - (numRows * btn.row + btn.column)), a: Float(currentNumMines))
                
                if btn.isMine{
                    
                    currentNumMines--
                    incrementAroundMineNum(btn.row, col_j: btn.column)
                }
            }
        }
    }
    
    func incrementAroundMineNum(row_i: Int, col_j: Int){
        
        // +1 around number of mine
        for i in -1...1{
            for j in -1...1{
                
                // skip mine button
                if i==0 && j==0{ continue }
                
                // skip outside the field
                if row_i + i < 0 || col_j + j < 0{ continue }
                if row_i + i >= numRows || col_j + j >= numColumns { continue }
                
                (buttonArray[row_i + i][col_j + j] as MSButton).numAroundMine++
            }
        }
    }
    
    func openAroundButton(row: Int, col: Int){
        
        for i in -1...1{
            for j in -1...1{
                
                // skip outside the field
                if row + i < 0 || col + j < 0{ continue }
                if row + i >= numRows || col + j >= numColumns { continue }
                
                let btn = buttonArray[row + i][col + j] as MSButton
                
                if btn.msState == MSButton.MSButtonState.opened{ continue }
                btn.open()
                
                if btn.numAroundMine == 0{
                    
                    openAroundButton(btn.row, col: btn.column)
                }
            }
        }
    }
    
    func setMineOrNot(n: Float, a: Float) -> Bool{
        
        // set Mines
        /*
        モンテカルロ法みたいな方法？
        
        地雷かどうかわからないマスが全部でn、地雷の数がaの時、
        １つ目のマスが地雷である確率pは
        p = a / n
        
        0~1の乱数と地雷である確率を比較して、地雷かそうでないか決定する
        
        (i)１つ目のマスが地雷だとすると、２つ目のマスが地雷である確率は
        p = (a-1) / (n - 1)
        
        (ii)１つ目のマスが地雷じゃないとすると、２つ目のマスが地雷である確率は
        p = a / (n - 1)
        
        
        コレを繰り返していくと、合計n個のマスにa個の地雷を選ぶことができる。
        
        */
        let mineProb = a / n
        let p = Float(arc4random()) / Float(UINT32_MAX)
        
        if p < mineProb{
            
            return true
        }
        
        return false
    }
    
    func isCleared() -> Bool{
        
        for rowButtons in buttonArray as [Array]{
            for btn in rowButtons as [MSButton]{
                
                if btn.isMine{ continue }
                if btn.msState != MSButton.MSButtonState.opened{
                    return false
                }
            }
        }
        
        return true
    }
}
