# wrapping functions

* Účelem chartu je sdílet několik základních funkcí mezi více charty
* obsahuje pouze `templates/_helpers.tpl`


## funkce

### `common.name`
* vstupy
  * `.Chart.Name`
  * `.Values.nameOverride`
* `nameOverride` může přepsat `.Chart.Name`

### `common.chart`
* concats `.Chart.Name` a `.Chart.Version`

### `common.fullname`
* vstupy
  * `.Values.fullnameOverride`
  * `.Release.Name`
  * `common.name` 
  * `fullnameOverride`
* výstup
  * concat `.Release.Name`-`common.name`
  * pokud zadám `fullnameOverride`, použije se místo výše uvedeného

### `common.labels`
* definuje základní labels

### `common.password`
* generování hesel pro secrets. 
