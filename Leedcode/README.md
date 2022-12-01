# Leedcode Answers Stats

## Question 1
<img width="350" src="https://user-images.githubusercontent.com/59265478/204939625-5ee8eea3-00fd-4408-9e5e-471079d28dda.png"> <img width="427" src="https://user-images.githubusercontent.com/59265478/204939533-35727991-a56e-4f3a-be21-116fc7898210.png">

    
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
   



