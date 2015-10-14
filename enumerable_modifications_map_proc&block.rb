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

	def my_map(proc)
		output = []
		if block_given?
			self.my_each { |item| output.push(yield(proc.call(item))) }
		else
			self.my_each { |item| output.push(proc.call(item)) }
		end
		output
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

square = Proc.new { |x| x**2 }

p [1, 2, 3, 4].my_map(square) { |x| x + 1 }