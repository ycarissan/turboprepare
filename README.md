# turboprepare

Bash scripts to run call automatically the define script of the turbomole (http://www.turbomole-gmbh.com/)

**Please note that this project does not involve the turbomole team at all.

```
USAGE: turboprepare -g geom.xyz [ -c MOLECULARCHARGE ] [ -b BASENAME ] [ -d FUNCNAME ] [-s]

 Automatically prepares the turbomole input for the geometry in geom.xyz
 -s epsilon for COSMO
     infinity for water
```
* geom.xyz: xyz file describing one geometry
* MOLECULARCHARGE: molecular charge as a signed integer
* FUNCNAME: can be any valid functional name in turbomole between quotes if necessary (i.e. if there's is a special character in the name)
* BASENAME: can be any valid basis set name in turbomole between quotes if necessary (i.e. if there's is a special character in the name)
* epsilon: value of epsilon to be used in COSMO

Symmetry is handled automatically
