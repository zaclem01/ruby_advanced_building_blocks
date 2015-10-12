def bubble_sort(arr)
	swapped = true
	n = arr.length
	while swapped
		swapped = false
		(1...n).each do |index|
			if arr[index-1] > arr[index]
				arr[index-1], arr[index] = arr[index], arr[index-1]
				swapped = true
			end
		end
		n -= 1
	end
	p arr
end

bubble_sort([4,3,78,2,0,2])