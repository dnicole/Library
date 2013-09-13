# Library
#   Collection of books
#   Collection of users

# Book
#   Author
#   Title  
#   Description
#   Status
#   Due Date 
#   who has it checked out

# User
#   Name 
#   Collection of Books 

class Book
  attr_accessor :title, :author, :description, :status, :due_date, :renter
  def initialize(title) # add in args from attr_reader?
    @title = title
    @author = author
    @description = description
    @status = "Checked In"
    @due_date = nil  
    @renter = nil
  end  


  def status()
    if !@due_date.nil? and Time.now > @due_date
      @status = "Overdue"
    end

    case @status
     when "Checked Out"
       puts "#{@title} is currently checked out!"
     when "Overdue"
       puts "#{title} is overdue!"
     else
       puts "#{title} is checked in." 
    end

    @status
  end

end

# u = User.new("Nicole")
# u.name => Nicole
# u.books_rented => []

class User
  attr_accessor :books_rented 
  attr_reader :name
  def initialize(name)
    @name = name
    @books_rented = []
  end

  def add_book(book)
    @books_rented << book
  end

  # returns true if user has rented less than 2 books and
  # has no overdue books
  def can_rent_books? # if a method will return true or false, put a ? instead of ()
    @books_rented.each do |b|
      if b.status == "Overdue"
        return false
      end
    end

    @books_rented.count < 2  
  end

  def check_overdue
    @books_rented.each do |b| 
      return "#{b.to_s} is overdue" if b.status == "Overdue" 
    end
  end
end
# Library.new -- note no arguments in initialize,
# which is why the @ can be an empty array

class Library
  def initialize
    @books = []
    @users = []
  end

  def add_book(book)
    if book.is_a?(Book)
      @books << book 
    else
      "not a book"
    end
  end 
  
  def add_user(user)
    @users << user
  end

  def checkout_book(user, book)
    if user.can_rent_books? && book.status == "Checked In" # make new method instead of complicated && stuff - also let it be in User class 
      book.status = "Checked Out"
      book.due_date = Time.now + 604800 
      book.renter = user.name #user from method arg, .name = instance of User class
      user.add_book(book) # .book comes from attr_accessor in User class
    else
      puts "cannot check out #{book.title}" # retrieves name of book
    end
  end

  def checkin_book(user, book)
    book.status = "Checked In"
    book.due_date = nil
    book.renter = nil
    user.books_rented.delete(book) #no need to put it back in library, it only had its status changed within the library
  end
  
  def has_what(user)
    user.books_rented.collect do |book|
      "#{book.title} is due back at #{book.due_date}"
    end
  end

end

b = Book.new("Snow Crash")
puts b.title
u1 = User.new("Nicole")
library = Library.new
library.add_book(b)
library.add_user(u1)
puts u1.can_rent_books?
library.checkout_book(u1, b)
puts b.status 
puts library.has_what(u1)
puts u1.check_overdue