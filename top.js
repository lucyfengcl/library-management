var mysql = require('mysql'); // MySQL module on node.js

var connection = mysql.createConnection({
    host     : 'localhost',
    port     : 3306,
    user     : 'tester',
    password : '1234',
    database : 'library',
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

var key =1001
// "node app.js" running on port 3000
app.listen(3000, function () {
	console.log('Example app listening on port 3000!');
});

// base url action: "http://localhost/" -> send "index.html" file.
app.get('/', function (req, res) {
	res.sendFile(__dirname + "/main.html");
});

app.get('/topbook', function (req, res) {
	res.sendFile(__dirname + "/topbook.html");
});

app.get('/topreader', function (req, res) {
	res.sendFile(__dirname + "/topreader.html");
});

app.get('/borrowlist', function (req, res) {
	res.sendFile(__dirname + "/borrowlist.html");
});

app.get('/returnbook', function (req, res) {
	res.sendFile(__dirname + "/returnbook.html");
});

//methods

app.get('/topbookAPI', function (req, res) {
	/*console.log(req.body);*/
	connection.query('select * from book  order by BorrowingTimes DESC limit 10', function (err, rows) {
		if (err) throw err;
		console.log(rows); 
		/*res.sendfile(__dirname + "/" +"main.html");*/
	})
});

app.get('/topreaderAPI', function (req, res) {
	/*console.log(req.body);*/
	var statement= 'select StudentName, TotalBorrowingTimes, Major from library.borrowcard, library.student where SID=ID order by TotalBorrowingTimes Desc limit 10;'
	connection.query(statement, function (err, rows) {
		if (err) throw err;
		/*res.send(rows);*/
		console.log(rows); 
		res.sendfile(__dirname + "/" +"main.html");
	})
});


app.get('/returnAPI', function (req, res) {
	/*console.log(req.body);*/
	var statement = 'select BookName from book b1, borrowrecord b2,booklist b3 where b2.CID = '+key+' and b2.State=0 and b2.BarCode=b3.BarCode and b3.ISBN=b1.ISBN;'
	connection.query(statement, function (err, rows) {
		if (err) throw err;
		/*res.send(rows);*/
		console.log(rows); 
		res.sendfile(__dirname + "/" +"main.html");
	})
});

app.post('/returnbookAPI', function (req, res) {
	/*console.log(req.body);*/
	var statement = 'update borrowrecord set State=1 , ReturnDate = current_date() where CID='+key+';'
	connection.query(statement, function (err, rows) {
		if (err) throw err;
		/*res.send(rows);*/
		console.log(rows); 
		res.sendfile(__dirname + "/" +"main.html");
	})
	
});


app.get('/borrowlistAPI', function (req, res) {
	/*console.log(req.body);*/
	var statement = 'select BookName from book b1, borrowrecord b2,booklist b3 where b2.CID = '+key+' and b2.BarCode=b3.BarCode and b3.ISBN=b1.ISBN;'
	connection.query(statement, function (err, rows) {
		if (err) throw err;
		/*res.send(rows);*/
		console.log(rows); 
		res.sendfile(__dirname + "/" +"main.html");
	})
});
