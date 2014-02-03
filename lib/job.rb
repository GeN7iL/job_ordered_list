class Job
  class SelfDependencyError < StandardError; end  
  class CircularDependencyError < StandardError; end

  def initialize(jobs_input)
  end

  def parse(input)
  end

  def first_order
  end

  def order(job_array)
  end

  def get_dependent(job_node, job_array)
  end
end