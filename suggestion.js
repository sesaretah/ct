var url = require('url');
var async = require('async');
var mysql      = require('mysql');
var pluralize = require('pluralize');
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
      callback(null, rows);
    });
  },
  function(arg1 , callback) {
    var i = 0
    async.each(arg1, function(row, cb) {
      var q = "SELECT * FROM profiles WHERE user_id =" + row.id
      connection.query(q, function (error, profile) {
        if (typeof profile[0] !== 'undefined'){
        var name =  profile[0].name + " " + profile[0].surename
      } else {
        var name = "user-" + row.id
      }
        people.push("user-" + row.id)
        g.setNode("user-" + row.id, {type: 'user', name: name, id: row.id});
        i = i + 1;
        if (arg1.length == i){
          console.log('Profiles Finished');
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
      console.log('Channel Finished');
      callback(null, 'Channel Finished');
    }
    var i = 0
    async.each(arg1, function(row, cb) {
      g.setNode("channel-" + row.id, {type: 'channel', name: row.name, id: row.id });
      i = i + 1;
      if (arg1.length == i){
        console.log('Channel Finished');
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
      console.log('Blog Finished');
      callback(null, 'Blog Finished');
    }
    var i = 0
    async.each(arg1, function(row, cb) {
      g.setNode("blog-" + row.id, {type: 'blog', name: row.title, id: row.id });
      i = i + 1;
      if (arg1.length == i){
        console.log('Blog Finished');
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
      console.log('Group Finished');
      callback(null, 'Group Finished');
    }
    var i = 0
    async.each(arg1, function(row, cb) {
      g.setNode("group-" + row.id, {type: 'group', name: row.name, id: row.id });
      i = i + 1;
      if (arg1.length == i){
        console.log('Group Finished');
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
      console.log('Event Finished');
      callback(null, 'Event Finished');
    }
    var i = 0
    async.each(arg1, function(row, cb) {
      g.setNode("event-" + row.id, {type: 'event', name: row.name, id: row.id });
      i = i + 1;
      if (arg1.length == i){
        console.log('Event Finished');
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
      console.log('Question Finished');
      callback(null, 'Question Finished');
    }
    var i = 0
    async.each(arg1, function(row, cb) {
      g.setNode("question-" + row.id, {type: 'question', name: row.title, id: row.id });
      i = i + 1;
      if (arg1.length == i){
        console.log('Question Finished');
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
      console.log('Project Finished');
      callback(null, 'Project Finished');
    }
    var i = 0
    async.each(arg1, function(row, cb) {
      g.setNode("project-" + row.id, {type: 'project', name: row.name, id: row.id });
      i = i + 1;
      if (arg1.length == i){
        console.log('Project Finished');
        callback(null, 'Project Finished');
      }
      cb();
    });
  },

  function(arg1, callback) {
    var sql = "SELECT * FROM offerings"
    connection.query(sql, function (error, rows) {
      console.log(rows);
      callback(null, rows);
    });
  },

  function(arg1, callback) {
    if (arg1.length == 0){
      console.log('Offering Finished');
      callback(null, 'Offering Finished');
    }
    var i = 0
    async.each(arg1, function(row, cb) {
      console.log(row.period + row.year);
      g.setNode("offering-" + row.id, {type: 'offering', name: row.period + row.year, id: row.id });
      i = i + 1;
      if (arg1.length == i){
        console.log('Offering Finished');
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
      console.log('Research Finished');
      callback(null, 'Research Finished');
    }
    var i = 0
    async.each(arg1, function(row, cb) {
      g.setNode("research-" + row.id, {type: 'research', name: row.name, id: row.id });
      i = i + 1;
      if (arg1.length == i){
        console.log('Research Finished');
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
      console.log('Lab Finished');
      callback(null, 'Lab Finished');
    }
    var i = 0
    async.each(arg1, function(row, cb) {
      g.setNode("lab-" + row.id, {type: 'lab', name: row.name, id: row.id });
      i = i + 1;
      if (arg1.length == i){
        console.log('Lab Finished');
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
      console.log('Involvement Finished');
      callback(null, 'Involvement Finished');
    }
    var i = 0
    async.each(arg1, function(row, cb) {
      var userid = row.user_id
      var channelid = row.channel_id
      g.setEdge("user-" + userid, "channel-"+ channelid, { type: 'involvement' });
      i = i + 1;
      if (arg1.length == i){
        console.log('Involvement Finished');
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
      console.log('Grouping Finished');
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
        console.log('Grouping Finished');
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
      console.log('Participation Finished');
      callback(null, 'Participation Finished');
    }
    var i = 0
    async.each(arg1, function(row, cb) {
      var userid = row.user_id
      var eventid = row.event_id
      g.setEdge("user-" + userid, "event-"+ eventid, { type: 'participation' });
      i = i + 1;
      if (arg1.length == i){
        console.log('Participation Finished');
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
      console.log('Followship Finished');
      callback(null, 'Followship Finished');
    }
    var i = 0
    async.each(arg1, function(row, cb) {
      switch (row.followable_type){
        case 'Question':
        g.setEdge("user-" + row.user_id, "question-"+ row.followable_id, { type: 'followship' });
        i = i + 1;
        if (arg1.length == i){
          console.log('Followship Finished');
          callback(null, 'Followship Finished');
        }
        cb();
        break;
        case 'Offering':
        g.setEdge("user-" + row.user_id, "offering-"+ row.followable_id, { type: 'followship' });
        i = i + 1;
        if (arg1.length == i){
          console.log('Followship Finished');
          callback(null, 'Followship Finished');
        }
        cb();
        break;
        case 'Lab':
        g.setEdge("user-" + row.user_id, "lab-"+ row.followable_id, { type: 'followship' });
        i = i + 1;
        if (arg1.length == i){
          console.log('Followship Finished');
          callback(null, 'Followship Finished');
        }
        cb();
        break;
        case 'Project':
        g.setEdge("user-" + row.user_id, "project-"+ row.followable_id, { type: 'followship' });
        i = i + 1;
        if (arg1.length == i){
          console.log('Followship Finished');
          callback(null, 'Followship Finished');
        }
        cb();
        break;
        case 'Research':
        g.setEdge("user-" + row.user_id, "research-"+ row.followable_id, { type: 'followship' });
        i = i + 1;
        if (arg1.length == i){
          console.log('Followship Finished');
          callback(null, 'Followship Finished');
        }
        cb();
        break;
        case 'Poll':
        g.setEdge("user-" + row.user_id, "research-"+ row.followable_id, { type: 'followship' });
        i = i + 1;
        if (arg1.length == i){
          console.log('Followship Finished');
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
      console.log('Friendship Finished');
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
        console.log('Friendship Finished');
        callback(null, 'Friendship Finished');
      }
      cb();
    });
  },

  function(arg1, callback) {
    var sql = "SELECT * FROM contributions"
    connection.query(sql, function (error, rows) {
      callback(null, rows);
    });
  },

  function(arg1, callback) {
    if (arg1.length == 0){
      console.log('Contribution Finished');
      callback(null, 'Contribution Finished');
    }
    var i = 0
    async.each(arg1, function(row, cb) {

      g.setEdge("user-" + row.user_id, "research-"+ row.research_id, { type: 'contribution' });
      //  g.setEdge("user-" + followeeid, "user-"+ followerid, { type: 'friendship' });
      i = i + 1;
      if (arg1.length == i){
        console.log('Contribution Finished');
        callback(null, 'Contribution Finished');
      }
      cb();
    });
  }



], function (err, result) {
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
  var n = ""
  var e = ""
  var nodes =   g.nodes()
  for (node in nodes){
//    if (typeof g.node(nodes[node]) !== 'undefined'){
    var edges = g.nodeEdges(nodes[node]);
    for (edge in edges) {
      if ( node == nodes.length - 1 && edge == edges.length - 1) {
       e = e + "{'target': '" +edges[edge].v+ "' , 'source' : '"+ edges[edge]. w+"'}"
      } else {
       e = e + "{'target': '" +edges[edge].v+ "' , 'source' : '"+ edges[edge]. w+"'},"
    }
    }
    if (nodes[node].split("-")[0] == 'research') {
      var p = 'researches'
    } else {
      var p = pluralize(nodes[node].split("-")[0])
    }
    if ( node == nodes.length - 1) {
      console.log(nodes[node].split("-")[1]);
      n = n + " { 'name': '" +  nodes[node] + "'," + "'id':'"+ g.node(nodes[node]).id + "','type':'"+ g.node(nodes[node]).type + "','title':'" + g.node(nodes[node]).name.replace("'"," ")  + "', 'href':" + "'/" + p + '/' + nodes[node].split("-")[1] + "'}"
      connection.query('INSERT INTO graphs SET ?', { nodes: n, edges: e }, function (error, results, fields) {
        if (error) throw error;
      });
    } else {
    //  console.log(nodes[node], g.node(nodes[node]));
     n = n + " { 'name':'" +  nodes[node] + "'," + "'id':'"+ g.node(nodes[node]).id +"','type':'"+ g.node(nodes[node]).type +"','title':'" + g.node(nodes[node]).name.replace("'"," ")  +"', 'href':" + "'/" + p + '/' + nodes[node].split("-")[1] + "'},"
   }
// }
}

});

function capitalizeFirstLetter(string) {
  return string.charAt(0).toUpperCase() + string.slice(1);
}
