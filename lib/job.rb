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
    i = 0
    while i < job_array.count do
      if dependent = get_dependent(job_array[i], job_array[i+1..job_array.count])
        raise CircularDependencyError, "Jobs can't have circular dependencies" unless get_dependent(dependent, job_array[i..job_array.index(dependent)]).nil?
        job_array.delete_at(job_array.index(dependent))
        job_array.unshift(dependent)
        i = -1 
      end
      i += 1
    end
    job_array
  end

  def get_dependent(job_node, job_array)
    return @rules.select{|job| job[0] == job_node}.first[1] if job_array.include?(@rules.select{|job| job[0] == job_node}.first[1])
  end
end