require 'rspec'
require_relative '../lib/matrix_multiplication'
RSpec.describe MatrixMultiplication do
  describe '.multiply' do
    context 'when multiplying square matrices' do
      it 'returns the correct result for square matrices' do
        matrix_a = [[1, 2], [3, 4]]
        matrix_b = [[2, 0], [1, 2]]
        result = MatrixMultiplication.multiply(matrix_a, matrix_b)
        expected_result = [[4, 4], [10, 8]]

        expect(result).to eq(expected_result)
        puts 'Тест: множення квадратних матриць пройшов успішно'
      end
    end

    context 'when multiplying non-square matrices with valid dimensions' do
      it 'returns the correct result for non-square matrices' do
        matrix_a = [[1, 2, 3], [4, 5, 6]]
        matrix_b = [[7, 8], [9, 10], [11, 12]]
        result = MatrixMultiplication.multiply(matrix_a, matrix_b)
        expected_result = [[58, 64], [139, 154]]

        expect(result).to eq(expected_result)
        puts 'Тест: множення неквадратних матриць пройшов успішно'
      end
    end

    context 'when matrices have invalid sizes' do
      it 'raises an error for matrices with incompatible sizes' do
        matrix_a = [[1, 2, 3], [4, 5, 6]]
        matrix_b = [[7, 8], [9, 10]]

        expect { MatrixMultiplication.multiply(matrix_a, matrix_b) }.to raise_error(MultiplicationError)
        puts 'Тест: множення матриць з неправильними розмірами пройшов успішно'
      end
    end

    context 'when first matrix is missing' do
      it 'raises an error if the first matrix is not provided' do
        matrix_a = nil
        matrix_b = [[2, 3], [4, 5]]

        expect { MatrixMultiplication.multiply(matrix_a, matrix_b) }.to raise_error(MultiplicationError)
        puts 'Тест: перша матриця не задана пройшов успішно'
      end
    end

    context 'when second matrix is missing' do
      it 'raises an error if the second matrix is not provided' do
        matrix_a = [[1, 2], [3, 4]]
        matrix_b = nil

        expect { MatrixMultiplication.multiply(matrix_a, matrix_b) }.to raise_error(MultiplicationError)
        puts 'Тест: друга матриця не задана пройшов успішно'
      end
    end

    context 'when both matrices are missing' do
      it 'raises an error if both matrices are not provided' do
        matrix_a = nil
        matrix_b = nil

        expect { MatrixMultiplication.multiply(matrix_a, matrix_b) }.to raise_error(MultiplicationError)
        puts 'Тест: обидві матриці не задані пройшов успішно'
      end
    end

    context 'when a vector is provided instead of a matrix' do
      it 'raises an error if a vector is provided instead of a matrix' do
        matrix_a = [1, 2, 3]
        matrix_b = [[1, 2], [3, 4]]

        expect { MatrixMultiplication.multiply(matrix_a, matrix_b) }.to raise_error(MultiplicationError)
        puts 'Тест: введено вектор замість матриці пройшов успішно'
      end
    end

    context 'when first matrix is smaller than second' do
      it 'raises an error if the first matrix is smaller than the second' do
        matrix_a = [[1, 2]]
        matrix_b = [[3, 4], [5, 6], [7, 8]]

        expect { MatrixMultiplication.multiply(matrix_a, matrix_b) }.to raise_error(MultiplicationError)
        puts 'Тест: розмір першої матриці менший за другу пройшов успішно'
      end
    end

    context 'when first matrix is larger than second' do
      it 'raises an error if the first matrix is larger than the second' do
        matrix_a = [[1, 2, 3], [4, 5, 6]]
        matrix_b = [[7, 8]]

        expect { MatrixMultiplication.multiply(matrix_a, matrix_b) }.to raise_error(MultiplicationError)
        puts 'Тест: розмір першої матриці більший за другу пройшов успішно'
      end
    end

    context 'when second matrix is smaller than first' do
      it 'raises an error if the second matrix is smaller than the first' do
        matrix_a = [[1, 2], [3, 4], [5, 6]]
        matrix_b = [[7, 8]]

        expect { MatrixMultiplication.multiply(matrix_a, matrix_b) }.to raise_error(MultiplicationError)
        puts 'Тест: розмір другої матриці менший за першу пройшов успішно'
      end
    end

    context 'when second matrix is larger than first' do
      it 'raises an error if the second matrix is larger than the first' do
        matrix_a = [[1, 2]]
        matrix_b = [[3, 4, 5], [6, 7, 8]]

        expect { MatrixMultiplication.multiply(matrix_a, matrix_b) }.to raise_error(MultiplicationError)
        puts 'Тест: розмір другої матриці більший за першу пройшов успішно'
      end
    end
  end
end
