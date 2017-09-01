var Crawler = require("crawler");
var url = require('url');
var async = require('async');
var cheerio = require('cheerio');
var mysql      = require('mysql');
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : 'salam64511',
  database : 'shoa2'
});

const express = require('express')
const app = express()

app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});

app.get('/', function (req, res) {
var edudata = [];
var perdata = [];
  var c = new Crawler({
      maxConnections : 1,
      // This will be called for each crawled page
      callback : function (error, r, done) {
          if(error){
              console.log(error);
          }else{
            //console.log(res);
            var $ = r.$;
            var edu = $('#activity-1 > ol > li');
            var per = $('#print_table  thead  tr');

            async.each(per, function(item, callback) {
              if (typeof item.children[3] !== 'undefined'){
                //var edudata = item.children[0].children[0].data.split(',')
                var persplit = item.children[3].children[0].data;
                perdata.push(persplit)
              } else {
                callback();
              }
            }, function(err) {
              if( err ) {
                console.log('A file failed to process');
              } else {
                console.log(' Per processed');
              }
            });

            async.each(edu, function(item, callback) {
              if (typeof item.children[0].children[0].data !== 'undefined'){
                var edusplit = item.children[0].children[0].data.split(',')
                edudata.push(edusplit)
              } else {
                callback();
              }
            }, function(err) {
              if( err ) {
                console.log('A file failed to process');
              } else {
                console.log(' Edu processed');
              }
            });
          }
          res.send({'edu': edudata, 'per': perdata});
          done();
      }
  });
  c.queue('https://rtis2.ut.ac.ir/cv/'+ req.query.name +'/print/');
});

app.get('/research', function (req, res) {
var utid = req.query.name;
var sql = 'SELECT * FROM researches where utid =' + mysql.escape(utid);
connection.query(sql, function (error, results, fields) {
  if (error) throw error;
  console.log(results);
});
});

app.listen(8080, function () {
  console.log('Example app listening on port 8080!')
})
