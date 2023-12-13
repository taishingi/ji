# Ji

```bash
dub add ji
```

![ji-output](https://raw.githubusercontent.com/taishingi/ji/master/ji.gif)

## How to use

```d
import unit;

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
  return u.ok(&ok)
          .ko(&ko)
          .directory_exists("/")
          .is_absolute("/dev")
          .is_rooted("/dev")
          .is_valid_path(".")
          .is_valid_file("dub.json")
          .theory("Must be equal to 42", true, &ok)
          .chaos("Must match false", &ko);
 }

 Unit u = new Unit;
 int x = u.describe("All test should be pass", &all).end();
 assert(x == 0);
}
```
