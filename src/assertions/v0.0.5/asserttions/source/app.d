module ji.assertions;
import std.stdio;
import std.file;
import std.string;
import std.algorithm;
import std.path;
import colorize;
import std.system;
import core.stdc.stdlib;

/// A class to run assertions test
class Assert
{

private:
	/// Assertions counter
	int assertions = 0;
	/// Failures counter 
	int failures = 0;

	/// 
	/// Params:
	///   t = The test to run
	///   s = The success output message
	///   f = The failure output message
	/// Returns: Assert
	Assert run(bool t, const(char)[] s, const(char)[] f)
	{
		if (t)
		{
			this.assertions++;
			cwrite("[ ✓ ] ".color(fg.green));
			cwritefln("%s".color(fg.blue), s);
		}
		else
		{
			this.failures++;
			cwrite("[ + ] ".color(fg.red));
			cwritefln("%s".color(fg.red), f);
			abort();
		}
		return this;
	}

public:
	/// Check if the callback return true
	/// Params:
	///   t = The callback to test
	/// Returns: Assert
	Assert ok(bool delegate() t)
	{
		return this.run(t(), "The test match true", "The test match false");
	}

	/// Check if the callback return false
	/// Params:
	///   t = The callback to test
	/// Returns: Assert
	Assert ko(bool delegate() t)
	{
		return this.run(!t(), "The test match false", "The test match true");
	}

	/// Check if ther source contains needle
	/// Params:
	///   source = The source to check
	///   needle = The value to find
	/// Returns: Assert
	Assert contains(string source, string needle)
	{
		return this.run(!find(source, needle).empty, "The value has been founded", "The value has not been fouded");
	}

	/// Check if the string finnish by the expected value
	/// Params:
	///   source = The value to check
	///   expected = The end expected value
	/// Returns: 
	Assert finnish(const(char)[] source, const(char)[] expected)
	{
		return this.run(
			endsWith(source, expected),
			"The string finnish by the expected value", "The end no match expected value");
	}

	/// Check if a string statrt by the expected value
	/// Params:
	///   source = The value to check
	///   expected = Teh begin expected value
	/// Returns: 
	Assert begin(const(char)[] source, const(char)[] expected)
	{
		return this.run(
			startsWith(source, expected),
			"The string begin with the expected value", "The begin no match expected value");
	}

	/// Check if ther source contains needle
	/// Params:
	///   source = The source to check
	///   needle = The value to find
	/// Returns: Assert
	Assert no_contains(string source, string needle)
	{
		return this.run(find(source, needle).empty, "The value has been founded", "The value has not been fouded");
	}

	/// Check if the file exist
	/// Params:
	///   f = The file path
	/// Returns: Assert
	Assert file_exists(const(char)[] f)
	{
		return this.run(isFile(f), "The file exists", "The file not exist");
	}

	/// Checkk if the directory exist
	/// Params:
	///   d = The directory path
	/// Returns: Assert
	Assert directory_exists(const(char)[] d)
	{
		return this.run(isDir(d), "The path is a directory", "The path is not a directory");
	}

	/// Check if the path is absolute
	/// Params:
	///   p = The path to test
	/// Returns: Assert
	Assert is_absolute(const(char)[] p)
	{
		return this.run(isAbsolute(p), "The path is asbolute", "The path is not absolute");
	}

	/// Check if the path is rooted
	/// Params:
	///   p = the path to check
	/// Returns: Assert
	Assert is_rooted(const(char)[] p)
	{
		return this.run(isRooted(p), "The path is rooted", "The path is not rooted");
	}

	/// Check if the path is valid
	/// Params:
	///   p = The path to check
	/// Returns: Assert
	Assert is_valid_path(const(char)[] p)
	{
		return this.run(isValidPath(p), "The path is valid", "The path is not valid");
	}

	/// Check if a file is valid
	/// Params:
	///   f = The file to check
	/// Returns: Assert
	Assert is_valid_file(const(char)[] f)
	{
		return this.run(isValidFilename(f), "The filename is valid", "The filenameis invalid");

	}

	/// Group tests
	/// Params:
	///   description = The test group description
	///   it = The callback to execute
	/// Returns: Assert
	Assert describe(const(char)[] description, Assert delegate(Assert) it)
	{
		cwritefln("\n%s".color(fg.magenta), description);
		writeln();
		return it(this);
	}

	/// Check a theory
	/// Params:
	///   description = The theory description
	///   expected = The xpected result
	///   it = The callback to execute
	/// Returns: Assert
	Assert theory(const(char)[] description, bool expected, bool delegate() it)
	{
		cwritefln("\n%s".color(fg.magenta), description);
		writeln();
		return this.run(expected == it(), "The theory is true", "The theory is false");
	}

	/// 
	/// Params:
	///   description = The theory description
	///   it = The ccallback to execute
	/// Returns: Assert
	Assert chaos(const(char)[] description, bool delegate() it)
	{
		return this.theory(description, false, it);
	}

	/// Show asertion and failures
	/// Returns: The status code
	int end()
	{
		writeln();
		cwrite("Assertion : ".color(fg.blue));
		cwritefln("%d".color(fg.green), this.assertions);
		cwrite("Failures  : ".color(fg.blue));
		cwritefln("%d".color(fg.red), this.failures);
		writeln();
		return this.failures > 0 ? 1 : 0;
	}
}

unittest
{
	
	bool ok()
	{
		return 40 + 2 == 42;
	}

	bool ko()
	{
		return 40 == 42;
	}

	Assert all(Assert u)
	{
		return u.ok(&ok).ko(&ko).directory_exists("/")
			.is_absolute("/dev")
			.is_rooted("/dev").is_valid_path(".").is_valid_file("dub.json")
			.theory("Must be equal to 42", true, &ok)
			.chaos("Must match false", &ko).contains("I love linux", "linux")
			.no_contains("i love linux", "windows").finnish("i love linux", "linux").begin(
				"linux is better than windows", "linux");
	}

	Assert a = new Assert;
	const int x = a.describe("All test must be pass", &all).end();
	assert(x == 0);
}
