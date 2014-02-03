require 'rspec'
require_relative '../lib/job'

describe Job do
  context "when input is an empty list" do
    it "should return a blank array" do
      job = Job.new("")
      expect(job.ordered).to eq([])
    end
  end

  context "when input is a single job" do
    it "should return an array with the job" do
      job = Job.new("a =>")
      expect(job.ordered).to eq(["a"])
    end
  end

  context "when giving a no dependency job list" do
    it "should return a sequence with all jobs no matter the order" do
      job = Job.new("a =>\nb =>\nc =>")
      expect(job.ordered).to eq(["a", "b", "c"])
    end
  end

  context "when giving a simple dependency job list" do
    it "should return a sequence with dependent job after its dependency" do
      job = Job.new("a =>\nb =>c\nc =>")
      expect(job.ordered.to_s).to match /c.*b/
    end
  end

  context "when giving a self dependency job list" do

  end
end