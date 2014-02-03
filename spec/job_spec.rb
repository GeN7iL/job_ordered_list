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

  context "when giving a dependency job list" do
    it "should return a sequence with dependent job after its dependency" do
      job = Job.new("a =>\nb =>c\nc =>")
      expect(job.ordered.to_s).to match /c.*b/

      job2 = Job.new("a =>\nb => c\nc => f\nd => a\ne => b\nf =>")
      expect(job2.ordered.to_s).to match /f.*c/
      expect(job2.ordered.to_s).to match /c.*b/
      expect(job2.ordered.to_s).to match /b.*e/
      expect(job2.ordered.to_s).to match /a.*d/
    end
  end

  context "when giving a circular dependency job list" do
    it "should raise an exception" do
      pending
    end
  end

  context "when giving a self dependency job list" do
    it "should raise an exception" do
      pending
    end
  end
end