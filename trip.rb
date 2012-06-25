=begin
program:	trip.rb
function:	An implementation of 2channel-style tripcodes in Ruby.
				Takes name and tripcode-key in a single UTF-8 encoded string, seperated by "#" and returns an array of [name, tripcode].
				This algorithm follows the de-facto-standard, ignoring the escaping of characters to their HTML-counterpart
				(Which means that generated tripcodes might not be compatible with the original 2channel-software.).
autor:		Alexander Nowack
version:		1.0
=end

def trip(namekey)
	namekey.encode( "SHIFT_JIS", "UTF-8") 
	name, key =* namekey.split("#")	
	salt = key[1..2]
	salt.gsub(/[^\.-z]/,".")
	salt.tr(":;<=>?@[\]^_`", "ABCDEFGabcdef")
	return [name, key.crypt(salt)[-10..-1]] #crypt uses the OS-native crypt-function, so this might not work on Windows.
	end

if __FILE__ == $0 #Only do stuff if this script is executed, not used as a library.
	puts trip($*[0])
	end