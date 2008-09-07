require 'rubygems'
require 'sinatra'
require 'haml'
require 'grit/lib/grit'

$git = Grit::Repo.new('/opt/git/empass.git')

get '/' do
  @commits = $git.commits
  haml :index
end

template :index do
"
-@commits.each do |commit|
  .commit
    .sha= commit.id
    .author
      = commit.author.name
      = commit.author.email
    .date= commit.date
    .message= commit.message
"
end

get('/style.css') { sass :stylesheet }
template :stylesheet do
"
.commit
  background: #eee
  margin: 5px
  padding: 10px
  border: 1px solid #666
  .message
    padding: 8px
  .sha
    font-family: monospace"
end

# MAIN LAYOUT

template :layout do
"!!! 4.1
%head
  %link{:rel =>'stylesheet', :type => 'text/css', :href => '/style.css'}
%body
  =yield
"
end