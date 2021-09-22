cd..
type .\md_utils\title.md ^
..\README.md ^
.\md_utils\index.md ^
coreografie.md ^
BPMN.md ^
coreografieBPMN.md ^
UML.md ^
struttura.md ^
esecuzione.md ^
.\md_utils\servizi.md ^
..\src\ACMEskyService\README.md ^
..\src\ACMEskyDB\README.md ^
..\src\ACMEskyWeb\README.md ^
..\src\AirlineService\README.md ^
..\src\BankService\README.md ^
..\src\Prontogram\README.md ^
..\src\RentService\README.md ^
..\src\GeographicalDistanceService\README.md > documentazione.md
call npx md-to-pdf documentazione.md
move documentazione.pdf ..\documentazione.pdf