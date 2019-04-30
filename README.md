# turboprepare

Bash scripts to run call automatically the define script os turbomole

```
USAGE: turboprepare -g geom.xyz [ -c MOLECULARCHARGE ] [ -b BASENAME ] [ -d FUNCNAME ] [-s]

 Automatically prepares the turbomole input for the geometry in geom.xyz
 -s epsilon for COSMO
     infinity for water
```
* FUNCNAME can be any valid functional name in turbomole between quotes if necessary (i.e. if there's is a special character in the name)
* BASENAME can be any valid basis set name in turbomole between quotes if necessary (i.e. if there's is a special character in the name)
