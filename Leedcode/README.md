# Leedcode Answers Stats

## Question 1

    
    func uniqueOccurrences(_ arr: [Int]) -> Bool {
         var dic: [Int:Int] = [:]
        
        for item in arr {
            dic[item] = (dic[item] ?? 0) + 1
        }
        
        if Set(dic.values).count == dic.values.count{
            return true
        } else {
            return false
        }
    }
   

