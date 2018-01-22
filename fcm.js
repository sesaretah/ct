var admin = require('firebase-admin');

curl -i -H 'Content-type: application/json' -H 'Authorization: key=AIzaSyA7YB90hmjPUlCpxLRBvqPlqPQYvs42AZ4' -XPOST https://fcm.googleapis.com/fcm/send -d '{
  "registration_ids":[""eZ7ToPUNIbY:APA91bHy0GARaXsz3tAa3zBvDxPiKpPHkb28E8HjAr80tAUp2ec-f3-DjXyuw7uDiKty9TYdZdpITHwFxbZ7tEk4AsgmuhKNw6Gko7NTK9iphCwlyBXxiP0Nfximfoubi1S7kHdZpr13"],"notification": {"title": "group","body":"تسیبتایسبت"},"data": { "key1" : "value1"}}'



curl -i -H 'Content-type: application/json' -H 'Authorization: key=AIzaSyA7YB90hmjPUlCpxLRBvqPlqPQYvs42AZ4' -XPOST https://fcm.googleapis.com/fcm/send -d '{
  "registration_ids":["eZ7ToPUNIbY:APA91bHy0GARaXsz3tAa3zBvDxPiKpPHkb28E8HjAr80tAUp2ec-f3-DjXyuw7uDiKty9TYdZdpITHwFxbZ7tEk4AsgmuhKNw6Gko7NTK9iphCwlyBXxiP0Nfximfoubi1S7kHdZpr13"],
  "notification": {
      "title":"تست",
      "body":"لباسیلاتیب الباسلاتی"
  },
  "data": {
    "key1" : "value1",
    "key2" : "value2",
    "key3" : 23.56565,
    "key4" : true
  }
}'
