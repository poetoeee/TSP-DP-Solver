require 'time' 

class TSP_DP
  def initialize(cost_matrix)
    @cost_matrix = cost_matrix
    @num_cities = cost_matrix.length
    @memo = {}
    @path = {}
  end

  def solve
    return 0, [1] if @num_cities <= 1
    final_mask = (1 << @num_cities) - 2
    min_cost = find_path(0, final_mask)
    tour = reconstruct_tour(0, final_mask)
    return min_cost, tour
  end

  private

  def find_path(current_city, mask)
    if mask == 0
      return @cost_matrix[current_city][0]
    end
    return @memo[[current_city, mask]] if @memo[[current_city, mask]]
    min_cost = Float::INFINITY
    (0...@num_cities).each do |next_city|
      if (mask & (1 << next_city)) != 0
        cost = @cost_matrix[current_city][next_city] + find_path(next_city, mask ^ (1 << next_city))
        if cost < min_cost
          min_cost = cost
          @path[[current_city, mask]] = next_city
        end
      end
    end
    @memo[[current_city, mask]] = min_cost
    return min_cost
  end

  def reconstruct_tour(start_city, mask)
    tour = [start_city + 1]
    current_mask = mask
    current_city = start_city
    while current_mask > 0
      next_city = @path[[current_city, current_mask]]
      return "Jalur tidak dapat direkonstruksi" if next_city.nil?
      tour << next_city + 1
      current_mask ^= (1 << next_city)
      current_city = next_city
    end
    tour << start_city + 1
    return tour
  end
end

# --------------------------------------------------------------------------------

# HELPER FUNCTIONS
def create_matrix_from_input
  print "Masukkan jumlah kota: "
  num_cities = gets.to_i
  return nil if num_cities <= 1
  puts
  cost_matrix = Array.new(num_cities) { Array.new(num_cities, 0) }
  (0...num_cities).each do |i|
    (0...num_cities).each do |j|
      next if i == j
      print "Biaya dari Kota #{i + 1} ke Kota #{j + 1}: "
      cost_matrix[i][j] = gets.to_i
    end
  end
  return cost_matrix
end

def read_matrix_from_file
  print "Masukkan nama file (contoh: sample_1.txt): "
  filename = gets.chomp
  filepath = "../test/input/#{filename}"
  begin
    matrix = File.readlines(filepath).map do |line|
      line.chomp.split(',').map(&:to_i)
    end
    is_square = matrix.all? { |row| row.length == matrix.length }
    if !is_square || matrix.empty?
      puts "Error: Format matriks dalam file tidak valid atau file kosong."
      return nil
    end
    return matrix, filename
  rescue Errno::ENOENT
    puts "Error: File '#{filename}' tidak ditemukan."
    return nil
  rescue => e
    puts "Terjadi error saat membaca file: #{e.message}"
    return nil
  end
end

def display_results(matrix, cost, tour)
  puts "\nMatriks Biaya yang Digunakan:"
  matrix.each { |row| puts row.inspect }
  puts "\n--- Hasil Perhitungan ---"
  puts "Bobot tur terpendek: #{cost}"
  if tour.is_a?(Array)
    puts "Jalur tur optimal: #{tour.join(' -> ')}"
  else
    puts "Error: #{tour}"
  end
end

def save_results_to_file(matrix, cost, tour, input_filename)
  print "\nApakah Anda ingin menyimpan hasil ini ke file? (y/n): "
  choice = gets.chomp.downcase
  return unless choice == 'y'

  output_filename = ""
  if input_filename
    output_filename = "result_#{input_filename}"
  else
    timestamp = Time.now.strftime("%Y%m%d_%H%M%S")
    output_filename = "result_manual_#{timestamp}.txt"
  end

  filename = "../test/output/#{output_filename}"

  File.open(filename, 'w') do |file|
    file.puts "Tanggal: #{Time.now.strftime("%Y-%m-%d %H:%M:%S")}\n"
    file.puts "\nMatriks Biaya yang Digunakan:"
    matrix.each { |row| file.puts row.inspect }
    file.puts "\nHASIL PERHITUNGAN:"
    file.puts "Bobot tur terpendek: #{cost}"
    if tour.is_a?(Array)
      file.puts "Jalur tur optimal: #{tour.join(' -> ')}"
    else
      file.puts "Error: #{tour}"
    end
  end
  puts "Hasil telah disimpan ke file: #{filename}"
end

# --------------------------------------------------------------------------------

# MAIN PROGRAM LOOP
loop do
  system("clear") || system("cls") 
  puts "=============================================="
  puts "             T S P   S O L V E R              "
  puts "            (Dynamic Programming)             "
  puts "=============================================="
  puts "\n[1] Masukkan Matriks Secara Manual"
  puts "[2] Baca Matriks dari File"
  puts "[3] Keluar"
  print "\nPilih opsi: "
  
  choice = gets.chomp
  cost_matrix = nil
  input_filename = nil

  case choice
  when '1'
    cost_matrix = create_matrix_from_input
  when '2'
    matrix_data, filename_from_func = read_matrix_from_file
    if matrix_data
      cost_matrix = matrix_data
      input_filename = filename_from_func 
    end
  when '3'
    puts "Terima kasih!"
    break
  else
    puts "Pilihan tidak valid, silakan coba lagi."
  end

  if cost_matrix
    solver = TSP_DP.new(cost_matrix)
    min_cost, tour = solver.solve
    
    display_results(cost_matrix, min_cost, tour)
    save_results_to_file(cost_matrix, min_cost, tour, input_filename)
  end

  puts "\nTekan Enter untuk kembali ke menu..."
  gets 
end