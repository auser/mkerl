require "rubygems"
require "ERB"
class Mkerl
  attr_reader :name, :root_dir, :version, :created_at
  # Generate a perfectly clean erlang structure
  def initialize(name, dir=Dir.pwd, version=0.1)
    @name = name
    @root_dir = dir
    @version = version
    @created_at = Time.now
  end
  
  def run
    make_dirs
    add_emakefile
    add_makefile
    add_appfile
    add_gitignore
    add_basic_files
  end
  
  def make_dirs
    FileUtils.mkdir_p(root_dir)
    %w(src test include).each do |dir|
      FileUtils.mkdir_p(File.join(root_dir, dir), :mode => 0755)
    end
    # Test dirs
    %w(src).each do |dir|
      FileUtils.mkdir_p(File.join(root_dir, "test", dir), :mode => 0755)
    end
    %w(ebin deps test/ebin test/fixtures).each do |dir|
      FileUtils.mkdir_p(File.join(root_dir, dir), :mode => 0755)
      FileUtils.touch(File.join(root_dir, dir, "empty"))
    end
  end
  
  def add_emakefile
    write_template_to("Emakefile")
  end
  
  def add_makefile
    write_template_to("Makefile")
  end
  
  def add_appfile
    write_template_to("app", File.join("ebin", "#{name}.app"))
  end
  
  def add_gitignore
    write_template_to("gitignore", ".gitignore")
  end
  
  def add_basic_files
    write_template_to("basic_file.erl", File.join("src", "#{name}.erl"))
    write_template_to("start.sh", "start.sh", :chmod => 0755)
    write_template_to("README.markdown")
    write_template_to("make_boot.erl", File.join("src", "make_boot.erl"))
    write_template_to("reloader.erl", File.join("src", "reloader.erl"))
    write_template_to("supervisor.erl", File.join("src", "#{name}_sup.erl"))
    write_template_to("the_app.erl", File.join("src", "#{name}_app.erl"))
    write_template_to("test_suite.erl", File.join("test", "src", "test_suite.erl"))
    write_template_to("basic_test.erl", File.join("test", "src", "#{name}_test.erl"))
  end
  
  # Private stuff
  private
  def write_template_to(template_file, dest=nil, opts={})
    data = template_from_file(template_file)
    destination = File.join(root_dir, dest.nil? ? template_file : dest)
    File.open(destination, 'w') {|f| f.write(data) }
    opts.each do |k,v|
      if k == :chmod
        FileUtils.chmod v, destination
      end
    end
  end
  def template_from_file(file)
    template = ERB.new open(File.join(File.dirname(__FILE__), "..", "templates", file)).read
    template.result(binding)
  end
end