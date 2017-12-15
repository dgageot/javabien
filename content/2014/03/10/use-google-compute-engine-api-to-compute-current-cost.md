---
title: "Use Google Compute Engine Api to calculate current cost"
date: 2014-03-10T12:00:00+01:00
tags: ["atom","coffeescript","google","gce"]
---

A nice thing with cloud providers who provide an Api is that you can come up with new features by yourself. You don't need to wait for the next release anymore.

As soon as I tried Google Compute Engine, I wanted to know the daily/monthly cost of what I was doing. My question was simple:

<blockquote>
  "If I leave things as they are, right now, how much will it cost me this month?"
</blockquote>

So I wrote some code, because, you know, it's what I do ;-) Also it was a good excuse to try <a href="https://atom.io/">Atom</a>'s support for CoffeeScript. To be more precise, I tried Atom's support for literate CoffeeScript but that's a post for tomorrow!

Here's the first version of my code. It doesn't compute the whole cost. There's still a lot to do. Also, I'm sure it contains bugs, so no warranty!

The code tells you what's you daily and monthly burn rate.


```coffee
# Google Compute Engine Cost Calculation

This code computes the current hourly and monthly cost of a project on [Google Compute Engine](https://cloud.google.com/products/compute-engine/).
It uses this [pricing page](https://developers.google.com/compute/pricing)
as the reference.

## Read raw json files

Read all the files produced by `gcutil`. Then turn each file content into json.

    fs = require 'fs'

    read = (file) ->
      content = fs.readFileSync "data/#{file}.json", {encoding: 'UTF-8'}
      JSON.parse(content).items

## Cost computation

    class CostComputer
      constructor: (data) ->
        @count = {}
        @count[key] = value.length for key,value of data

        @cost = 0.0
        @cost += @instanceCost(instance) for instance in data.instances
        @cost += @diskCost(disk) for disk in data.disks
        @cost += @snapshotCost(snapshot) for snapshot in data.snapshots

## Machine Type Pricing

Each type of none-`TERMINATED` instance has a specific hourly cost. [Source](https://developers.google.com/compute/pricing#machinetype)

      instanceCost: (instance) ->
        return 0 if instance.status is 'TERMINATED'

        switch @type(instance.machineType)
          when 'n1-standard-1' then 0.104
          when 'n1-standard-2' then 0.207
          when 'n1-standard-4' then 0.415
          when 'n1-standard-8' then 0.829
          when 'n1-standard-16' then 1.659
          else throw "Unknown machine type #{instance.machineType}"

      type: (machineType) ->
              machineType.split('/').last()

## Persistent Disk Pricing

There's a monthly cost per Gb used. [Source](https://developers.google.com/compute/pricing#persistentdisk)

### Disks

      diskCost: (disk) ->
        @daily(disk.sizeGb * 0.04)

### Snapshots

      snapshotCost: (snapshot) ->
        @daily(snapshot.diskSizeGb * 0.125)

## Monthly cost

It's currently just an approximation.

      monthly: (daily) ->
        daily * (24 * 31) # pessimist

      daily: (monthly) ->
        monthly / (24 * 30) # pessimist

## Report

Print hourly and monthly cost and the number of moving parts used (instances,
disks, snapshots...).

      print: -> console.log """
        Current cost is:
         - $#{@cost} per hour
         - $#{@monthly(@cost)} per month

        For:
         - #{@count.instances} instance(s)
         - #{@count.disks} disk(s)
         - #{@count.snapshots} snapshot(s)

        """

## Misc

Extend Array class to be able to get its last value:

    Array::last ?= (n) ->
      if n? then @[(Math.max @length - n, 0)...] else @[@length - 1]

## Feed the CostComputer

    new CostComputer
      instances: read 'listinstances'
      disks: read 'listdisks'
      snapshots: read 'listsnapshots'
    .print()

## TODO

There's still a lot to be done:

 + [x] Machine Type Pricing [Source](https://developers.google.com/compute/pricing#machinetype)
 + [x] Persistent Disk Pricing [Source](https://developers.google.com/compute/pricing#persistentdisk)
 + [ ] Premium Operating Systems [Source](https://developers.google.com/compute/pricing#premiumoperatingsystems)
 + [ ] Network Pricing [Source](https://developers.google.com/compute/pricing#network)
 + [ ] Load Balancing and Protocol Forwarding [Source](https://developers.google.com/compute/pricing#network)
 + [ ] Image Storage [Source](https://developers.google.com/compute/pricing#imagestorage)
 + [ ] IP Address Pricing [Source](https://developers.google.com/compute/pricing#ipaddress)
```
