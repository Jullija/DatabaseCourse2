/////////////////1a///////////////////////
use('businessDB');

db.business.find(
  {
  categories: "Restaurants",
  "hours.Monday": {$exists: true},
  stars: {$gte: 4}
  },
  {
    name: true,
    full_address: true,
    categories: true,
    hours: true,
    stars: true,
  }
).sort({"name": 1});

/////////////////1b///////////////////////
db.business.aggregate(
    {
      $match: {
        $or: [
          {categories: "Hotels & Travel"},
          {categories: "Hotels"}
        ]
      }
    },
    {
      $group:{
        _id: "$city",
        hotelsCounter: {$sum:1}
      }
    },
    {
      $sort: {hotelsCounter: 1}
    }
  )

/////////////////1c///////////////////////
db.tip.aggregate(
    {
      $match: {date: /2012/}
    },
    {
      $group: {
        _id: "$business_id",
        count: {$sum: 1}
      }
    },
    {
      $sort: {count: 1}
    }
  )
  
/////////////////1d///////////////////////
use('reviewDB');

db.review1.aggregate([
  {
    $group: {
      _id: null,
      cool: {
        $sum:{
          $cond: [{$gt: ["$votes.cool", 0]}, 1, 0]
        }
      },
      useful: {
        $sum:{
          $cond: [{$gt: ["$votes.useful", 0]}, 1, 0]
        }
      },
      funny: {
        $sum:{
          $cond: [{$gt: ["$votes.funny", 0]}, 1, 0]
        }
      }
    }
  },
  {
    $project:{
      _id: 0,
      cool: 1, 
      useful: 1, 
      funny: 1
    }
  }
])


/////////////////1e///////////////////////
use('userDB');

db.user.find(
  {
    $and:[
      {"votes.funny": {$eq: 0}},
      {"votes.useful": {$eq: 0}}
    ]
  },
  {
    _id: false,
    name: true,
    "votes.funny": true,
    "votes.useful": true
  }
).sort({"name": 1})

/////////////////1f1///////////////////////
use('reviewDB');

db.review1.aggregate([
  {
    $group: {
      _id: "$business_id",
      avg: {$avg: "$stars"}
    }
  },
  {
    $match:{
      avg: {$gt: 3}
    }
  },
  {
    $sort: {
      _id: 1
    }
  }
])


/////////////////1f2///////////////////////
use('reviewDB');

db.review1.aggregate([
  {
    $limit: 200
  },
  {
    $lookup:{
      from: "business",
      localField: "business_id",
      foreignField: "business_id",
      as: "company"
    }
  },
  {
    $unwind: "$company"
  },
  {
    $group: {
      _id: "$company.name",
      avg: {$avg: "$stars"}
    }
  },
  {
    $match:{
      avg: {$gt: 3}
    }
  },
  {
    $sort: {
      _id: 1
    }
  }
])









