# Leedcode Answers Stats

## Question 1
   <img width="390" alt="Ekran Resmi 2022-12-02 00 04 40" src="https://user-images.githubusercontent.com/59265478/205158982-969741aa-c736-4384-be37-b0ce05c474be.png">  <img width="400" alt="Ekran Resmi 2022-12-01 22 34 37" src="https://user-images.githubusercontent.com/59265478/205143976-abff1270-c1c0-4f76-80fa-9d1589e7b6a2.png">  






    
    
    func singleNumber(_ nums: [Int]) -> Int {
       var sum = 0
       for i in nums {
           sum ^= i
       }
       return sum 
    }
    



## Question 2
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
   



