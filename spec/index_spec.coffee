"use strict"

chai = require "chai"
expect = chai.expect

KeyValueConverter = require "index"
Base = require "amo.modules.base"

describe "KeyValueConverter", ->
  it "should be subclass of amo.modules.Base", ->
    expect(KeyValueConverter.__super__).to.be.equal Base.prototype

  describe "its instance", ->
    obj = null
    beforeEach ->
      obj = KeyValueConverter.create()

    it "should have convert property", ->
      expect(obj).to.have.property "convert"

    data = [
      ["", "aa%a%aa", {a: "hoge"}, "aahogeaa"]
      ["", "a%a%a%a", {a: "hoge"}, "ahogea%a"]
      ["", "a%a%a%a%a", {a: "hoge"}, "ahogeahogea"]
      ["dict 内に無い key は無視される", "_%a%_%b%_", {a: "hoge"}, "_hoge_%b%_"]
      ["key が src に現れなくとも良い", "_%a%_%a%_", {a: "hoge", b: "fuga"}, "_hoge_hoge_"]
      ["key が複数合っても良い", "_%a%_%b%_", {a: "hoge", b: "fuga"}, "_hoge_fuga_"]
      ["key の順序は重要でない", "_%b%_%a%_", {a: "hoge", b: "fuga"}, "_fuga_hoge_"]
      ["key は入れ子にできる", "_%a.x%_%a.y%_", {a: {x: "hoge", y: "fuga"}}, "_hoge_fuga_"]
    ]

    for d, idx in data
      do ([name, src, dict, expected] = d, i = idx) ->
        s = if name.length > 0 then ": #{name}" else ""
        it "should convert[#{i}]#{s}", ->
          expect(obj.convert src, dict).to.be.equal expected




