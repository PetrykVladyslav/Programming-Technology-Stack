module MatrixMultiplication
  class MultiplicationError < StandardError; end

  def self.multiply(matrix_a, matrix_b)
    raise MultiplicationError, 'Matrices cannot be multiplied due to incompatible dimensions' unless valid_dimensions?(
      matrix_a, matrix_b
    )

    result = Array.new(matrix_a.size) { Array.new(matrix_b[0].size, 0) }

    matrix_a.each_with_index do |row, i|
      row.each_index do |j|
        matrix_b[0].size.times do |k|
          result[i][k] += matrix_a[i][j] * matrix_b[j][k]
        end
      end
    end

    result
  end

  def self.valid_dimensions?(matrix_a, matrix_b)
    matrix_a[0].size == matrix_b.size
  end
end