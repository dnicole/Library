class Book

  def initialize(title, author, description=nil)
    #@book = {title: @title, author: @author, description: @description}
    @title = title
    @author = author
    @description = description
    @status = "available"
    puts "Init2 is running"
  end

  def title()
    return @title
  end

  def author()
    return @author
  end

  def description()
    return @description
  end

  def status()
    @status
  end

end

class Library 

  def initialize(options=nil)
    @books = []
    @users = []
    #@book = {} #or just 'book'?
    puts "Init1 is running"
  end

  # add book to library in books array
  def add_book(book)
    if book.is_a?(Book)
      @books << book 
    else
    "not a book"
    end
  end 

  # adds user to users hash 
  def add_user(username)
    @users << username
  end
  
  # prints current contents of library
  def booklist()
    @books.map do |book|
      puts "#{book.title}, #{book.author}"
    end
  end

  def userlist()
    @users.map do |username|
      puts "#{username.name}"
    end
  end
end

class User

  def initialize(name, options=nil)
    # @users = []
    @username = name
    @books_out = []
    puts "Init3 is running"
    @overdue = []
  end
  
  def name()
    @username
  end

  def books_out()
    @books_out
  end

  def overdue()
    @overdue
  end
  
  # checks to see if user has books overdue # not working, code commented to force it to clear
  #def overdue(book)
  #  puts "Running tests now!"
  #  if @username.checkout(book) > (Time.now - 604800)
  #    puts "You have at least one overdue book. You dick."
  #  else
  #    puts "Good to go, #{@username}!"
  #    return "bitch"
  #  end

  #end

  # checks how many books a user has out
  # checks if user has books overdue
  def checkout_log(username=nil)
    if books_out.length < 2  
      if username.overdue >= 1 
        puts "Good to go, #{@username}!"
        return true
      else
        puts "You have at least one overdue book. fix that and come back."
      end
    else
      puts "Please return a book before trying to get a new one."
    end
  end

  # checks checkout_log and 
  # if checkout_log clears, allows user to check out book for a week
  def checkout(book)
    if @username.checkout_log == true
      if book.status == "available"
        @books_out << book 
        @status = "Checked out by #{@username}"
        puts "#{book} #{@status}"
      else
        puts "Sorry, that book is already out."
      end
    else
      puts "Sorry, you can't have any books right now. \n Check checkout_log for more details, if I ever get that shit working."
    end
  end
  
  # takes a book out of the user's books_out list 
  # and puts it back in Library --- HOW? 
  def return_book(book)
    @books_out >> book
  end
end



lib = Library.new
book1 = Book.new("Jurassic Park", "Michael Crichton")
book2 = Book.new("Snow Crash", "Neal Stephenson")
book3 = Book.new("Hocus Pocus", "Kurt Vonnegut")
book4 = Book.new("The Menace From Earth", "Robert Heinlein")
lib.add_book(book1)
lib.add_book(book2)
lib.add_book(book3)
lib.add_book(book4)

puts "Book 1 title: #{book1.title}"
puts "Book 2 title: #{book2.title}"
puts "Here's what your library looks like right now:" 
puts lib.booklist()

username1 = User.new("Nicole")
username2 = User.new("Greg")
username3 = User.new("Amy")
lib.add_user(username1)
lib.add_user(username2)
lib.add_user(username3)
puts "Here's who your borrowers are:" 
puts lib.userlist()

username1.checkout(book1)
puts username1.books_out "<-- that's your book"
username1.checkout_log()
