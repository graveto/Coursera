arr = (1..10000)
p arr
arr = arr.select { |el| el % 3 == 0 }
p arr
arr = arr.reject { |el| el < 5000 }.sort.reverse
p arr
