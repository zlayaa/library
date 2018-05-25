require "yaml"
require_relative '../lib/author.rb'
require_relative '../lib/book.rb'
require_relative '../lib/order.rb'
require_relative '../lib/reader.rb'
class Library
  
  attr_accessor :books, :orders, :readers, :authors

  def initialize(books, orders, readers, authors)
      @library = [@books = [], @orders = [], @readers = [], @authors = []]
  end      
  
  def load
    @library = YAML.load_file("../yaml/library.yml") || 
    File.new("../yaml/library.yml", "w+")
  end

  def save
    File.open("../yaml/library.yml", "r+") do |f|
      f.write(@library.to_yaml)
    end
  end
 
  def add_book(book)
    @books << book 
    @books.uniq!
  end

  def add_order(order)
    @orders << order 
  end

  def add_reader(reader)
   @readers << reader 
   @readers.uniq!
  end

  def add_author(author)
    @authors << author 
    @authors.uniq!
  end

   
  def most_popular_book
    hash_books!
    best_book = @hash.max_by {|key, value| value}.first
    puts "Most popular book: #{best_book}"
      
  end
  
  
  def most_active_reader
    hash_readers!
    best_reader = @hash1.max_by {|key, value| key}.first
    puts "Most active reader: #{best_reader}"
      
  end
     
  private 
     
  def hash_books!
      @hash = @orders.inject(Hash.new(0)) do |count, order|
      count[order.book.title] += 1
      count
      end 
  end
    
  def hash_readers!
    
    @hash1 = @orders.inject(Hash.new(0)) do |count, order|
    count[order.reader.name] = count[order.reader.name] + 1 unless order.reader.nil?
    count
    end
  end
  
end  
  
  
  


