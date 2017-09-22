var Crawler = require("crawler");
var url = require('url');
var async = require('async');
var cheerio = require('cheerio');
var mysql      = require('mysql');
var axios =  require('axios');
var similarity = require("similarity");
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : 'salam64511',
  database : 'shoa2'
});

var connection1 = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : 'salam64511',
  database : 'shoa3'
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

app.get('/scholar', function (req, res) {
  var user_id =  req.query.user;
  var schid = req.query.name;
  console.log(schid);
  axios.get('https://scholar.google.com/citations?user='+schid+'&hl=en&cstart=0&pagesize=100')
  .then(function (response) {
    //console.log(response);
    var p = []
    var tags = []
    var bar = {}
    var citations = []

    var $ = cheerio.load(response.data);
    var prows = $('#gsc_a_t tbody tr');
    var trows = $('.gsc_prf_ila');
    var barleg = $('.gsc_g_t');
    var barval = $('.gsc_g_al');
    var ind = $('.gsc_rsb_std');
    var cap = $('.gsc_rsb_sth');

    async.series([
      function(cb) {
        async.each(prows, function(item, callback) {
          if(typeof item.type != 'undefined' && item.type == 'tag' &&
          item.children[0].children[0].data != 'There are no articles in this profile.'){
            var link = item.children[0].children[0].attribs.href
            var title = item.children[0].children[0].children[0].data
            var authors = item.children[0].children[1].children[0].data
            var publisher = ''
            var year = ''
            if (typeof item.children[0].children[2].children[1] != 'undefined'){
              var publisher = item.children[0].children[2].children[0].data
              var year = item.children[0].children[2].children[1].children[0].data
            }
            var t = {'similar': '','link': link , 'title' : title, 'authors' : authors, 'publisher' : JSON.stringify(publisher), 'year' : parseInt(year.replace(', ', ''))}
            p.push(t);
            callback();
          } else {
            callback();
          }
        }, function(err) {
          if( err ) {
            console.log('A file failed to process');
          } else {
            console.log(' Prows processed');
            cb();
          }
        });
      },
      function(cb) {
        var sql = "SELECT `researches`.* FROM `researches` INNER JOIN `contributions` ON `researches`.`id` = `contributions`.`research_id` WHERE `contributions`.`user_id` =" + mysql.escape(user_id);
        //console.log(sql);
        connection1.query(sql, function (error, rows) {
          if (error) throw error;
          for(var i in p){
            for( var r in rows){
              if (similarity(rows[r].name, p[i].title) > 0.8){
                p[i].similar = rows[r].id
              }
            }
            if (i == p.length - 1){
              console.log('cb');
              cb ();
            }
          }
        });
      },
      function(cb) {
        for (var i in trows) {
          if (typeof trows[i].children != 'undefined' && typeof trows[i].children[0] != 'undefined' && trows[i].children[0].type == 'text' ){
            tags.push(trows[i].children[0].data);
          }
          if (i == trows.length - 1){
            console.log('cb');
            cb ();
          }
        }
      },
      function(cb) {
        for (var i in barleg) {
          if (typeof barleg[i].children != 'undefined' && typeof barleg[i].children[0] != 'undefined' && barleg[i].children[0].type == 'text' ){
            bar[barleg[i].children[0].data] = barval[i].children[0].data
          }
          if (i == barleg.length - 1){
            console.log('cb');
            cb ();
          }
        }
      },
      function(cb) {
        for (var i in ind) {
          if (typeof ind[i].children != 'undefined' && typeof ind[i].children[0] != 'undefined' && ind[i].children[0].type == 'text' ){
            citations.push(ind[i].children[0].data);
          }
          if (i == ind.length - 1){
            console.log('cb');
            cb ();
          }
        }
      }
    ],

    // optional callback
    function(err, results) {
      var results = {'papers': p , 'tags' : tags, 'bar' : bar, 'citations': citations}
      res.send(results);
    });
  })
  .catch(function (error) {
    console.log(error);
  });
});


app.get('/research', function (req, res) {
  var utid = req.query.name;
  var researches = [];
  var sql = 'SELECT * FROM researches where utid =' + mysql.escape(utid);
  connection.query(sql, function (error, rows) {
    if (error) throw error;
    console.log(rows);
    res.send(rows);
    //  console.log(results);
  });
});

app.listen(8090, function () {
  console.log('Example app listening on port 8080!')
})
