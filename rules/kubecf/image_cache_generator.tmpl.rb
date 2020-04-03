#!/usr/bin/env ruby

# frozen_string_literal: true

# This is a template script to be used by the 'image_cache_generator' Bazel rule.

require 'json'
require 'open3'
require 'stringio'
require 'tmpdir'

# Variable interpolation via Bazel template expansion.
image_list_file = '[[image_list_file]]'
docker = '[[docker]]'
workspace_root_file = '[[workspace_root_file]]'
output_relative_path = '[[output_relative_path]]'

image_list = File.open(image_list_file, "r") do |f|
  json = JSON.parse(f.read)
  json['images']
end

output = StringIO.new

output << "# GENERATED FILE. DO NOT MODIFY!\n\n"

output << "load(\n"
output << "    \"@io_bazel_rules_docker//container:container.bzl\",\n"
output << "    \"container_pull\",\n"
output << ")\n\n"

output << "def image_repositories():\n"

def name_from_repository(repository)
  repository.gsub('/', '_').gsub('.', '_').gsub('-', '_')
end

class Image
  def initialize(image, docker)
    @image = image
    @docker = docker

    repository = image
    if image.include? ":"
      image_split = image.split(":")

      repository = image_split[0]

      @tag = image_split[1]
    else
      @tag = "latest"
    end

    case repository.scan(/\//).count
    when 0, 1
      @registry = "docker.io"
      @repository = repository
    else
      @registry = repository[0..(repository.index('/') - 1)]
      @repository = repository[(repository.index('/') + 1)..(repository.length - 1)]
    end
  end

  def registry
    if @registry == "docker.io"
      "index.docker.io"
    else
      @registry
    end
  end

  def repository
    @repository
  end

  def tag
    @tag
  end

  def digest
    if not @digest.nil?
      @digest
    end

    config_dir = Dir.mktmpdir(nil, Dir.pwd)
    begin
      File.write("#{config_dir}/config.json", '{ "experimental": "enabled" }')
      manifest_cmd = "'#{@docker}' --config '#{config_dir}' manifest inspect --verbose '#{@image}'"
      @digest = Open3.popen3(manifest_cmd) do |_, stdout, stderr, wait_thr|
        manifest_str = stdout.read
        raise stderr.read unless wait_thr.value.success?

        manifest = JSON.parse(manifest_str)
        manifest['Descriptor']['digest']
      end
    ensure
      FileUtils.remove_entry config_dir
    end

    @digest
  end
end

class Target
  def initialize(name, registry, repository, digest, indent)
    @name = name
    @registry = registry
    @repository = repository
    @digest = digest
    @indent = indent
  end

  def generate
    hunk = StringIO.new
    hunk << "#{@indent}container_pull(\n"
    hunk << "#{@indent}    name = \"#{@name}\",\n"
    hunk << "#{@indent}    registry = \"#{@registry}\",\n"
    hunk << "#{@indent}    repository = \"#{@repository}\",\n"
    hunk << "#{@indent}    digest = \"#{@digest}\",\n"
    hunk << "#{@indent})\n"
    hunk.string
  end
end

image_list.each do |image_str|
  image = Image.new(image_str, docker)
  indent = "    "
  target = Target.new(
    name_from_repository(image.repository),
    image.registry,
    image.repository,
    image.digest,
    indent)

  output << target.generate
  output << "\n"
end

workspace_root = File.read(workspace_root_file).chomp
output_path = File.join(workspace_root, output_relative_path).gsub!("/", File::SEPARATOR)
File.write(output_path, output.string)
