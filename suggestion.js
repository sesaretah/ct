var url = require('url');
var async = require('async');
var mysql      = require('mysql');
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : 'salam64511',
  database : 'shoa3'
});
var Graph = require("graphlib").Graph;
var Alg = require("graphlib").alg;
var g = new Graph({ directed: true });
var people = []

async.waterfall([
  function(callback) {
    var sql = "SELECT username, id FROM users"
    connection.query(sql, function (error, rows) {
      console.log(rows);
      callback(null, rows);
    });
  },
  function(arg1 , callback) {
    var i = 0
    async.each(arg1, function(row, cb) {
      var q = "SELECT * FROM profiles WHERE user_id =" + row.id
      connection.query(q, function (error, profile) {
        var name =  profile.name + profile.surename
        people.push("user-" + row.id)
        g.setNode("user-" + row.id, {type: 'user', name: name });
        i = i + 1;
        if (arg1.length == i){
          callback(null, 'Profiles Finished');
        }
        cb();
      });
    });
  },
  function(arg1, callback) {
    var sql = "SELECT * FROM channels"
    connection.query(sql, function (error, rows) {
      callback(null, rows);
    });
  },

  function(arg1, callback) {
    if (arg1.length == 0){
      callback(null, 'Channel Finished');
    }
    var i = 0
    async.each(arg1, function(row, cb) {
      g.setNode("channel-" + row.id, {type: 'channel', name: row.name });
      i = i + 1;
      if (arg1.length == i){
        callback(null, 'Channel Finished');
      }
      cb();
    });
  },

  function(arg1, callback) {
    var sql = "SELECT * FROM blogs"
    connection.query(sql, function (error, rows) {
      callback(null, rows);
    });
  },

  function(arg1, callback) {
    if (arg1.length == 0){
      callback(null, 'Blog Finished');
    }
    var i = 0
    async.each(arg1, function(row, cb) {
      g.setNode("blog-" + row.id, {type: 'blog', name: row.name });
      i = i + 1;
      if (arg1.length == i){
        callback(null, 'Blog Finished');
      }
      cb();
    });
  },

  function(arg1, callback) {
    var sql = "SELECT * FROM groups"
    connection.query(sql, function (error, rows) {
      callback(null, rows);
    });
  },

  function(arg1, callback) {
    if (arg1.length == 0){
      callback(null, 'Group Finished');
    }
    var i = 0
    async.each(arg1, function(row, cb) {
      g.setNode("group-" + row.id, {type: 'group', name: row.name });
      i = i + 1;
      if (arg1.length == i){
        callback(null, 'Group Finished');
      }
      cb();
    });
  },

  function(arg1, callback) {
    var sql = "SELECT * FROM events"
    connection.query(sql, function (error, rows) {
      callback(null, rows);
    });
  },

  function(arg1, callback) {
    if (arg1.length == 0){
      callback(null, 'Event Finished');
    }
    var i = 0
    async.each(arg1, function(row, cb) {
      g.setNode("event-" + row.id, {type: 'event', name: row.name });
      i = i + 1;
      if (arg1.length == i){
        callback(null, 'Event Finished');
      }
      cb();
    });
  },

  function(arg1, callback) {
    var sql = "SELECT * FROM questions"
    connection.query(sql, function (error, rows) {
      callback(null, rows);
    });
  },

  function(arg1, callback) {
    if (arg1.length == 0){
      callback(null, 'Question Finished');
    }
    var i = 0
    async.each(arg1, function(row, cb) {
      g.setNode("question-" + row.id, {type: 'question', name: row.name });
      i = i + 1;
      if (arg1.length == i){
        callback(null, 'Question Finished');
      }
      cb();
    });
  },

  function(arg1, callback) {
    var sql = "SELECT * FROM projects"
    connection.query(sql, function (error, rows) {
      callback(null, rows);
    });
  },

  function(arg1, callback) {
    if (arg1.length == 0){
      callback(null, 'Project Finished');
    }
    var i = 0
    async.each(arg1, function(row, cb) {
      g.setNode("project-" + row.id, {type: 'project', name: row.name });
      i = i + 1;
      if (arg1.length == i){
        callback(null, 'Project Finished');
      }
      cb();
    });
  },

  function(arg1, callback) {
    var sql = "SELECT * FROM offerings"
    connection.query(sql, function (error, rows) {
      callback(null, rows);
    });
  },

  function(arg1, callback) {
    if (arg1.length == 0){
      callback(null, 'Offering Finished');
    }
    var i = 0
    async.each(arg1, function(row, cb) {
      g.setNode("offering-" + row.id, {type: 'offering', name: row.period + row.year });
      i = i + 1;
      if (arg1.length == i){
        callback(null, 'Offering Finished');
      }
      cb();
    });
  },

  function(arg1, callback) {
    var sql = "SELECT * FROM researches"
    connection.query(sql, function (error, rows) {
      callback(null, rows);
    });
  },

  function(arg1, callback) {
    if (arg1.length == 0){
      callback(null, 'Research Finished');
    }
    var i = 0
    async.each(arg1, function(row, cb) {
      g.setNode("research-" + row.id, {type: 'research', name: row.name });
      i = i + 1;
      if (arg1.length == i){
        callback(null, 'Research Finished');
      }
      cb();
    });
  },

  function(arg1, callback) {
    var sql = "SELECT * FROM labs"
    connection.query(sql, function (error, rows) {
      callback(null, rows);
    });
  },

  function(arg1, callback) {
    if (arg1.length == 0){
      callback(null, 'Lab Finished');
    }
    var i = 0
    async.each(arg1, function(row, cb) {
      g.setNode("lab-" + row.id, {type: 'lab', name: row.name });
      i = i + 1;
      if (arg1.length == i){
        callback(null, 'Lab Finished');
      }
      cb();
    });
  },

  function(arg1, callback) {
    var sql = "SELECT * FROM involvements"
    connection.query(sql, function (error, rows) {
      callback(null, rows);
    });
  },

  function(arg1, callback) {
    if (arg1.length == 0){
      callback(null, 'Involvement Finished');
    }
    var i = 0
    async.each(arg1, function(row, cb) {
      var userid = row.user_id
      var channelid = row.channel_id
      g.setEdge("user-" + userid, "channel-"+ channelid, { type: 'involvement' });
      i = i + 1;
      if (arg1.length == i){
        callback(null, 'Involvement Finished');
      }
      cb();
    });
  },

  function(arg1, callback) {
    var sql = "SELECT * FROM groupings"
    connection.query(sql, function (error, rows) {
      callback(null, rows);
    });
  },

  function(arg1, callback) {
    if (arg1.length == 0){
      callback(null, 'Grouping Finished');
    }
    var i = 0
    async.each(arg1, function(row, cb) {
      var userid = row.user_id
      var groupid = row.group_id
      g.setEdge("user-" + userid, "group-"+ groupid, { type: 'grouping' });
      g.setEdge("group-"+ groupid, "user-" + userid, { type: 'grouping' });
      i = i + 1;
      if (arg1.length == i){
        callback(null, 'Grouping Finished');
      }
      cb();
    });
  },

  function(arg1, callback) {
    var sql = "SELECT * FROM participations"
    connection.query(sql, function (error, rows) {
      callback(null, rows);
    });
  },

  function(arg1, callback) {
    if (arg1.length == 0){
      callback(null, 'Participation Finished');
    }
    var i = 0
    async.each(arg1, function(row, cb) {
      var userid = row.user_id
      var eventid = row.event_id
      g.setEdge("user-" + userid, "event-"+ eventid, { type: 'participation' });
      i = i + 1;
      if (arg1.length == i){
        callback(null, 'Participation Finished');
      }
      cb();
    });
  },

  function(arg1, callback) {
    var sql = "SELECT * FROM followships"
    connection.query(sql, function (error, rows) {
      callback(null, rows);
    });
  },

  function(arg1, callback) {
    if (arg1.length == 0){
      callback(null, 'Followship Finished');
    }
    var i = 0
    async.each(arg1, function(row, cb) {
      switch (row.followable_type){
        case 'Question':
        g.setEdge("user-" + row.user_id, "question-"+ row.followable_id, { type: 'followship' });
        i = i + 1;
        if (arg1.length == i){
          callback(null, 'Followship Finished');
        }
        cb();
        break;
        case 'Offering':
        g.setEdge("user-" + row.user_id, "offering-"+ row.followable_id, { type: 'followship' });
        i = i + 1;
        if (arg1.length == i){
          callback(null, 'Followship Finished');
        }
        cb();
        break;
        case 'Lab':
        g.setEdge("user-" + row.user_id, "lab-"+ row.followable_id, { type: 'followship' });
        i = i + 1;
        if (arg1.length == i){
          callback(null, 'Followship Finished');
        }
        cb();
        break;
        case 'Project':
        g.setEdge("user-" + row.user_id, "project-"+ row.followable_id, { type: 'followship' });
        i = i + 1;
        if (arg1.length == i){
          callback(null, 'Followship Finished');
        }
        cb();
        break;
        case 'Research':
        g.setEdge("user-" + row.user_id, "research-"+ row.followable_id, { type: 'followship' });
        i = i + 1;
        if (arg1.length == i){
          callback(null, 'Followship Finished');
        }
        cb();
        break;
      }
    });
  },

  function(arg1, callback) {
    var sql = "SELECT * FROM friendships"
    connection.query(sql, function (error, rows) {
      callback(null, rows);
    });
  },

  function(arg1, callback) {
    if (arg1.length == 0){
      callback(null, 'Friendship Finished');
    }
    var i = 0
    async.each(arg1, function(row, cb) {
      var followerid = row.user_id
      var followeeid = row.friend_id
      g.setEdge("user-" + followerid, "user-"+ followeeid, { type: 'friendship' });
      //  g.setEdge("user-" + followeeid, "user-"+ followerid, { type: 'friendship' });
      i = i + 1;
      if (arg1.length == i){
        callback(null, 'Friendship Finished');
      }
      cb();
    });
  }



], function (err, result) {
  console.log(g.nodes());
  function weight(e) { return g.edge(e); }
  async.each(people, function(p, cb) {
    var i = 0
    var d = Alg.dijkstra(g, p)
    Object.keys(d).forEach(function (key) {
      var value = d[key]
      i = i + 1;
      if (d.length == i){
        cb();
      }
      if (value.distance == 2){
        var user_id = p.split("-")[1];
        var suggested_type = key.split("-")[0];
        var suggested_id = key.split("-")[1];
        var why_type = value.predecessor.split("-")[0];
        var why_id = value.predecessor.split("-")[1];
        //console.log(user_id, capitalizeFirstLetter(suggested_type), suggested_id, capitalizeFirstLetter(why_type), why_id);
        connection.query('TRUNCATE suggestions', function (error, results, fields) {
          if (error) throw error;
          connection.query('INSERT INTO suggestions SET ?', { user_id: user_id, suggested_type: capitalizeFirstLetter(suggested_type),  suggested_id: suggested_id, why_type: capitalizeFirstLetter(why_type), why_id: why_id}, function (error, results, fields) {
            if (error) throw error;
          });
        });

        //console.log(key, value);
      }
    });
  });
});

function capitalizeFirstLetter(string) {
  return string.charAt(0).toUpperCase() + string.slice(1);
}
