module ji.unit;
import std.stdio;
import std.file;

import std.path;
import colorize;

class Unit
{

private:
	int assertions = 0;
	int failures = 0;

	Unit run(bool t, const(char)[] s, const(char)[] f)
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
			cwrite("[ ☠ ] ".color(fg.red));
			cwritefln("%s".color(fg.red), f);
		}
		return this;
	}

public:

	Unit ok(bool t)
	{
		return this.run(t, "The test match true", "The test match false");
	}

	Unit ko(bool t)
	{
		return this.run(!t, "The test match false", "The test match true");
	}

	Unit file_exists(const(char)[] f)
	{
		return this.run(isFile(f), "The file exists", "The file not exist");
	}

	Unit directory_exists(const(char)[] d)
	{
		return this.run(isDir(d), "The path is a directory", "The path is not a directory");
	}

	Unit is_absolute(const(char)[] p)
	{
		return this.run(isAbsolute(p), "The path is asbolute", "The path is not absolute");
	}

	Unit is_rooted(const(char)[] p)
	{
		return this.run(isRooted(p), "The path is rooted", "The path is not rooted");
	}

	Unit is_valid_path(const(char)[] p)
	{
		return this.run(isValidPath(p), "The path is valid", "The path is not valid");
	}

	Unit is_valid_file(const(char)[] f)
	{
		return this.run(isValidFilename(f), "The filename is valid", "The filenameis invalid");

	}

	Unit describe(const(char)[] description, Unit delegate(Unit) it)
	{
		cwritefln("\n%s".color(fg.magenta), description);
		writeln();
		return it(this);
	}

	Unit theory(const(char)[] description, bool expected, bool delegate() it)
	{
		cwritefln("\n%s".color(fg.magenta), description);
		writeln();
		return this.run(expected == it(), "The theory is true", "The theory is false");
	}

	Unit chaos(const(char)[] description, bool delegate() it)
	{
		cwritefln("\n%s".color(fg.magenta), description);
		writeln();
		return this.run(!it(), "The theory is false", "The theory is true");
	}

	void end()
	{
		writeln();
		cwrite("Assertion : ".color(fg.blue));
		cwritefln("%d".color(fg.green), this.assertions);
		cwrite("Failures  : ".color(fg.blue));
		cwritefln("%d".color(fg.red), this.failures);
		writeln();
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

	Unit all(Unit u)
	{
		return u.ok(true).ko(false).directory_exists("/").is_absolute("/dev")
			.is_rooted("/dev").is_valid_path(".").is_valid_file("dub.json")
			.theory("Must be equal to 42", true, &ok).chaos("Must match false", &ko);
	}

	Unit u = new Unit;
	u.describe("All test should be pass", &all).end();
}
