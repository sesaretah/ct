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

var d = new Crawler({
  maxConnections : 10,
  // This will be called for each crawled page
  callback : function (error, res, done) {
    if(error){
      console.log(error);
    }else{
      var $ = res.$;
      // $ is Cheerio by default
      //a lean implementation of core jQuery designed specifically for the server
      //console.log(res.request.uri.path.split('/')[3]);
      var head = $('#print_table > thead > tr');
      var edu = $('#activity-1 > ol > li');
      var tag = $('#activity-2 > ol > li');
      var thesis = $('#activity-4 > ol > li');
      var thesisadv = $('#activity-5 > ol > li');
      var intcont = $('#activity-6 > ol > li'); //international contributions
      var op = $('#activity-7 > ol > li');
      var book = $('#activity-10 > ol > li');
      var booktr = $('#activity-11 > ol > li'); // book translation
      var jr = $('#activity-13 > ol > li');
      var irjr = $('#activity-14 > ol > li');
      var con = $('#activity-15 > ol > li');
      var ircon = $('#activity-16 > ol > li');
      //console.log(head[6].children[3].children[0].data)
      async.series([

        function(cb) {
          async.each(edu, function(item, callback) {
            if (typeof item.children[0].children[0].data !== 'undefined'){
              var edudata = item.children[0].children[0].data.split(',')
              connection.query('INSERT INTO educations SET ?', {grade: edudata[0], end_year: edudata[1], field: edudata[2], name: edudata[3], utid: res.request.uri.path.split('/')[2] }, function (error, results, fields) {
                if (error) throw error;
                callback();
              });
            } else {
              callback();
            }
          }, function(err) {
            if( err ) {
              console.log('A file failed to process');
            } else {
              console.log(res.request.uri.path.split('/')[2] + '  Edu processed');
            }
          });
          cb(null, 'edu');
        },
        function(cb) {
          async.each(tag, function(item, callback) {
            //console.log(item.children[0].children[0].data);
            callback();
          }, function(err) {
            if( err ) {
              console.log('A file failed to process');
            } else {
              console.log(res.request.uri.path.split('/')[2] + '  Tag processed');
            }
          });
          cb(null, 'tag');
        },

        function(cb) {
          async.each(thesis, function(item, callback) {
            if (typeof item.children[0].children[0].data !== 'undefined'){
              var jrdata = item.children[0].children[0].data.split('،')

              if (typeof jrdata[5] == 'undefined'){
                var title = jrdata[0].substring(0, 200);
                var student =  jrdata[1].substring(0, 200);
                var thesis_type =  jrdata[2].substring(0, 200);
                var faculty =  jrdata[3].substring(0, 200);
                var tdate = jrdata[4];
                var supervisor_utid = res.request.uri.path.split('/')[2]

                connection.query('INSERT INTO theses SET ?', {title: title, student: student, thesis_type: thesis_type, faculty: faculty, tdate: tdate, supervisor_utid: res.request.uri.path.split('/')[2] }, function (error, results, fields) {
                  if (error) throw error;
                  callback();
                });
              } else {
                callback();
              }
            } else {
              callback();
            }

          }, function(err) {
            if( err ) {
              console.log('A file failed to process');
            } else {
              console.log(res.request.uri.path.split('/')[2] + '  thesis processed');
            }
          });
          cb(null, 'thesis');
        },

        function(cb) {
          async.each(thesisadv, function(item, callback) {
            if (typeof item.children[0].children[0].data !== 'undefined'){
              var jrdata = item.children[0].children[0].data.split('،')
              if (typeof jrdata[5] == 'undefined'){
                var title = jrdata[0].substring(0, 200);
                var student =  jrdata[1].substring(0, 200);
                var thesis_type =  jrdata[2].substring(0, 200);
                var faculty =  jrdata[3].substring(0, 200);
                var tdate = jrdata[4];
                var advisor_utid = res.request.uri.path.split('/')[2]

                connection.query('INSERT INTO theses SET ?', {title: title, student: student, thesis_type: thesis_type, faculty: faculty, tdate: tdate, advisor_utid: res.request.uri.path.split('/')[2] }, function (error, results, fields) {
                  if (error) throw error;
                  callback();
                });

              } else {
                callback();
              }
            } else {
              callback();
            }
          }, function(err) {
            if( err ) {
              console.log('A file failed to process');
            } else {
              console.log(res.request.uri.path.split('/')[2] + '  thesisadv processed');
            }
          });
          cb(null, 'thesisadv');
        },

        function(cb) {
          async.each(intcont, function(item, callback) {
            //console.log(item.children[0].children[0].data);
            callback();
          }, function(err) {
            if( err ) {
              console.log('A file failed to process');
            } else {
              console.log(res.request.uri.path.split('/')[2] + '  intcont processed');
            }
          });
          cb(null, 'intcont');
        },


        function(cb) {
          async.each(book, function(item, callback) {
            if (typeof item.children[0].children[0].data !== 'undefined'){
              var jrdata = item.children[0].children[0].data.split('"')
            }else {
              var jrdata = item.children[0].children[0].children[0].data.split('"')
            }
            if (typeof jrdata[2] !== 'undefined' && typeof jrdata[2].split(':')[1]!== 'undefined'){
              if (jrdata[2].indexOf('،') > -1){
                var city = jrdata[2].split(':')[0]
                var publisher = jrdata[2].split(':')[1].split('،')[0]
                if (typeof jrdata[2].split(':')[1].split('،')[1] != 'undefined'){
                  var pub_year = parseInt(jrdata[2].split(':')[1].split('،')[1].replace(".", " "));
                  if (isNaN(pub_year)){
                    pub_year = 0;
                  }}else{
                    pub_year = 0;
                  }
                } else {
                  var city = jrdata[2].split(':')[0]
                  var publisher = jrdata[2].split(':')[1].split(',')[0]
                  if (typeof jrdata[2].split(':')[1].split('،')[1]  != 'undefined'){
                    var pub_year = parseInt(jrdata[2].split(':')[1].split(',')[1].replace(".", " "));
                    if (isNaN(pub_year)){
                      pub_year = 0;
                    }}else{
                      pub_year = 0;
                    }
                  }
                  var title = jrdata[1].replace(".", " ").substring(0, 200);
                  var authors = jrdata[0].replace(".", " ").substring(0, 200);

                  connection.query('INSERT INTO books SET ?', {title: title, publisher: publisher, city: city, pub_year: pub_year, authors: authors, utid: res.request.uri.path.split('/')[2] }, function (error, results, fields) {
                    if (error) throw error;
                    callback();
                  });

                } else {
                  callback();
                }
              }, function(err) {
                if( err ) {
                  console.log('A file failed to process');
                } else {
                  console.log(res.request.uri.path.split('/')[2] + '  book processed');
                }
              });
              cb(null, 'book');
            },


            function(cb) {
              async.each(booktr, function(item, callback) {
                if (typeof item.children[0].children[0].data !== 'undefined'){
                  var jrdata = item.children[0].children[0].data.split('"')
                }else {
                  var jrdata = item.children[0].children[0].children[0].data.split('"')
                }
                if (typeof jrdata[2] != 'undefined' && typeof jrdata[2].split(':')[1] != 'undefined'){
                  if (jrdata[2].indexOf('،') > -1){
                    var city = jrdata[2].split(':')[0]
                    var publisher = jrdata[2].split(':')[1].split('،')[0]
                    if (typeof jrdata[2].split(':')[1].split('،')[1] != 'undefined'){
                      var pub_year = parseInt(jrdata[2].split(':')[1].split('،')[1].replace(".", " "));
                      if (isNaN(pub_year)){
                        pub_year = 0;
                      }}else{
                        pub_year = 0;
                      }
                    } else {
                      var city = jrdata[2].split(':')[0]
                      var publisher = jrdata[2].split(':')[1].split(',')[0]
                      if (typeof jrdata[2].split(':')[1].split('،')[1] != 'undefined'){
                        var pub_year = parseInt(jrdata[2].split(':')[1].split(',')[1].replace(".", " "));
                        if (isNaN(pub_year)){
                          pub_year = 0;
                        }}else{
                          pub_year = 0;
                        }
                      }
                      var title = jrdata[1].replace(".", " ");
                      var authors = jrdata[0].replace(".", " ");

                      connection.query('INSERT INTO books SET ?', {title: title, publisher: publisher, city: city, pub_year: pub_year, authors: authors, utid: res.request.uri.path.split('/')[2] }, function (error, results, fields) {
                        if (error) throw error;
                        callback();
                      });
                    } else {
                      callback();
                    }
                  }, function(err) {
                    if( err ) {
                      console.log('A file failed to process');
                    } else {
                      console.log(res.request.uri.path.split('/')[2] + '  booktr processed');
                    }
                  });
                  cb(null, 'booktr');
                },

                function(cb) {
                  async.each(op, function(item, callback) {
                    if (typeof item.children[0].children[0].data !== 'undefined'){
                      var opdata = item.children[0].children[0].data.split('،')
                      if(typeof opdata[2] !== 'undefined'){
                        if (opdata[2].indexOf('/') > -1){}
                        else{
                          opdata = [opdata[0], opdata[1], ' ' ,opdata[2], opdata[3]]
                        }

                        connection.query('INSERT INTO operacts SET ?', {title: opdata[0], start_date_j: opdata[1], end_date_j: opdata[2], country: opdata[3], city: opdata[4], utid: res.request.uri.path.split('/')[2] }, function (error, results, fields) {
                          if (error) throw error;
                          callback();
                        });
                      }
                    }else {
                      callback();
                    }
                  }, function(err) {
                    if( err ) {
                      console.log('A file failed to process');
                    } else {
                      console.log(res.request.uri.path.split('/')[2] + ' op  processed');
                    }
                  });
                  cb(null, 'op');
                },

                function(cb) {
                  async.each(jr, function(item, callback) {
                    if (typeof item.children[0].children[0].data !== 'undefined'){
                      var jrdata = item.children[0].children[0].data.split('"')
                    }else {
                      var jrdata = item.children[0].children[0].children[0].data.split('"')
                    }
                    var regExp = /\(([^)]+)\)/;
                    if ( regExp.exec(jrdata[2]) !== null ){
                      if (jrdata[2].includes('no')){
                        var regExp = /\(([^)]+)\)/;
                        var pub_year = parseInt(regExp.exec(jrdata[2])[1]);
                        if (isNaN(pub_year)){
                          pub_year = 0;
                        }
                        var pp = jrdata[2].substr(jrdata[2].indexOf(":") + 1).replace(".", " ").replace("و", " ");
                        var title = jrdata[1].replace(".", " ");
                        var pub_name = jrdata[2].split(',')[0];
                        var pub_type = 'Journal'
                        var pub_authors = jrdata[0].replace(".", " ")

                        connection.query('INSERT INTO researches SET ?', {pub_year: pub_year, pp: pp, name: title, pub_name: pub_name, pub_type: pub_type, pub_authors: pub_authors, utid: res.request.uri.path.split('/')[2] }, function (error, results, fields) {
                          if (error) throw error;
                          callback();
                        });
                      } else {
                        var regExp = /\(([^)]+)\)/;
                        var pub_year = parseInt(regExp.exec(jrdata[2])[1]);
                        if (isNaN(pub_year)){
                          pub_year = 0;
                        }
                        var pp = jrdata[2].substr(jrdata[2].indexOf(":") + 1).replace(".", " ").replace("و", " ");
                        var title = jrdata[1].replace(".", " ");
                        var pub_name = jrdata[2].split('،')[0].replace("-", ".");
                        var pub_type = 'مجله'
                        var pub_authors = jrdata[0].replace(".", " ")

                        connection.query('INSERT INTO researches SET ?', {pub_year: pub_year, pp: pp, name: title, pub_name: pub_name, pub_type: pub_type, pub_authors: pub_authors, utid: res.request.uri.path.split('/')[2] }, function (error, results, fields) {
                          if (error) throw error;
                          callback();
                        });
                      }
                    }


                  }, function(err) {
                    if( err ) {
                      console.log('A file failed to process');
                    } else {
                      console.log(res.request.uri.path.split('/')[2] + '  jr processed');
                    }
                  });
                  cb(null, 'jr');
                },

                function(cb) {
                  async.each(irjr, function(item, callback) {
                    if (typeof item.children[0].children[0].data !== 'undefined'){
                      var jrdata = item.children[0].children[0].data.split('"')
                    }else {
                      var jrdata = item.children[0].children[0].children[0].data.split('"')
                    }
                    if ( jrdata[2] === null){
                      var regExp = /\(([^)]+)\)/;
                      var pub_year = parseInt(regExp.exec(jrdata[2])[1]);
                      if (isNaN(pub_year)){
                        pub_year = 0;
                      }
                      var pp = jrdata[2].substr(jrdata[2].indexOf(":") + 1).replace(".", " ").replace("و", " ");
                      var title = jrdata[1].replace(".", " ");
                      var pub_name = jrdata[2].split('،')[0].replace("-", ".");
                      var pub_type = 'مجله'
                      var pub_authors = jrdata[0].replace(".", " ")
                      connection.query('INSERT INTO researches SET ?', {pub_year: pub_year, pp: pp, name: title, pub_name: pub_name, pub_type: pub_type, pub_authors: pub_authors, utid: res.request.uri.path.split('/')[2] }, function (error, results, fields) {
                        if (error) throw error;
                        callback();
                      });
                    }
                  }, function(err) {
                    if( err ) {
                      console.log('A file failed to process');
                    } else {
                      console.log(res.request.uri.path.split('/')[2] + ' irjr  processed');
                    }
                  });
                  cb(null, 'irjr');
                },

                function(cb) {
                  async.each(con, function(item, callback) {
                    if (typeof item.children[0].children[0].data !== 'undefined'){
                      var jrdata = item.children[0].children[0].data.split('"')
                    }else {
                      var jrdata = item.children[0].children[0].children[0].data.split('"')
                    }
                    if (typeof jrdata[2] !== 'undefined'){
                      if (jrdata[2].indexOf('،') > -1)
                      {
                        var temp = jrdata[2].split('،')
                        var pub_name = jrdata[2].split('،')[0].replace("-", ".");
                        var pub_type = 'کنفرانس'
                      } else {
                        var temp = jrdata[2].split(',')
                        var pub_name = jrdata[2].split(',')[0].replace("-", ".");
                        var pub_type = 'Confrence'
                      }
                      if (typeof temp[3] !== 'undefined'){
                        var pub_year = parseInt(temp[3].replace(".", " "));
                        if (isNaN(pub_year)){
                          pub_year = 0;
                        }} else {
                          pub_year = 0;
                        }
                        var title = jrdata[1].replace(".", " ");
                        var pub_authors = jrdata[0].replace(".", " ")

                        connection.query('INSERT INTO researches SET ?', {pub_year: pub_year, name: title, pub_name: pub_name, pub_type: pub_type, pub_authors: pub_authors, utid: res.request.uri.path.split('/')[2] }, function (error, results, fields) {
                          if (error) throw error;
                          callback();
                        });
                      }
                    }, function(err) {
                      if( err ) {
                        console.log('A file failed to process');
                      } else {
                        console.log(res.request.uri.path.split('/')[2] + ' con  processed');
                      }
                    });
                    cb(null, 'con');
                  },

                  function(cb) {
                    async.each(ircon, function(item, callback) {
                      if (typeof item.children[0].children[0].data !== 'undefined'){
                        var jrdata = item.children[0].children[0].data.split('"')
                      }else {
                        var jrdata = item.children[0].children[0].children[0].data.split('"')
                      }
                      if (typeof jrdata[2] !== 'undefined'){
                        if (jrdata[2].indexOf('،') > -1)
                        {
                          var temp = jrdata[2].split('،')
                          var pub_name = jrdata[2].split('،')[0].replace("-", ".");
                          var pub_type = 'کنفرانس'
                        } else {
                          var temp = jrdata[2].split(',')
                          var pub_name = jrdata[2].split(',')[0].replace("-", ".");
                          var pub_type = 'Confrence'
                        }
                        if (typeof temp[3] !== 'undefined'){
                          var pub_year = parseInt(temp[3].replace(".", " "));
                          if (isNaN(pub_year)){
                            pub_year = 0;
                          }} else {
                            pub_year = 0;
                          }
                          var title = jrdata[1].replace(".", " ");
                          var pub_authors = jrdata[0].replace(".", " ")

                          connection.query('INSERT INTO researches SET ?', {pub_year: pub_year, name: title, pub_name: pub_name, pub_type: pub_type, pub_authors: pub_authors, utid: res.request.uri.path.split('/')[2] }, function (error, results, fields) {
                            if (error) throw error;
                            callback();
                          });
                        } else {
                          callback();
                        }
                      }, function(err) {
                        if( err ) {
                          console.log('A file failed to process');
                        } else {
                          console.log(res.request.uri.path.split('/')[2] + ' ircon  processed');
                        }
                      });
                      cb(null, 'ircon');
                    }

                  ],
                  // optional callback
                  function(err, results) {
                    //console.log(results);
                  });



                  console.log('>>>>>>>>>>>>>>>>>>');
                }
                done();
              }
            });


            var c = new Crawler({
              maxConnections : 10,
              // This will be called for each crawled page
              callback : function (error, res, done) {
                if(error){
                  console.log(error);
                }else{
                  var $ = res.$;
                  // $ is Cheerio by default
                  //a lean implementation of core jQuery designed specifically for the server
                  //console.log($("title").text());
                  var rows = $('.table.table-striped.table-bordered.responsive-table > tbody > tr');
                  //console.log(rows);
                  for (i=0;i<20;i++){
                    if (typeof rows[i] !== 'undefined' &&
                    typeof  rows[i].children[0].children[0].children !== 'undefined' &&
                    typeof rows[i].children[1].children[0].children !== 'undefined'

                  ) {

                    //console.log('name:'+ rows[i].children[1].children[0].children[0].data);
                    //console.log('surename:' + rows[i].children[0].children[0].children[0].data);
                    //console.log('url:' + rows[i].children[0].children[0].attribs.href);
                    var url = rows[i].children[0].children[0].attribs.href;
                    var index = url.lastIndexOf("/");
                    var print = 'https://rtis2.ut.ac.ir/cv' + url.substr(index) + '/print/';
                    d.queue(print);
                    //console.log('faculty:' + rows[i].children[2].children[0].data);
                    //console.log('rank:' + rows[i].children[3].children[0].data);
                    //console.log('url:' + rows[i].children[0].children[0].children[0].data);
                    //console.log('------\n');
                  }
                }
              }
              done();
            }
          });

          for (i=1;i<104;i++){
            c.queue('http://ut.ac.ir/fa/faculty?page='+ i);
          }
