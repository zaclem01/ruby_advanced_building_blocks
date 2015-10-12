def bubble_sort_by(arr)
	swapped = true
	n = arr.length
	while swapped
		swapped = false
		(1...n).each do |index|
			if yield(arr[index-1], arr[index]) > 0
				arr[index-1], arr[index] = arr[index], arr[index-1]
				swapped = true
			end
		end
		n -= 1
	end
	p arr
end

bubble_sort_by(["hi", "hello", "hey"]) { |first, second| first.length - second.length }