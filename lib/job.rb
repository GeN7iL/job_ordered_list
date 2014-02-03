class Job
  class SelfDependencyError < StandardError; end  
  class CircularDependencyError < StandardError; end

  attr_accessor :ordered
  attr_accessor :rules

  def initialize(jobs_input)
    parse(jobs_input)
    @ordered = order(first_order)
  end

  def parse(input)
    @rules = input.scan(/(\w*) => ?(\w*)/)
    raise SelfDependencyError, "Jobs cannot depend on themselves" unless @rules.select{|job, dependency| job == dependency}.empty?
  end

  def first_order
    return @rules.map{|node| node[0]}
  end

  def order(job_array)
    job_array.each do |job_node|      
    end
    job_array
  end

  def get_dependent(job_node, job_array)
  end
end