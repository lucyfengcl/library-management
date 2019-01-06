var mysql = require('mysql'); // MySQL module on node.js

var connection = mysql.createConnection({
    host     : 'localhost',
    port     : 3306,
    user     : 'tester',
    password : '1234',
    database : 'mydb',
});

connection.connect(); // Connection to MySQL

var express = require('express');
var app = express();

var bodyParser = require('body-parser')
app.use('/', express.static(__dirname + '/public')); // you may put public js, css, html files if you want...
app.use( bodyParser.json() );       // to support JSON-encoded bodies
app.use(bodyParser.urlencoded({     // to support URL-encoded bodies
  extended: true
})); 

// "node app.js" running on port 3000
app.listen(3000, function () {
	console.log('Example app listening on port 3000!');
});

// base url action: "http://localhost/" -> send "index.html" file.
app.get('/', function (req, res) {
	res.sendFile(__dirname + "/main.html");
});


app.get('/topbookAPI', function (req, res) {
	connection.query('select * from book  order by BorrowingTimes DESC', function (err, rows) {
		if (err) throw err;
		res.send(rows);
	})
});

app.get('/topreaderAPI', function (req, res) {
	var statement= 'select b.StudentName, b.TotalBorrowTimes, s.Major from borrowcard AS b, student AS s where b.SID in (select sid from borrowcard order by BorrowingTimes DESC) and s.SID = b.SID'
	connection.query(statement, function (err, rows) {
		if (err) throw err;
		res.send(rows);
	})
});


app.get('/aggregation', function (req, res) {
    res.sendFile(__dirname + "/aggregation.html");
});

app.get('/borrowlistAPI', function (req, res) {
	var statement = 'select bo.BookName from book bo, booklist b1 where b1.CID = '+key+' and b1.ISBN=bo.ISBN'
	connection.query(statement, function (err, rows) {
		if (err) throw err;
		res.send(rows);
	})
});
