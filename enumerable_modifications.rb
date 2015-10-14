module Enumerable
	def my_each
		if block_given?
			n = 0
			while n < self.length
				yield(self[n])
				n += 1
			end
		else
			self
		end
	end

	def my_each_with_index
		if block_given?
			n = 0
			while n < self.length
				yield(self[n], n)
				n += 1
			end
		else
			self
		end
	end

	def my_select
		if block_given?
			output = []
			self.my_each { |item| output.push(item) if yield(item) }
			return output
		else
			self
		end
	end

	def my_all?
		output = true
		if block_given?
			self.my_each do |item|
				if !yield(item)
					output = false
					break
				end
			end
		else
			self.my_each do |item|
				if !item
					output = false
					break
				end
			end
		end
		output
	end

	def my_any?
		output = false
		if block_given?
			self.my_each do |item|
				if yield(item)
					output = true
					break
				end
			end
		else
			self.my_each do |item|
				if item
					output = true
					break
				end
			end
		end
		output
	end

	def my_none?
		output = true
		if block_given?
			self.my_each do |item|
				if yield(item)
					output = false
					break
				end
			end
		else
			self.my_each do |item|
				if item
					output = false
					break
				end
			end
		end
		output
	end

	def my_count(match=false)
		output = 0
		if block_given?
			self.my_each { |item| output += 1 if yield(item) }
		elsif !match
			self.my_each { |item| output += 1 }
		else
			self.my_each { |item| output += 1 if item == match }
		end
		output
	end

	def my_map
		if block_given?
			output = []
			self.my_each { |item| output.push(yield(item)) }
		else
			self
		end
	end

	def my_inject(initial=false)
		if !initial
			memo = 0
			self.my_each { |item| memo = yield(memo, item) }
		else
			memo = initial
			self.my_each { |item| memo = yield(memo, item) }
		end
		memo
	end

end

def multiply_els(arr)
	arr.my_inject(1) { |product, i| product * i }
end

array = [1, 2, 3, 4]

array.my_each { |x| puts x }

array.my_each_with_index { |item, index| puts "#{index}: #{item}"}

p array.my_select { |x| x > 2 }

p array.my_all? { |x| x < 2 }

p [nil, true, false].my_all?

p array.my_any? { |x| x > 5 }

p [nil, true, false].my_any?

p array.my_none? { |x| x > 3 }

p [false, nil, true].my_none?

p array.my_count

p array.count(2)

p array.count { |x| x % 2 == 0 }

p (1..4).map { |i| i*i }

p array.map { |x| x * 2 }

p (5..10).inject { |sum, n| sum + n }

p (5..10).inject(1) { |product, n| product * n }

p multiply_els([2, 4, 5])