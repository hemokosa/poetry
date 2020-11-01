var RandExp = require('randexp'); //パッケージの呼び出し

code = "441[~=]+";
console.log(new RandExp(code).gen());

code = "441[~~^==Z]+";
console.log(new RandExp(code).gen());

code = "441([~~^==Z][*/]1\\.25)+";
console.log(new RandExp(code).gen());

code = "\\d{3}([~~^==Z][*/]1\\.25)+";
console.log(new RandExp(code).gen());

code = "[1-9][0-9][0-9]([~~N^=====][+-]10)+";
console.log(new RandExp(code).gen());

code = "[1-9][0-9][0-9]([~~N^=====][*/]1\\.[0-9])+";
console.log(new RandExp(code).gen());
